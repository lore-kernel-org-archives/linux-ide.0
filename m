From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Wed, 27 Jan 2010 05:51:17 +0530
Message-ID: <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <20100126160243.018b87e3@lxorguk.ukuu.org.uk>
	 <aacba7e1001260819k24088c81m14b4c702fccddd29@mail.gmail.com>
	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753935Ab0A0AVV@vger.kernel.org>
In-Reply-To: <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Rees <drees76@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org
List-Id: linux-ide@vger.kernel.org

2010/1/27 David Rees <drees76@gmail.com>:
> Have there been any other reports of NCQ issues with similar Crucial
> drives or Indilinx?

I haven't personally seen reports of NCQ specific issues. I have seen
people (online) reporting "issues" with Linux distro installations
hanging/freezing etc. and some prior attempts at SMART fixes which
I also initially tried but did not work for me.

I have tried to "publicise" this issue (forum, blog, mailing list posts)
in the hope more users may search and identify the correct issue
so that it may be better verified.

Unfortunately, the Crucial ID string is not model-agnostic (if thats
the right term)... meaning the patch has 3 lines to ID the 3 current
models that I know of including my own 128 GB model.

Not sure if there's a better, more generic way to match a whole group
of SSDs (same model family or various vendors) which trigger NCQ errors?

-- 
"Thou shalt not follow the null pointer for at its end madness and chaos lie."
