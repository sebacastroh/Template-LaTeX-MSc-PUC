\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pucthesis}[2014/10/31 PUC thesis]

\LoadClass[oneside,reqno,12pt]{amsbook}

\def\pdftex@true{0}    % Assume by default the graphics package uses dvips.
\DeclareOption{pdftex}{%
  \PassOptionsToPackage{pdftex}{graphicx}%
  \def\pdftex@true{1}% % If user employs pdflatex, include PDF images below.
}

\def\spanish@true{0}    % Assume by default the thesis is written in english
\DeclareOption{spanish}{%
  \def\spanish@true{1}% % Change to spanish names and cover
}

\ProcessOptions\relax

% PDF pages have the same value
\if \pdftex@true 1
      \setlength{\pdfpageheight}{\paperheight}
      \setlength{\pdfpagewidth}{\paperwidth}
\else
       \special{papersize=8.5in,11in}
\fi

\newif\if@nopunc\@nopuncfalse

% Space before and after the thesis' title in first and second page
\newlength{\beftitle}
\newlength{\afttitle}

\setlength{\beftitle}{105\p@\@plus24\p@}
\setlength{\afttitle}{65\p@}

% By default, LaTeX uses margins equals to 25mm (top and odd)
% -25mm + 40mm = 15mm
% Top
\topmargin -25mm
\headheight 20mm
\headsep 20mm
% Left side
\oddsidemargin 15mm

% Text box
\setlength{\textheight}{214.4mm}
\setlength{\textwidth}{150.9mm}

% Vertical space between lines and paragraphs
\renewcommand{\baselinestretch}{1.5}
\parskip 10pt

% Vertical space between text and floats
\RequirePackage{caption}
\RequirePackage{setspace}

\captionsetup[boxed]{skip=0.7\baselineskip plus 0pt minus 0pt}
%\captionsetup{skip=0\baselineskip plus 0pt minus 0pt}

\setlength{\textfloatsep}{0.9\baselineskip plus 0pt minus 0pt}
\setlength{\floatsep}{0.9\baselineskip plus 0pt minus 0pt}
\setlength{\intextsep}{0.9\baselineskip plus 0pt minus 0pt}

% Only one of following options, NOT BOTH!
\setlength{\abovecaptionskip}{0.7\baselineskip plus 0pt minus 0pt}
\setlength{\belowcaptionskip}{0.7\baselineskip plus 0pt minus 0pt}

% Remove chapter from header
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{                                                                  %
\fancyhf{}                                                                                            % clear all header and footer fields
\fancyfoot[C]{\fontsize{11pt}{11pt}\selectfont\thepage} % except the center
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
}
\pagestyle{plain}

\newlength{\auxdist}

