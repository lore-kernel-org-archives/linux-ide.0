From: "tea4two" <tea4two@tin.it>
Subject: Re: dma_timer_expiry on SATA siimage 3112 under 2.6.0-test1-ac1
Date: Thu, 17 Jul 2003 22:59:55 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <bf72m5$2p5$1@main.gmane.org>
References: <1058389994.3220.20.camel@daedalus.samhome.net> <bf6nb0$c3$1@main.gmane.org> <1058466147.3220.62.camel@daedalus.samhome.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:64461 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270948AbTGQUpe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jul 2003 16:45:34 -0400
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 19dFpz-0000kn-00
	for <linux-ide@vger.kernel.org>; Thu, 17 Jul 2003 22:58:51 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


I can't explain why it's work....
I've made a lot of tries and the only way to work at 50.5 Mb/s (for me) is
to run: hdparm -d1 -Xudma2 /dev/hde

how you can see in boot information, Autoprobe to use DMA for SiI3112 fail
and controller is set for all channell in PIO Mode, altought driver seems
know all DMA speed.

> SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
>SiI3112 Serial ATA: chipset revision 2
> SiI3112 Serial ATA: not 100% native mode: will probe irqs later
>    ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
>    ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
>  hda: Maxtor 6Y120M0, ATA DISK drive

BEFORE

> hdparm -tT /dev/hda:
>
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.31 seconds =412.90 MB/sec
>  Timing buffered disk reads:  64 MB in 46.39 seconds =  1.38 MB/sec
>

AFTER

> hdparm -tT /dev/hda:
>
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  0.31 seconds =412.90 MB/sec
>  Timing buffered disk reads:  64 MB in  1.25 seconds = 51.20 MB/sec
>


All other DMA speed udma3, 4, 5 and 6 are not supported and made a lot of
I/O error in disk access.

I don't know other workaround.

50.5 Mb/s and up are GOOD speeds. 9 Gb USCSI 160 7.200 RPM Atlas IV give me
only 30 Mb/s......

A little trick....

During Linux install switch in a console and run the command
hdparm -d1 -Xudma6 /tmp/hde.....   ;-))))

Installation time is more faster.... (for me from 1 hour and 30 minutes drop
to 25 minutes......)

I think that driver is not mature  and need improvement....I hope ASAP.

Bye

Pierluigi







