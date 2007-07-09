From: Rodney Gordon II <meff@spherevision.org>
Subject: Re: [BUG] IT8212 libata driver *still* hard-freezes system on boot
	on 2.6.22 final.
Date: Mon, 09 Jul 2007 07:44:49 -0500
Message-ID: <1183985089.4190.2.camel@ghreen.sphere>
References: <1183944204.8932.8.camel@ghreen.sphere>
	 <20070709104930.4e26f38f@the-village.bc.nu>
	 <1183979782.4301.4.camel@ghreen.sphere>
	 <20070709131649.5fa63744@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:42824 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752106AbXGIMoy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jul 2007 08:44:54 -0400
In-Reply-To: <20070709131649.5fa63744@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Mon, 2007-07-09 at 13:16 +0100, Alan Cox wrote:
> > > It would be useful to know if a kernel built with no DMA support for the
> > > IT8212 behaved as that might give us a clue about what is choking. If you
> > > look in drivers/ata/pata_it821x.c:it821x_init_one you'll see a pair of
> > > lines that say
> > > 
> > > 	mwdma = 0x1f,
> > > 	udma_mask = 0x7f
> > > 
> > > 
> > > remove, rebuild and report..
> > 
> > Alright.
> > 
> > Attachment [0] is a successful boot with those lines removed. (This a
> > good thing or a bad thing? :)
> 
> Thats an interesting question in itself. It does seem to indicate the
> problem is DMA tuning or DMA related and not IRQ routing - which is good
> as of itself.
> 
> > Attachment [1] is a successful boot with the old ata subsystem using the
> > IT8212.
> 
> For the next trick set mwdma_mask = 0x07 but leave UDMA off and see what
> happens. 

Lock.

> Then try with udma_mask = 0x02 which should force the 50MHz
> clock on not the 66MHz clock just in case its clock related.

Lock. :(

> How much RAM do you have ?

1536MB, using highmem 4GB. Please refer to my dmesg attachments in the
last post for more RAM info :)

> Alan

-r