% Add list of contents, figures and tables
\if \spanish@true 1
	\def\contentsname{\'INDICE DE CONTENIDOS} %{\'Indice de Contenidos}
	\def\listfigurename{\'INDICE DE FIGURAS}          %{\'Indice de Figuras}
	\def\listtablename{\'INDICE DE TABLAS}              %{\'Indice de Tablas}
	\def\refname{REFERENCIAS}
	\def\bibname{REFERENCIAS}
	\def\appendixname{ANEXO}                                    %{Anexo}
	\def\proofname{Prueba}
	\def\tablename{Tabla}
	\def\figurename{Figura}
\else
	\def\contentsname{TABLE OF CONTENTS}         %{Table of Contents}
	\def\listfigurename{LIST OF FIGURES}                  %{List of Figures}
	\def\listtablename{LIST OF TABLES}                      %{List of Tables}
	\def\refname{REFERENCES}
	\def\bibname{REFERENCES}
	\def\appendixname{APPENDIX}                              %{Appendix}
	\def\proofname{Proof}
\fi

\def\chaptername{}
\def\thechapter{\@arabic\c@chapter} % Number chapters with arabic numerals.

\def\appendix{\par                                      %
  \c@chapter\z@ \c@section\z@            %
  \let\chaptername\appendixname
  \def\thesection{\@Alph\c@section} % Number appendix with uppercase letters.
  \numberwithin{figure}{section}
  \numberwithin{table}{section}
  \numberwithin{equation}{section}
  \newpage
  \chapter*{\appendixname}
  \phantom{.}
  \vspace{8cm}
  \hspace{5.7cm}
  \MakeUppercase{{\fontsize{12pt}{1em}\selectfont \bfseries\appendixname}}
}

\numberwithin{section}{chapter}

% Table of contents lines

\c@tocdepth=2   % put subsections in toc.
\def\@toclevel{0} % Turn of error if \listoffigures not preceeded by \chap.

\def\l@chapter{\@tocline{0}{8pt plus1pt}{0pt}{22pt}{}} % 22pt
\def\l@subsection{\@tocline{2}{0pt}{2pc}{3.5pc}{}}
\def\l@figure{\@tocline{1}{8pt plus1pt}{0pt}{30pt}{}}
\let\l@table=\l@figure

\def\@dotsep{4.5}

\def\@tocline#1#2#3#4#5#6#7{\relax
	\ifnum #1>\c@tocdepth % then omit
	\else
		\par \addpenalty\@secpenalty\addvspace{#2}%
		\begingroup \hyphenpenalty\@M
		\@ifempty{#4}{%
			\@tempdima\csname r@tocindent\number#1\endcsname\relax % 
		}{%
			\@tempdima#4\relax
		}%
		\parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
		\rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
		#5 \leavevmode\hskip-\@tempdima #6\relax
		\ifnum #1<1 % do nothing
			\hfill\hbox to\@pnumwidth{\@tocpagenum{\expandafter\expandafter{#7}}}\par
		\else                % add a dotline for sections and lower
			\nobreak\leaders\hbox{$\m@th \mkern \@dotsep mu.\mkern \@dotsep mu$}
			\hfill\hbox to\@pnumwidth{\@tocpagenum{#7}}\par
		\fi
		\nobreak
		\endgroup
	\fi
}

%%%

% Chapter titles

\def\@tocwriteb#1#2#3{%                                                                                                                                                                                                                                                 
  \begingroup
    \def\@tocline##1##2##3##4##5##6{%                                                                                                                                                                                                                                   
      \ifnum##1>\c@tocdepth
      \else \sbox\z@{##5\let\indentlabel\@tochangmeasure##6}\fi}%                                                                                                                                                                                                       
    \csname l@#2\endcsname{#1{\csname#2name\endcsname}{\@secnumber}{}}%                                                                                                                                                                                                 
  \endgroup
\ifx\chaptername\appendixname
  \addcontentsline{toc}{#2}%                                                                                                                                                                                                                                            
    {\protect#1{}{\@secnumber}{#3}}
\else
  \addcontentsline{toc}{#2}%                                                                                                                                                                                                                                            
    {\protect#1{\csname#2name\endcsname}{\@secnumber}{#3}}
\fi
}


\renewcommand{\tocappendix}[3]{%                                                                                                                                                                                                                                          
  \indentlabel{#1\@ifnotempty{#2}{ #2}}#3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

\def\@chapter[#1]#2{\refstepcounter{chapter}%
  \ifnum\c@secnumdepth<\z@ \let\@secnumber\@empty
  \else \let\@secnumber\thechapter \fi
  \typeout{\chaptername\space\@secnumber}%
  \def\@toclevel{0}%
  \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#1}%
  \else \@tocwriteb\tocchapter{chapter}{#1}\fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makechapterhead{#2}\@afterheading}

\def\@schapter#1{\typeout{#1}%
  \let\@secnumber\@empty
  \def\@toclevel{0}%
  \ifx\chaptername\appendixname \@tocwriteb\tocappendix{chapter}{#1}%
  \else \@tocwriteb\tocchapter{chapter}{#1}\fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \@makeschapterhead{#1}\@afterheading}

\def\NoChapterPageNumber{%
  \def\chapter{\cleardoublepage \thispagestyle{plain} \pagestyle{plain}
    \global\@topnum\z@
    \secdef\@chapter\@schapter}
}

%-----------------------

\def\chapter{\cleardoublepage \thispagestyle{plain} \pagestyle{plain}
  \global\@topnum\z@
  \secdef\@chapter\@schapter
}

%----------------------
% Options for INTRODUCTION, CHAPTERS and APPENDIX
\def\@makechapterhead#1{\global\topskip 11mm\relax
  \begingroup\normalfont\bfseries
      \rlap{\vbox to\z@{\vss{\mdseries\@normalsize
  \ifx \chaptername\empty
  \settowidth{\auxdist}{\bfseries \thechapter.\enspace}
  \addtolength{\auxdist}{-\textwidth}
  \setlength{\auxdist}{-\auxdist}
  {\noindent\bfseries
  \thechapter.\enspace\parbox[t]{\auxdist}{\uppercase{#1}}}
  \else
  \settowidth{\auxdist}{\bfseries \chaptername\space \thechapter.\enspace}
  \addtolength{\auxdist}{-\textwidth}
  \setlength{\auxdist}{-\auxdist}
  {\noindent\bfseries \expandafter\MakeUppercase\expandafter{\chaptername}\space \thechapter.\enspace\parbox[t]{\auxdist}{\uppercase{#1}}}
  \fi
  \enspace}
            }}
  \vskip -10pt%22pt
  \par
  \endgroup
  \skip@16\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@
}

% Options for TOC, LOF, LOT, ACKNOWLEDGMENTS and ABSTRACT
\def\@makeschapterhead#1{\global\topskip 0pc\relax
  \ifx\chaptername\appendixname
  \else
  	\begingroup\normalfont\bfseries
	\centering\expandafter\MakeUppercase\expandafter{#1}%\uppercase{#1}
	 \vskip 22pt
	\par
	\endgroup
	\ifx#1\contentsname\skip@36\p@
	\else
		\ifx#1\bibname\skip@36\p@
         		\else
                 		\skip@36\p@ %
	        \fi
	\fi
  \fi
\advance\skip@-\normalbaselineskip
  \vskip\skip@ 
}

%--------------------------------------------

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \edef\@toclevel{\ifnum#2=\@m 0\else\number#2\fi}%
  \ifnum #2>\c@secnumdepth \let\@secnumber\@empty
  \else \@xp\let\@xp\@secnumber\csname the#1\endcsname\fi
 \ifnum #2>\c@secnumdepth
   \let\@svsec\@empty
 \else
    \refstepcounter{#1}%
    \edef\@svsec{\ifnum#2<\@m
       \@ifundefined{#1name}{}{%
         \ignorespaces\csname #1name\endcsname\space}\fi
       \@nx\textup{%
         \csname the#1\endcsname.}\enspace
    }%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@ % then this is not a run-in section heading
    \begingroup #6\relax
	\ifx\chaptername\appendixname
	\ifnum#2<2
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M \expandafter\MakeUppercase\expandafter{#8} \par}%
	\else
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8 \par}%
	\fi
	\else
    \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty\@M #8 \par}%
	\fi
    \endgroup
  \csname #1mark\endcsname{#7}%
    \ifnum#2>\@m \else \@tocwrite{#1}{#7}\fi
  \else
  \def\@svsechd{#6\hskip #3\@svsec
    \@ifnotempty{#8}{\ignorespaces#8\unskip\if@nopunc\else\@addpunct.\fi}
    \ifnum#2>\@m\else\@tocwrite{#1}{#7}\fi
  }%
  \fi
  \global\@nobreaktrue
  \@xsect{#5}}

%%



% Adjust space before and after SECTIONS, SUBSECTIONS, SUBSUBSECTIONS, PARAGRAPH and SUBPARAGRAPH
\def\section{\@startsection{section}{1}%
  {\z@}{10pt plus 0pt minus 0pt}{.5\linespacing}% .7\linespacing\@plus\linespacing
  {\normalfont\bfseries}}

\def\subsection{\@startsection{subsection}{2}%
  \z@{10pt plus 0pt minus 0pt}{.1\linespacing}% .5\linespacing\@plus.5\linespacing
  {\normalfont\bfseries}}

\def\subsubsection{\@startsection{subsubsection}{3}%
  \z@{10pt plus 0pt minus 0pt}{.01\linespacing}% .0\linespacing\@plus.2\linespacing
  {\normalfont\bfseries}}

\def\paragraph{\@startsection{paragraph}{4}%
  \z@{-\fontdimen2\font}
  \normalfont}

\def\subparagraph{\@startsection{subparagraph}{5}%
  \z@\z@{-\fontdimen2\font}
  \normalfont}

%      Set \topsep to 0 in \@listI.
\def\@listI{\leftmargin\leftmargini
  \parsep\z@skip \topsep\z@skip \itemsep\z@skip}
\let\@listi\@listI
\@listi

%
\let\sectionmark\@gobble % Just to have chapter name...

          
\def\sectionrunhead#1#2#3{%
  \@ifnotempty{#2}{{#1 %\thechapter.
#2.}\@ifnotempty{#3}{\hskip1em}}
  \def\@tempa{#3}%
  \ifx\@empty\@tempa\else\uppercasenonmath\@tempa\@tempa\fi}

%%


%%

\let\@mkboth\markboth

%
%      LIST ENVIRONMENTS
%
%      Change first-level `enumerate' numbering style from arabic
%      to roman numeral.
\renewcommand{\labelenumi}{(\roman{enumi})}
%
%      Change \enumerate and \itemize to increase \partopsep.
\def\enumerate{\ifnum \@enumdepth >3 \@toodeep\else
      \advance\@enumdepth \@ne
      \edef\@enumctr{enum\romannumeral\the\@enumdepth}\list
      {\csname label\@enumctr\endcsname}{\usecounter
    {\@enumctr}\partopsep6\p@\def\makelabel##1{\hss\llap{\upshape##1}}}\fi}
%
\def\itemize{\ifnum\@itemdepth>3 \@toodeep
  \else \advance\@itemdepth\@ne
  \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
  \list{\csname\@itemitem\endcsname}%
  {\partopsep6\p@\def\makelabel##1{\hss\llap{\upshape##1}}}\fi}
%

%%%%%%%%%%%%%%%%%%%%%%%%%-------page i-iii ------%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------------------------------------------------%
%
%      TOPMATTER 
%
%      In \@maketitle we make the following changes:
%
%      \topskip --> 7pc(=84\p@) - headheight - headsep
%      title --> 10/14, uppercased
%      author --> aboveskip = 32pt, normalsize instead of small

\def\@maketitle{%
\clearpage  \thispagestyle{empty}  
\begingroup
  \normalfont\normalsize
  \topskip0\p@  % 
  \advance\topskip-\headsep \advance\topskip-\headheight
  \vskip12\p@\@plus12\p@
  \vspace*{-20mm}
  %%
  %% University/School/Department
  %%
  \vtop{%\centering
       {%
       \noindent
       %\parbox[t]{70pt}{\rule[-48pt]{72pt}{72pt}}
%       \raisebox{-22.13mm}[0em][0em]
%       {            
        %\hspace{80pt}
        %    \raisebox{29.38mm}[0em][0em]{%
        %                 \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        % --- Draw vertical left edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[-\textheight]{.0pt}{\textheight}}\\[-\normalbaselineskip]
        % --- Draw horizontal top edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[0pt]{\textwidth}{.0pt}}\\[-\normalbaselineskip]
        % --- Draw vertical decorative line ---
        \hspace*{80pt}%
        %\rule[0em]{80pt}{0pt}%       
        % Note: Must use a trailing '%' 
        % otherwise a small space will be added due to the line feed.
        \vspace*{-4mm}%
        \setlength{\auxdist}{\textheight}%
        \addtolength{\auxdist}{19mm}%
        \raisebox{4mm}[0em][0em]{%
                         \rule[-\auxdist]{.5pt}{\auxdist}}\\[-0\normalbaselineskip]
        \hspace*{-7.5mm}% shif left half 13mm-off-margin
        \parbox{80pt}
        {\centering %\rule[0em]{80pt}{1ex}\\
            \if \pdftex@true 1 % Use PDF version if using pdflatex
            \includegraphics*[width=23mm]{./figures/LogoUC.pdf}\\[.2\normalbaselineskip]
            \else% Use PS version by default (dvips).
            \includegraphics*[width=23mm]{./figures/LogoUC.ps} \\[.2\normalbaselineskip] % ,height=30.38mm
            \fi 
%            \raisebox{29.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
%            \raisebox{17.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        }%
%       }
       \hspace{7.5mm}% shif right to compensante left-shift and 13mm-off-margin
       \hspace{20pt}%
       \parbox{.75\textwidth}{%parbox 2
       \@university\\
       \@school%\\
       \ifx\@empty\@department {}%{Department of .........}
       \else{\\\@department}\fi}\\ %end parbox 2
       % --- Draw horizontal decorative line ---
       \setlength{\auxdist}{\textwidth}%
       \addtolength{\auxdist}{13mm}%
       \addtolength{\auxdist}{15mm}%
       \hspace*{-13mm}%
       \rule[0pt]{\auxdist}{.5pt}
       }%end centering
     } %end vtop
  \vskip\beftitle %  \vskip105\p@\@plus24\p@
  %%
  %% Title
  %%
  \setlength{\auxdist}{\textwidth}%
  \addtolength{\auxdist}{-120pt}%
  \addtolength{\auxdist}{15mm}%
  \vtop{%\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       \uppercasenonmath{\@title}
       \bfseries\Large%\LARGE
       \@title\@@par}%end parbox
       }%end centering
     % \global\dimen@i\prevdepth
     }%end vtop
  \prevdepth\dimen@i
  \vskip\afttitle %  \vskip65\p@%
  %%
  %% Author(s)
  %%
  %\hspace{80pt}
  %\parbox[t]{.75\textwidth}{\centering
  \ifx\@empty\authors\else
    \vtop{\andify\authors
      %\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       {\bfseries\large\MakeUppercase\authors}\@@par}%end parbox
       }%
      %\global\dimen@i\prevdepth
     }\relax%
   %}%end parbox
   \prevdepth\dimen@i
  \fi
  \vskip15\p@\@plus12\p@
  %%
  %% Blah, Blah...
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{
	\if\spanish@true 1
      \noindent Tesis para optar al grado de \\
       \ifx\@empty\@degree {.........}\else\@degree\fi
	\else
      \noindent
      Thesis submitted to the Office of Research and Graduate Studies\\ 
      in partial fulfillment of the requirements for the degree of\\
      \ifx\@empty\@degree {.........}\else\@degree\fi
	\fi}%end parbox
      }%end centering
    }
  \vskip10\p@\@plus14\p@
  %%
  %% Advisor
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{%
	\if\spanish@true 1
	\noindent Profesor Supervisor:\\
	\else
      \noindent
      Advisor:\\
	\fi
      {%\large 
      \ifx\@empty\@advisor {.........}\else{\uppercase\@advisor}\fi}}%end parbox
      }%end centering
    }
  \vskip5\p@\@plus14\p@
  %%
  %% The date
  %%
  %\centerline{\rm\ifx\@empty\@date {\MoYr}\else\@date\fi}
  \vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \rm Santiago de Chile, \ifx\@empty\@date {\MoYr}\else\@date\fi
  }%end parbox
  \vskip5\p@\@plus14\p@
  %\vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \copyrightline}%end parbox
\endgroup
\clearpage  \thispagestyle{empty}
%%
%%
%% Repreat title page, but now include all committee members.
%%
%%
\cleardoublepage  \thispagestyle{empty}  
\begingroup
  \normalfont\normalsize
  \topskip0\p@  % 
  \advance\topskip-\headsep \advance\topskip-\headheight
  \vskip12\p@\@plus12\p@
  \vspace*{-20mm}
  %%
  %% University/School/Department
  %%
  \vtop{%\centering
       {%
       \noindent
       %\parbox[t]{70pt}{\rule[-48pt]{72pt}{72pt}}
%       \raisebox{-22.13mm}[0em][0em]
%       {            
        %\hspace{80pt}
        %    \raisebox{29.38mm}[0em][0em]{%
        %                 \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        % --- Draw vertical left edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[-\textheight]{.0pt}{\textheight}}\\[-\normalbaselineskip]
        % --- Draw horizontal top edge (reference margin) ---
        \raisebox{0mm}[0em][0em]{%
                         \rule[0pt]{\textwidth}{.0pt}}\\[-\normalbaselineskip]
        % --- Draw vertical decorative line ---
        \hspace*{80pt}%
        %\rule[0em]{80pt}{0pt}%       
        % Note: Must use a trailing '%' 
        % otherwise a small space will be added due to the line feed.
        \vspace*{-4mm}%
        \setlength{\auxdist}{\textheight}%
        \addtolength{\auxdist}{19mm}%
        \raisebox{4mm}[0em][0em]{%
                         \rule[-\auxdist]{.5pt}{\auxdist}}\\[-0\normalbaselineskip]
        \hspace*{-7.5mm}% shif left half 13mm-off-margin
        \parbox{80pt}
        {\centering %\rule[0em]{80pt}{1ex}\\
            \if \pdftex@true 1% Use PDF version if using pdflatex
            \includegraphics*[width=23mm]{./figures/LogoUC.pdf}\\[.2\normalbaselineskip]
            \else% Use PS version by default (dvips).
            \includegraphics*[width=23mm]{./figures/LogoUC.ps} \\[.2\normalbaselineskip] % ,height=30.38mm
            \fi 
%            \raisebox{29.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
%            \raisebox{17.38mm}[0em][0em]{%
%                         \rule[-\textheight]{.5pt}{\textheight}}\\[2mm]
        }%
%       }
       \hspace{7.5mm}% shif right to compensante left-shift and 13mm-off-margin
       \hspace{20pt}%
       \parbox{.75\textwidth}{%parbox 2
       \@university\\
       \@school%\\
       \ifx\@empty\@department {}%{Department of .........}
       \else{\\\@department}\fi}\\ %end parbox 2
       % --- Draw horizontal decorative line ---
       \setlength{\auxdist}{\textwidth}%
       \addtolength{\auxdist}{13mm}%
       \addtolength{\auxdist}{15mm}%
       \hspace*{-13mm}%
       \rule[0pt]{\auxdist}{.5pt}
       }%end centering
     } %end vtop
  \vskip\beftitle %  \vskip105\p@\@plus24\p@
  %%
  %% Title
  %%
  \setlength{\auxdist}{\textwidth}%
  \addtolength{\auxdist}{-120pt}%
  \addtolength{\auxdist}{15mm}%
  \vtop{%\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       \uppercasenonmath{\@title}
       \bfseries\Large%\LARGE
       \@title\@@par}%end parbox
       }%end centering
     % \global\dimen@i\prevdepth
     }%end vtop
  \prevdepth\dimen@i
  \vskip\afttitle %  \vskip65\p@%
  %%
  %% Author(s)
  %%
  %\hspace{80pt}
  %\parbox[t]{.75\textwidth}{\centering
  \ifx\@empty\authors\else
    \vtop{\andify\authors
      %\centering
       {%
       \hspace{100pt}%
       \parbox[t]{\auxdist}{\centering \noindent
       {\bfseries\large\MakeUppercase\authors}\@@par}%end parbox
       }%
      %\global\dimen@i\prevdepth
     }\relax%
   %}%end parbox
   \prevdepth\dimen@i
  \fi
  \vskip15\p@\@plus12\p@
  %%
  %% Members of the Committee
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{%
	\if\spanish@true 1
      \noindent
      Miembros del Comit\'e:\\
	\else
      \noindent
      Members of the Committee:\\
	\fi
      {\normalsize
      \ifx\@empty\@advisor {.........}\\\else{\uppercase\@advisor}\\\fi
      \ifx\@empty\@committeememberA {.........}\\\else{\uppercase\@committeememberA}\\\fi
      \ifx\@empty\@committeememberB {}\else{\uppercase\@committeememberB}\\\fi
      \ifx\@empty\@guestmemberA {.........}\\\else{\uppercase\@guestmemberA}\\\fi
      \ifx\@empty\@guestmemberB {}\else{\uppercase\@guestmemberB}\\\fi
      \ifx\@empty\@ogrsmember {.........}\else{\uppercase\@ogrsmember}\fi}
      }%end parbox
      }%end centering
    }
  \vskip5\p@\@plus14\p@
  %%
  %% Blah, Blah...
  %%
  \prepresentedto
  \vtop{%\centering
      {%
      \hspace{100pt}%
      \parbox[t]{.75\textwidth}{
	\if\spanish@true 1
      \noindent Tesis para optar al grado de \\
       \ifx\@empty\@degree {.........}\else\@degree\fi
	\else
      \noindent
      Thesis submitted to the Office of Research and Graduate Studies\\ 
      in partial fulfillment of the requirements for the degree of\\
      \ifx\@empty\@degree {.........}\else\@degree\fi
	\fi}%end parbox
      }%end centering
    }
  \vskip10\p@\@plus14\p@
  %%
  %% The date
  %%
  %\centerline{\rm\ifx\@empty\@date {\MoYr}\else\@date\fi}
  \vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \rm Santiago de Chile, \ifx\@empty\@date {\MoYr}\else\@date\fi
  }%end parbox
  \vskip5\p@\@plus14\p@
  %\vfill
  \hspace{100pt}%
  \parbox[t]{.75\textwidth}{
  \noindent
  \copyrightline}%end parbox
\endgroup
\clearpage  \thispagestyle{empty}
%% %
%%
%%
%% Make dedication page if declared.
%%
%%
 \ifx \@empty\@dedication {}%if not defined or empty do nothing 
 \else
 \cleardoublepage  \thispagestyle{empty}
 \begingroup
 ~\vspace*{.7\textheight}\\[-\normalbaselineskip]%
 \mbox{}\hspace*{0.6\textwidth}%
 \parbox[t]{0.4\textwidth}{\centering% 
 {\em \@dedication}}
 \endgroup
 \clearpage \thispagestyle{empty}
 \fi%
} % end \@maketitle

%
%-----parameters to be set up in the document------------------------- 
%
\def\mdate#1{\def\@mdate{{#1}}}
\def\@mdate{}
\def\version#1{\def\@version{{#1}}}
\version{0}

\def\university#1{\def\@university{{\normalfont#1}}}
\university{PONTIFICIA UNIVERSIDAD CAT\'OLICA DE CHILE} % originally \large
%
\def\school#1{\def\@school{{\normalfont#1}}}
\school{ESCUELA DE INGENIER\'IA} % originally \large
%
\def\facultyto#1{\def\@facultyto{{\normalfont\rm#1}}}
\facultyto{{\rm Escuela de Ingenier\'ia}}
%
\def\department#1{\def\@department{{\normalfont\rm#1}}}
\def\@department{}
%
\def\faculty#1{\def\@faculty{{\normalfont\rm#1}}}
\def\@faculty{}
%
\def\advisor#1{\def\@advisor{{\normalfont\rm#1}}}
\def\@advisor{}
%
\def\committeememberA#1{\def\@committeememberA{{\normalfont\rm#1}}}
\def\@committeememberA{}
%
\def\committeememberB#1{\def\@committeememberB{{\normalfont\rm#1}}}
\def\@committeememberB{}
%
\def\guestmemberA#1{\def\@guestmemberA{{\normalfont\rm#1}}}
\def\@guestmemberA{}
%
\def\guestmemberB#1{\def\@guestmemberB{{\normalfont\rm#1}}}
\def\@guestmemberB{}
%
\def\ogrsmember#1{\def\@ogrsmember{{\normalfont\rm#1}}}
\def\@ogrsmember{}
%
\def\date#1{\def\@date{{\normalfont\rm#1}}}
\def\@date{}
%
\def\copyrightname#1{\def\@copyrightname{{\scshape#1}}}
\def\@copyrightname{}
%
\def\copyrightyear#1{\def\@copyrightyear{{\normalfont\footnotesize#1}}}
\def\@copyrightyear{}
%
\def\copyrightline{%
  %\centerline
    {\footnotesize \raisebox{.2ex}{$\copyright$} %${}^{\hbox{\copyright}}$ 
    \@copyrightyear, %
    \ifx\@copyrightname\empty{..........}\else 
    {\@copyrightname}\fi%         
    }%end centerline
                  }
%
\def\prepresentedto{\vskip1.75pc}
%
\def\degree#1{\def\@degree{{\normalfont\rm#1}}}
\def\@degree{}
%
\def\subject#1{\def\@subject{{\normalfont\rm#1}}}
\def\@subject{}
%
\def\shortauthors{}
\def\shorttitle{}
%
\def\dedication#1{\def\@dedication{#1}}
\def\@dedication{}
%

%
%------------------\maketitle creates cover page---------------------
%
\def\maketitle{\par
  \@topnum\z@ % this prevents figures from falling at the top of page 1
  \ifx\@empty\shortauthors\let\shortauthors\shorttitle\fi
  \begingroup
  \@maketitle
  \endgroup
  \andify\shortauthors
  \thispagestyle{plain} %headings}%             %
  \c@footnote\z@
%
%  the following commands free up memory for small systems
%  once \maketitle is over
%  but keep authors and title for future use
%
  \def\do##1{\let##1\relax}%
  \do\maketitle \do\@maketitle
% \do\title \do\@xtitle \do\@title      %modification
% \do\author \do\@xauthor \do\@authors  %modification
  \do\address \do\@xaddress
  \do\email \do\@xemail \do\curraddr \do\@xcurraddr
%
  \do\department \do\@department
  \do\faculty \do\@faculty
  \do\degree \do\@degree
  \do\subject \do\@subject
  \do\date \do\@date
  \do\copyrightyear \do\@copyrightyear
}
%
%%%%%%%%%%%%%%%%%%%%%%%%-------end of cover page------%%%%%%%%%%%%%%%%%%%%%%%%
%

% this is for hanging indent of turn lines in current address
\newbox\checkbox
\setbox\checkbox=\hbox{{\ignorespaces\footnotesize\it
                \indent Current address}:\ }

\def\@setaddresses{\par
  \nobreak \begingroup \footnotesize
  \def\author##1{\nobreak\addvspace\bigskipamount}%
  \def\\{\unskip, \ignorespaces}%
  \interlinepenalty\@M
  \def\address##1##2{\begingroup
    \par\nobreak %\addvspace\medskipamount\indent
    \@ifnotempty{##1}{(\ignorespaces##1\unskip) }%
    {\noindent \scshape\ignorespaces##2}\par\endgroup}%
  \def\curraddr##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape Current address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      ##2\par\endgroup}}%
  \def\email##1##2{\begingroup
    \@ifnotempty{##2}{\nobreak\indent{\itshape E-mail address}%
      \@ifnotempty{##1}{, \ignorespaces##1\unskip}\/:\space
      \ttfamily##2\par\endgroup}}%
  \addresses
  \endgroup
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end of \@setaddress

\def\@captionheadfont{\normalfont}

%------------------------------- 
\def\today{\number\day\space%           Day month and year
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi%
    \space\number\year}%
%------------------------------- 
\def\Month{%
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi}%
%------------------------------- 
\def\Year{\number\year}
%===================================================FRENCH 
\def\MoYr{%
    \ifcase\month
    \or January\or February\or March\or April\or May\or June%
    \or July\or August\or September\or October\or November\or December%
    \fi%
    \space\number\year}%
%------------------------------- 
\def\todayfr{\space\number\day\space
             \ifcase\month
             \or
  janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
  juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre\fi
  \space \number\year}
%=================================================== 
\def\MoYrfr{%
    \ifcase\month\or
  janvier\or f\'evrier\or mars\or avril\or mai\or juin\or
  juillet\or ao\^ut\or septembre\or octobre\or novembre\or d\'ecembre
    \fi%
    \space\number\year}%
%------------------------------- 
\def\hhmm{%
    \count1=\time                  % current time in minutes after 00:00
    \count2=\count1                % count 2 contains time in minutes
    \divide \count1 by 60          % count1  contains hh in hours
    \count3=\count1                % count3  contains hh in hours
    \multiply \count1 by 60        % count1  contains hh in minutes
    \advance\count2 by -\count1    % count2  contains mm in minutes
                                   % do NOT put a space after<\advance>  
    \number\count3:\number\count2  % print hours:minutes
   }
%------------------------------- 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   %                                                               %
   %  Copy of \verbinput : to make listing of TeX files.
   %  Received from M.J. Downes, AMS techsupport group, 8 Apr. 1992     
   %                                                               %
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

\begingroup
\lccode`\~=`\ % actually, this percent sign is required
\lowercase{\gdef\verbspaces{\obeyspaces
  \def~{\leavevmode\space}}}
\endgroup
 
\def\verbinput#1{%
% Start a group to keep catcode changes localized.
  \begingroup
% Change the definition of \do so that it will do what we
% want when \dospecials is called.
  \def\do##1{\catcode`##1=12}%
  \dospecials \catcode`\@=12 % \@ is not in \dospecials
  \verbspaces
  \def\par{\ifvmode\null\else\endgraf\fi}\obeylines
% Uncomment this line if you don't want the verbatim lines indented:
%  \parindent0pt
  \Small\tt         %%% \eightpoint\tt in amstex
  \input #1\relax
  \endgroup}
%-------------------------------
%%%%  Usage: 
%%%%    \verbinput{myfile.tex}
%------------------------------- 

\def\verbinputx[#1]#2{%
% Start a group to keep catcode changes localized.
  \begingroup
% Change the definition of \do so that it will do what we
% want when \dospecials is called.
  \def\do##1{\catcode`##1=12}%
  \dospecials \catcode`\@=12 % \@ is not in \dospecials
  \verbspaces
  \def\par{\ifvmode\null\else\endgraf\fi}\obeylines
% Uncomment this line if you don't want the verbatim lines indented:
%  \parindent0pt
  \Small\tt         %%% \eightpoint\tt in amstex
  {#1%
  \input #2\relax
  }%
  \endgroup}
%-------------------------------

%\ps@headings
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}
\numberwithin{equation}{chapter}

\endinput
%------------------------------------------------------------------------------
% End of pucthesis.cls
%------------------------------------------------------------------------------
