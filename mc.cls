\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mc}[2014/08/16 Example LaTeX class]
 
\newcommand{\headlinecolor}{\normalcolor}
\LoadClass{article}
\RequirePackage{xcolor}
\RequirePackage{geometry}
\RequirePackage{amsmath}
\RequirePackage[titles]{tocloft}
\RequirePackage[breakable,skins,listings]{tcolorbox}
\tcbuselibrary{skins}
\usepackage{mathtools}
\usepackage{bm}
\usepackage{hyperref}
 
\RequirePackage{tikz}
\RequirePackage[utf8]{inputenc}
\RequirePackage{calc}
\RequirePackage{ifthen}


\newcommand\Jupyterimport[1]{{\small\subimport{Jupyter/}{#1.tex}}}

\definecolor{mybluei}{RGB}{0,33,78}
\definecolor{myblueii}{RGB}{93,179,230}
\definecolor{myblueiii}{RGB}{156,183,212}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
 
\DeclareOption{handout}{
\geometry{paper=a5paper,landscape}
\AtBeginDocument{\raggedright}
}


\renewcommand\labelitemi{$\triangleright$}


\tcbset{discussionbox/.style={enhanced,colback=white,colframe=green!65!black,
enlarge top by=10mm,
overlay={%
\path[fill=blue!65,line width=.4mm] (frame.north west)--++(67mm,0)coordinate(n2)--++(0,8mm)--++(-70mm,0) arc (-90:90:-4mm)--cycle;
\node at ([shift={(30mm,4mm)}]frame.north west){\color{white}{\textbf{\sffamily CLASS ROOM DISCUSSION}}};
\path[fill=green!65!blue] ([xshift=.4mm]n2)--++(0,8mm)--++(7mm,0)--++(0,-8mm)--cycle;
\node at ([shift={(4mm,4mm)}]n2){\color{white}{\textbf{\sffamily \thedcounter}}};
\node at ([shift={(18mm,4mm)}]n2){\itshape\textbf{\sffamily }};
}}}

\tcbset{definitionbox/.style={enhanced,colback=white,colframe=red!65!black,
enlarge top by=10mm,
overlay={%
\path[fill=red!65,line width=.4mm] (frame.north west)--++(32mm,0)coordinate(n2)--++(0,8mm)--++(-35mm,0) arc (-90:90:-4mm)--cycle;
\node at ([shift={(12mm,4mm)}]frame.north west){\color{white}{\textbf{\sffamily DEFINITION}}};
\path[fill=orange!65!blue] ([xshift=.4mm]n2)--++(0,8mm)--++(7mm,0)--++(0,-8mm)--cycle;
\node at ([shift={(4mm,4mm)}]n2){\color{white}{\textbf{\sffamily \thedfcounter}}};
\node at ([shift={(60mm,4mm) }]n2){\parbox{10cm}{\itshape\textbf{\sffamily \mycontent}}}; 
}}}

\tcbset{theorembox/.style={enhanced,colback=white,colframe=orange!65!black,
enlarge top by=10mm,
overlay={%
\path[fill=yellow!65!green,line width=.4mm] (frame.north west)--++(32mm,0)coordinate(n2)--++(0,8mm)--++(-35mm,0) arc (-90:90:-4mm)--cycle;
\node at ([shift={(12mm,4mm)}]frame.north west){\color{black}{\textbf{\sffamily THEOREM}}};
\path[fill=orange!65!black] ([xshift=.4mm]n2)--++(0,8mm)--++(7mm,0)--++(0,-8mm)--cycle;
\node at ([shift={(4mm,4mm)}]n2){\color{white}{\textbf{\sffamily \thetcounter}}};
\node at ([shift={(60mm,4mm) }]n2){\parbox{10cm}{\itshape\textbf{\sffamily \mycontent}}};
}}}






\ProcessOptions\relax
\newlength\bl
\setlength\bl\baselineskip
\renewcommand{\normalsize}{\fontsize{14}{16}\selectfont}
\newcommand{\topbox}[1]{\raisebox{.5\bl-\height}{#1}}
\newcommand{\ftopbox}[1]{\framebox{\topbox{{#1}}}}
\setcounter{secnumdepth}{3}
\def\minus{%
  \setbox0=\hbox{-}%
  \vcenter{%
    \hrule width\wd0 height \the\fontdimen8\textfont3%
  }%
}

\newcommand\rbox[1]{{%
\setlength\parfillskip{0pt}%
\hrulefill
\makebox[0pt]{#1}%
\hrulefill
\par
\bigskip}}
\setlength\parindent{0pt}
%\newenvironment{sideimage}[1]{
%\begin{tabularx}{\textwidth}{@{}lX@{}|}
%  \topbox{#1}  &}{\end{minipage}\end{tabularx}}

%\DeclareMathOperator{\D}{D}
%\DeclareMathOperator{\dif}{d}
\newcommand{\Dif}{\mathop{}\!\mathrm{D}}
\newcommand{\dif}{\mathop{}\!\mathrm{d}}
%\newcommand{\mod}{\mathop{}\!\mathrm{mod}}

\newcommand{\od}[3][]{
\ifthenelse{\equal{#1}{}}{
\frac{\dif #2}{\dif #3}}{
\frac{\dif^{#1} #2}{\dif #3^{#1}}}
}


\newcommand{\pd}[3][]{
\ifthenelse{\equal{#1}{}}{
\frac{\partial #2}{\partial #3}}
{\frac{\partial^{#1} #2}{\partial #3^{#1}}
}}

\newcommand{\eqdef}{\stackrel{\rm def}{=}}
\newcommand{\eqbdef}{\stackrel{.}{=}}
\newcommand{\eqbnot}{\stackrel{\text{notation}}{=}}
\renewcommand\vec[1]{\boldsymbol{#1}}

\makeatletter
\newcommand\mathsquared[2][black]{%
  \tikzstyle{mathbox}=[#1]
  \mathpalette\@mathsquared{#2}%
}
\newcommand\@mathsquared[2]{%
  \tikz[baseline=(math.base)] \node[draw,mathbox,inner sep=5pt] (math) {$\m@th#1#2$};%
}



\newcounter{dcounter}
%\newcounter{dfcounter}
%\newcounter{tcounter}
\newlistof{dfcounter}{Definitions}{List of definitions}
\newlistof{tcounter}{Theorems}{List of theorems}
%\AtEndDocument{
%\listofdfcounter
%\listoftcounter
%}
\newenvironment{cdiscussion}
{\begin{tcolorbox}[discussionbox,step=dcounter]}
{\end{tcolorbox}}

\newenvironment{definition}[1]
{\newcommand{\mycontent}{#1}\begin{tcolorbox}[definitionbox,step=dfcounter]%
\addcontentsline{Definitions}{dfcounter}{\thedfcounter:\quad#1}}% add item to list
{\end{tcolorbox}}

 \newenvironment{theorem}[1]
{\newcommand{\mycontent}{#1}\begin{tcolorbox}[theorembox,step=tcounter]%
\addcontentsline{Theorems}{tcounter}{\thetcounter:\quad#1}}% add item to list
{\end{tcolorbox}}


\newcommand{\ddt}[1]{\od{#1}{t}}

\newcommand{\bcd}{\begin{cdiscussion}}
\newcommand{\ecd}{\end{cdiscussion}}


\newcommand{\bd}[1]{\begin{definition}{#1}}
\newcommand{\ed}{\end{definition}}

\newcommand{\eop}{\hfill $\square$ }

\newcommand{\bt}[1]{\begin{theorem}{#1}}
\newcommand{\et}{\end{theorem}}

\makeatother


\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}



\newcommand\vectort[2]{\begin{pmatrix}#1 \\ #2\end{pmatrix}}

\definecolor{turquoiseblue}{rgb}{0.0, 1.0, 0.94}
\definecolor{uclbleunuit}{rgb}{0, 0.1289, 0.3047}
\definecolor{uclcyan}{rgb}{0.3633, 0.6992 , 0.8984}
\definecolor{uclbleugris}{rgb}{0.6094,.7148,0.8281}

\newcommand{\uclouvainlogo}[3]{
\begin{scope}[shift={(#1,#2)}, scale=#3]
    \fill[fill=uclcyan] (0,0) rectangle (0.75,0.25);
    \fill[fill=uclcyan] (0,0) rectangle (0.25,1.00);
    \fill[fill=uclbleunuit] (0.25,0.25) rectangle (0.75,1.00);
    \fill[fill=uclbleugris] (0.75,0.25) rectangle (1.00,1.00);
  \end{scope}
}


\makeatletter

\newcommand{\@coursecode}{coursecode}
\renewcommand{\@title}{title}
\newcommand{\@academicyear}{academicyear}
\newcommand{\@documenttype}{documenttype}
\newcommand{\@coursetitle}{coursetitle}
\newcommand{\@school}{UCLouvain -- Facult\'e des Sciences}
\newcommand{\coursecode}[1]{\renewcommand{\@coursecode}{#1}}
\newcommand{\coursetitle}[1]{\renewcommand{\@coursetitle}{#1}}
\newcommand{\documenttype}[1]{\renewcommand{\@documenttype}{#1}}
\newcommand{\academicyear}[1]{\renewcommand{\@academicyear}{#1}}
\newcommand{\school}[1]{\renewcommand{\@school}{#1}}
\renewcommand{\titlepage}{%
\begingroup% 
\thispagestyle{empty}
%\hpace{0.4\textwidth}
%\hfill
\hspace{0.4\textwidth}%
\parbox{0.8\textwidth}{%
\begin{flushright}
\textcolor{uclbleunuit}{
{\Huge\scshape\sf \@coursetitle} \\ [\baselineskip]
{\Huge\scshape\sf \@coursecode} \\ [\baselineskip]
}
 \end{flushright}
}\\ [\baselineskip] 
%parbox \\

\hspace{0.4\textwidth}%
\colorbox{uclbleunuit}{%
  \parbox{0.8\textwidth}{%
  \setlength{\parskip}{4\bigskipamount plus \smallskipamount minus \smallskipamount}
  \vspace{6cm}
  \begin{flushright}
  \textcolor{white}{%
{\large\scshape\sf \@documenttype} \\[\baselineskip]
{\large\scshape\sf \@academicyear} \\[\baselineskip]
}
\textcolor{uclcyan}{%
{\large\scshape\sf \@author} \\ [\baselineskip]
{\large\scshape\sf Facult\'e des Sciences}% %\\ [\baselineskip]
}
\end{flushright}
}
}
\vspace{2.0cm}
\\
\begin{tikzpicture}
  \uclouvainlogo{0}{0}{0.6pt}
\end{tikzpicture} {\Huge\sf{UCLouvain}}
\hfill
\endgroup}
\makeatother
