% arara: lualatex

\documentclass[11pt, a4paper]{article}
\title{\Huge{}}
\date{}

%----- PACKAGES -----

\def\MLine#1{\par\hspace*{-\leftmargin}\parbox{\textwidth}{\[#1\]}}
\usepackage{graphicx,fontspec,caption}
\usepackage[margin=1.1in,bottom=0.5in]{geometry}
\graphicspath{ {./images/} }

%----- OPTS -----

\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}
\setmainfont{Ubuntu}
\pagenumbering{gobble}
\addtolength{\topmargin}{-.95in}
\captionsetup[figure]{labelformat=empty}

\begin{document}
\maketitle\vspace{-45pt}

%----- BEGIN DOCUMENT -----

\end{document}
