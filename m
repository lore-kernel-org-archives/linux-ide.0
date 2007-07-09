From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] IT8212 libata driver *still* hard-freezes system on boot
 on 2.6.22 final.
Date: Mon, 9 Jul 2007 13:16:49 +0100
Message-ID: <20070709131649.5fa63744@the-village.bc.nu>
References: <1183944204.8932.8.camel@ghreen.sphere>
	<20070709104930.4e26f38f@the-village.bc.nu>
	<1183979782.4301.4.camel@ghreen.sphere>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755389AbXGIMKi@vger.kernel.org>
In-Reply-To: <1183979782.4301.4.camel@ghreen.sphere>
Sender: linux-kernel-owner@vger.kernel.org
To: Rodney Gordon II <meff@spherevision.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

> > It would be useful to know if a kernel built with no DMA support for the
> > IT8212 behaved as that might give us a clue about what is choking. If you
> > look in drivers/ata/pata_it821x.c:it821x_init_one you'll see a pair of
> > lines that say
> > 
> > 	mwdma = 0x1f,
> > 	udma_mask = 0x7f
> > 
> > 
> > remove, rebuild and report..
> 
> Alright.
> 
> Attachment [0] is a successful boot with those lines removed. (This a
> good thing or a bad thing? :)

Thats an interesting question in itself. It does seem to indicate the
problem is DMA tuning or DMA related and not IRQ routing - which is good
as of itself.

> Attachment [1] is a successful boot with the old ata subsystem using the
> IT8212.

For the next trick set mwdma_mask = 0x07 but leave UDMA off and see what
happens. Then try with udma_mask = 0x02 which should force the 50MHz
clock on not the 66MHz clock just in case its clock related.

How much RAM do you have ?

Alan
