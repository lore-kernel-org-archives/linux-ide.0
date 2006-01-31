From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: PATA vs. SATA
Date: Mon, 30 Jan 2006 19:23:03 -0800
Message-ID: <20060130192303.7847406e.rdunlap@xenotime.net>
References: <Pine.LNX.4.58.0601301639270.6538@shark.he.net>
	<43DECFBE.30300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:23485 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030292AbWAaDWk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 22:22:40 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 19:22:39 -0800
In-Reply-To: <43DECFBE.30300@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

On Tue, 31 Jan 2006 11:47:26 +0900 Tejun wrote:

> Randy.Dunlap wrote:
> > It's confusing enough using libata for PATA/IDE instead of
> > drivers/ide/* and using a PIIX driver for SATA.  :)
> > 
> > Yes, it Works For Me.  However, I see this one little thing
> > that still seems odd to me.
> > 
> > 
> > Intel SATA controller in IDE mode:  libata-core says:
> > 
> > ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
> > ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
> >       ~~~~
> >  This ^^^^ is the confusing part to me.
> 
> I'm not sure whether I understood your problem correctly but if your 
> ata_piix is reporting SATA for a PATA port and the controller is ICH6 or 
> 7, there's a patch which recently made into the devel tree which fixes 
> MAP register value interpretation on ICH6/7's (which BTW was slightly 
> broken and fixed again by Jeff's patch).  Can you try the latest 
> upstream branch?

The patch(es) sound like they may fix this small nit.

I may try the upstream branch if I ever become a gitter.

---
~Randy
