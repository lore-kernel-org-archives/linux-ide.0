From: Tejun <htejun@gmail.com>
Subject: Re: PATA vs. SATA
Date: Tue, 31 Jan 2006 11:47:26 +0900
Message-ID: <43DECFBE.30300@gmail.com>
References: <Pine.LNX.4.58.0601301639270.6538@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.204]:28300 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932276AbWAaCrj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Jan 2006 21:47:39 -0500
Received: by xproxy.gmail.com with SMTP id s14so798992wxc
        for <linux-ide@vger.kernel.org>; Mon, 30 Jan 2006 18:47:38 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0601301639270.6538@shark.he.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-ide@vger.kernel.org

Randy.Dunlap wrote:
> It's confusing enough using libata for PATA/IDE instead of
> drivers/ide/* and using a PIIX driver for SATA.  :)
> 
> Yes, it Works For Me.  However, I see this one little thing
> that still seems odd to me.
> 
> 
> Intel SATA controller in IDE mode:  libata-core says:
> 
> ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18B0 irq 14
> ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x18B8 irq 15
>       ~~~~
>  This ^^^^ is the confusing part to me.

I'm not sure whether I understood your problem correctly but if your 
ata_piix is reporting SATA for a PATA port and the controller is ICH6 or 
7, there's a patch which recently made into the devel tree which fixes 
MAP register value interpretation on ICH6/7's (which BTW was slightly 
broken and fixed again by Jeff's patch).  Can you try the latest 
upstream branch?

-- 
tejun
