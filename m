From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] libata-sff: fix 32-bit PIO regression
Date: Mon, 9 Feb 2009 18:14:33 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0902091807580.31519@blonde.anvils>
References: <200902082253.07438.sshtylyov@ru.mvista.com>
 <Pine.LNX.4.64.0902082108290.18661@blonde.anvils> <498F73A5.2070300@ru.mvista.com>
 <Pine.LNX.4.64.0902091016520.14410@blonde.anvils> <49905D08.4050302@ru.mvista.com>
 <49905E70.8000209@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756522AbZBISPx@vger.kernel.org>
Received: from [172.20.26.18]([172.20.26.18]) (1987 bytes) by megami.veritas.com
	via sendmail with P:esmtp/R:smart_host/T:smtp
	(sender: <hugh@veritas.com>)
	id <m1LWaex-0000MhC@megami.veritas.com>
	for <linux-ide@vger.kernel.org>; Mon, 9 Feb 2009 10:15:07 -0800 (PST)
	(Smail-3.2.0.101 1997-Dec-17 #15 built 2001-Aug-30)
In-Reply-To: <49905E70.8000209@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, rjw@sisk.pl
List-Id: linux-ide@vger.kernel.org

On Mon, 9 Feb 2009, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> > > When I checked (mounting and listing a CD), about 34% of
> > > commands had slop 2.
> 
> >    Hm, that probably involved the raw block reads. I don't remember the raw
> > sector length off-hand but it may well be just even, not divisble by 4.
> 
>    Oops, I read "listening" instead of "listing". :-/
>    But I thought that listing shouldn't involve anything other than block 
> reads. OTOH, I'm not familiar enough with ISO9660... What commands are you
> seeing (if you have them dumped)?

No, I didn't dump out the commands, just added temporary slop stats
into the xfer32 function, to check what paths were being tested.

That machine is busy running tests now: I could try again when it's
done, what would you recommend for dumping out the commands (remember,
I'm not an ATA developer)?

Though, to be honest, I'd prefer to just let this unlikely subject drop!

Hugh
