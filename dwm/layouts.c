static void tile(Monitor *m);
static void monocle(Monitor *m);
static void centeredmaster(Monitor *m);
static void col(Monitor *);
static void bstack(Monitor *m);

void
tile(Monitor *m)
{
	unsigned int i, n, h, mw, my, ty;
	float mfacts = 0, sfacts = 0;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++) {
		if (n < m->nmaster)
			mfacts += c->cfact;
		else
			sfacts += c->cfact;
	}
	if (n == 0)
		return;

	if (n > m->nmaster)
		mw = m->nmaster ? m->ww * m->mfact : 0;
	else
		mw = m->ww - m->gappx;
	for (i = 0, my = ty = m->gappx, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
			if (i < m->nmaster) {
			h = (m->wh - my) * (c->cfact / mfacts) - m->gappx;
			resize(c, m->wx + m->gappx, m->wy + my, mw - (2*c->bw) - m->gappx, h - (2*c->bw), 0);
			if (my + HEIGHT(c) + m->gappx < m->wh)
				my += HEIGHT(c) + m->gappx;
			mfacts -= c->cfact;
		} else {
			h = (m->wh - ty) * (c->cfact / sfacts) - m->gappx;
			resize(c, m->wx + mw + m->gappx, m->wy + ty, m->ww - mw - (2*c->bw) - 2*m->gappx, h - (2*c->bw), 0);
			if (ty + HEIGHT(c) + m->gappx < m->wh)
				ty += HEIGHT(c) + m->gappx;
			sfacts -= c->cfact;
		}
}

void
monocle(Monitor *m)
{
	unsigned int n = 0;
	Client *c;

	for (c = m->clients; c; c = c->next)
		if (ISVISIBLE(c))
			n++;
	if (n > 0) /* override layout symbol */
		snprintf(m->ltsymbol, sizeof m->ltsymbol, "[%d]", n);
	for (c = nexttiled(m->clients); c; c = nexttiled(c->next))
	//resize(c, m->wx, m->wy, m->ww - 2 * c->bw, m->wh - 2 * c->bw, 0);
	// Added gaps to monocle layout
	resize(c, m->wx + gappx, m->wy + gappx, m->ww - 2 * c->bw - gappx * 2, m->wh - 2 * c->bw - gappx * 2, 0);
}

void
centeredmaster(Monitor *m)
{
	unsigned int i, n, h, mw, mx, my, oty, ety, tw;
	float mfacts = 0, lfacts = 0, rfacts = 0;
	Client *c;

	/* count number of clients in the selected monitor */
	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++) {
		if (n < m->nmaster)
			mfacts += c->cfact;
		else if ((n - m->nmaster) % 2)
			lfacts += c->cfact;
		else
			rfacts += c->cfact;
	}
	if (n == 0)
		return;

	/* initialize areas */
	mw = m->ww;
	mx = 0;
	my = 0;
	tw = mw;

	if (n > m->nmaster) {
		/* go mfact box in the center if more than nmaster clients */
		mw = m->nmaster ? m->ww * m->mfact : 0;
		tw = m->ww - mw - gappx;

		if (n - m->nmaster > 1) {
			/* only one client */
			mx = (m->ww - mw) / 2;
			tw = (m->ww - mw) / 2;
		}
	}

	if (n < m->nmaster ) { // In case master clients goes out of range
		mw = m->ww - 2 * gappx;
		mx = gappx;
	}

	oty = 0;
	ety = 0;
	for (i = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
	if (i < m->nmaster) {
		// change i for client numbers
		// 1 client only
		h = (m->wh - my)  * (c->cfact / mfacts);
		if ( n - m->nmaster == 1 ){
			resize(c, m->wx + mx + gappx, m->wy + my + gappx , mw - (2*c->bw) - gappx, h - (2*c->bw) - gappx * 2, 0);
		} else if ( n - m->nmaster > 1 ){
			resize(c, m->wx + mx, m->wy + my + gappx , mw - (2*c->bw), h - (2*c->bw) - gappx * 2, 0);
		} else {
			resize(c, m->wx + mx + gappx, m->wy + my + gappx , mw - (2*c->bw) - gappx * 2, h - (2*c->bw) - gappx * 2, 0);
		}
		my += HEIGHT(c) + gappx;
		mfacts -= c->cfact;
	} else {
		/* stack clients are stacked vertically */
		if ((i - m->nmaster) % 2 ) { // Even clients
			// No master
			h = (m->wh - ety) * (c->cfact / lfacts);
			if ( n - m->nmaster == n ){
				resize(c, m->wx + gappx, m->wy + ety + gappx, tw - (2*c->bw) - gappx, h - (2*c->bw) - gappx * 2, 0);
			} else {
				resize(c, m->wx + gappx, m->wy + ety + gappx, tw - (2*c->bw) - gappx * 2, h - (2*c->bw) - gappx * 2, 0);
			}
			ety += HEIGHT(c) + gappx;
			lfacts -= c->cfact;
		} else { // Odd clients
			h = (m->wh - oty) * (c->cfact / rfacts);
			// 1 client only
			if ( n - m->nmaster == 1 ){
				resize(c, m->wx + mx + mw + gappx, m->wy + oty + gappx, tw - (2*c->bw) - gappx, h - (2*c->bw) - gappx * 2, 0);
			// No master
			} else {
				resize(c, m->wx + mx + mw + gappx, m->wy + oty + gappx, tw - (2*c->bw) - gappx * 2, h - (2*c->bw) - gappx * 2, 0);
			}
			oty += HEIGHT(c) + gappx;
			rfacts -= c->cfact;
		}
	}
}

