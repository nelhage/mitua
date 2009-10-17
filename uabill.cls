\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uabill}[2009/10/17 MIT Undergraduate Association Senate Bill Class]
\LoadClass[letterpaper,11pt]{article}
\RequirePackage{fancyhdr}
\RequirePackage{hanging}
\RequirePackage{ifthen}
\RequirePackage{graphicx}
\RequirePackage{ulem}
\RequirePackage{multicol}
\RequirePackage[left=1in,bottom=1.5in]{geometry}

\DeclareOption{bill}{\@billtrue}
\DeclareOption{resolution}{\@resolutiontrue}

\DeclareOption{twocolsponsors}{\@twocolsponsorstrue}

\parindent=0em
\parskip=\baselineskip
\headheight=70pt

\newcommand{\@hang}{\hangpara{2em}{1}}

\pagestyle{fancy}
\lhead{
  \parbox{0.75in}{\includegraphics[width=0.75in]{mitseal}\vspace*{1ex}}
  \parbox{2in}{\vspace*{0.75in}\vspace*{-2\baselineskip}
    \small \textsc{Undergraduate Association \\ Office of the Speaker}}}
\rhead{
  \parbox{3in}{
    \raggedleft
    \vspace*{0.75in}\vspace*{-2\baselineskip}
    \small \textsc{Cambridge, Massachusetts 02139 \\ Room W20-401 (617) 253-2696}}}

\newcommand{\@senate}{1\ClassError{uabill}{The session of Senate must be passed in}}
\newcommand{\senate}[1]{\renewcommand{\@senate}{#1}}

\newcommand{\@bill}{}
\newcommand{\bill}[1]{\renewcommand{\@bill}{#1}}

% Array support
\newcommand\declarearray[1]{
	\expandafter\newcommand\csname#1\endcsname[1]{%
\ifcsname array@#1@##1\endcsname%
\csname array@#1@##1\endcsname%
\else%
\ClassError{uabill}{Dereferenced undefined element ##1 of #1}%
\fi
}
	\expandafter\newcommand\csname set#1\endcsname[2]{\expandafter\def\csname array@#1@##1\endcsname{##2}}
}

% UA Officers
\declarearray{uapres}
\declarearray{uaspeaker}
% All
\setuapres{40}{Noah Jessop '09}
\setuaspeaker{40}{Jason Forte '09}
\setuapres{41}{Michael Bennie '10}
\setuaspeaker{41}{Paul Baranay '11}

\def\@president{\uapres{\@senate}}
\newcommand{\president}[1]{\renewcommand{\@president}{#1}}

\def\@speaker{\uaspeaker{\@senate}}
\newcommand{\speaker}[1]{\renewcommand{\@speaker}{#1}}

\AtBeginDocument{
  % Kludgey back-compat for old version which hardcoded the UAS 40
  % speaker and president.
  \ifnum\@senate=41
  \makeatletter
  \ifx\@speaker\empty
  \typeout{No speaker}
  \renewcommand{\@speaker}{Paul Baranay '11}
  \fi
  \ifx\@president\empty
  \renewcommand{\@president}{Michael Bennie '10}
  \fi
  \makeatother
  \fi
}

\cfoot{}

\renewcommand{\maketitle}{
  \begin{center}
    \huge \textbf{\@senate\ U.A.S. \@bill \\ \@title}
  \end{center}
}

\newcommand{\submitter}[2]{#1\\#2\\\nopagebreak\\\nopagebreak}

\def\@whereas{}
\newcommand{\whereas}[1]{
  \ifx\@whereas\empty\else
    \@whereas\ and\par
  \fi
  \def\@whereas{\@hang Whereas #1;}}
\newcommand{\@flushwhereas}{\@whereas\par}

\newcommand{\@billverb}{\ClassError{uabill}{Either the ``bill'' or ``resolution'' option is required}}
\newcommand{\@billtrue}{\renewcommand{\@billverb}{enacted}}
\newcommand{\@resolutiontrue}{\renewcommand{\@billverb}{resolved}}
\newcommand{\resolved}{
  \@flushwhereas
  \textbf{Be it \@billverb, by the Undergraduate Association assembled
    in Senate:}\par
}

\def\@that{}
\newcommand{\that}[1]{
  \ifx\@that\empty\else
    \@that; and\par
  \fi
  \def\@that{\@hang That #1}}
\newcommand{\@flushthat}{\@that. \par}

\newcommand{\@printauthor}{\@author}
\newcommand{\@twocolsponsorstrue}{\renewcommand{\@printauthor}{\begin{multicols}{2}\@author\end{multicols}}}

\newif\if@submitted

\newcommand{\submitted}{
  \@submittedtrue
  \@flushthat
  \par Respectfully submitted, \nopagebreak\par
  \@author 
  \vfill \nopagebreak\par\nopagebreak
  \newlength{\@speakerlen}
  \settowidth{\@speakerlen}{\@speaker \\ UA Senate Speaker}
  \newlength{\@presidentlen}
  \settowidth{\@presidentlen}{\@president \\ UA President}
  \begin{center}
    \parbox{\@speakerlen}{
      \centering
      \underline{\hspace{2in}} \\
      \@speaker \\
      UA Senate Speaker
      }
    \hfill
    \parbox{\@presidentlen}{
      \centering
      \underline{\hspace{2in}} \\
      \@president \\
      UA President
    }
  \end{center}
}

\AtEndDocument{
  \if@submitted\else
  \ClassWarningNoLine{uabill}{%
    You omitted a \protect\submitted\space from the end of your
    \MessageBreak document. Your document will be missing its footer}
  \fi
}

\ProcessOptions