void
col(Monitor *m) {
	unsigned int i, n, h, w, x, y, mw;
	float sfacts = 0;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++) {
		if ( n >= m->nmaster)
			sfacts += c->cfact;
	}
	if(n == 0)
		return;

	if(n > m->nmaster)
		mw = m->nmaster ? m->ww * m->mfact : 0;
	else
		mw = m->ww - m->gappx;

	for(i = 0, x = y = m->gappx, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++) {
		if(i < m->nmaster) {
			w = (mw - x) / (MIN(n, m->nmaster) - i);
			resize(c, x + m->wx, m->wy + m->gappx, w - (2*c->bw), m->wh - (2*c->bw) - 2*m->gappx, False);
			if (x + WIDTH(c) + m->gappx < m->ww)
				x += WIDTH(c) + m->gappx;
		} else {
			h = (m->wh - y) * (c->cfact / sfacts) - m->gappx;
			resize(c, x + m->wx, m->wy + y, m->ww - x - (2*c->bw) - m->gappx, h - (2*c->bw), False);
			if (y + HEIGHT(c) + m->gappx < m->wh) {
				y += HEIGHT(c) + m->gappx;
				sfacts -= c->cfact;
			}
		}
	}
}

void
bstack(Monitor *m)
{
	unsigned int i, n, w, mh, mx, tx;
	float mfacts = 0, sfacts = 0;
	Client *c;

	for (n = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), n++) {
		if (n < m->nmaster)
			mfacts += c->cfact;
		else
			sfacts += c->cfact;
	}
	if (n == 0)
		return;
	if(n == 1){
		c = nexttiled(m->clients);
		resize(c, m->wx + gappx, m->wy + gappx, m->ww - 2 * c->bw - 2 * gappx, m->wh - 2 * c->bw - 2 * gappx, 0);
		return;
	}

	if (n > m->nmaster)
		mh = m->nmaster ? m->wh * m->mfact : 0;
	else
		mh = m->wh;
	for (i = 0, mx = tx = 0, c = nexttiled(m->clients); c; c = nexttiled(c->next), i++)
		if (i < m->nmaster) {
			w = (m->ww - mx) * (c->cfact / mfacts);
			resize(c, m->wx + mx + gappx, m->wy + gappx, w - (2*c->bw) - 2 * gappx, mh - 2*c->bw - 2 * gappx, 0);
			if(mx + WIDTH(c) < m->mw)
				mx += WIDTH(c) + gappx;
			mfacts -= c->cfact;
		} else {
			w = (m->ww - tx) * (c->cfact / sfacts);
			if ( m->nmaster == 0 ) {
				resize(c, m->wx + tx + gappx, m->wy + mh + gappx, w - (2*c->bw) - 2 * gappx, m->wh - mh - 2*(c->bw) - 2 * gappx , 0);
			} else {
				resize(c, m->wx + tx + gappx, m->wy + mh, w - (2*c->bw) - 2 * gappx, m->wh - mh - 2*(c->bw) - gappx, 0);
			}
			if(tx + WIDTH(c) < m->mw)
				tx += WIDTH(c) + gappx ;
			sfacts -= c->cfact;
		}
}

void
fibonacci(Monitor *mon, int s) {
	unsigned int i, n, nx, ny, nw, nh;
	Client *c;

	for(n = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next), n++);

	if(n == 0)
		return;

	nx = mon->wx + gappx;
	ny = 0;
	nw = mon->ww - 2*gappx;
	nh = mon->wh - 2*gappx;

	for(i = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next)) {
		if((i % 2 && nh / 2 > 2 * c->bw)
		   || (!(i % 2) && nw / 2 > 2 * c->bw)) {
			if(i < n - 1) {
				if(i % 2)
					nh = (nh - gappx) / 2;
				else
					nw = (nw - gappx) / 2;
				if((i % 4) == 2 && !s)
					nx += nw + gappx;
				else if((i % 4) == 3 && !s)
					ny += nh + gappx;
			}
			if((i % 4) == 0) {
				if(s)
					ny += nh + gappx;
				else
					ny -= nh + gappx;
			}
			else if((i % 4) == 1)
				nx += nw + gappx;
			else if((i % 4) == 2)
				ny += nh + gappx;
			else if((i % 4) == 3) {
				if(s)
					nx += nw + gappx;
				else
					nx -= nw + gappx;
			}
			if(i == 0)
			{
				if(n != 1)
					nw = (mon->ww - 3*gappx) * mon->mfact;
				ny = mon->wy + gappx;
			}
			else if(i == 1)
				nw = mon->ww - nw - 3*gappx;
			i++;
		}
		resize(c, nx, ny, nw - 2 * c->bw, nh - 2 * c->bw, False);
	}
}

void
dwindle(Monitor *mon) {
	fibonacci(mon, 1);
}

void
spiral(Monitor *mon) {
	fibonacci(mon, 0);
}
