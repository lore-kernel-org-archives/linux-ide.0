From: Baeckham <baeckham@gmx.net>
Subject: Re: really bad performance with ICH7 SATA controller
Date: Tue, 27 Feb 2007 14:03:06 +0100
Message-ID: <200702271403.06739.baeckham@gmx.net>
References: <200702270837.42583.baeckham@gmx.net> <20070227123332.32b3c161@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58227 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751254AbXB0NDM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 08:03:12 -0500
In-Reply-To: <20070227123332.32b3c161@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Hi Alan,

thanks a lot. Disabling all the ATA/ATAPI stuff in the kernel helped. The 
system is reacting better when accessing a dvd. 

My optical drive is named /dev/sr0 now. hdparm shows slow performance, with 
the old config it shows a much better performance. But the reality is 
different. Now it is faster.

Thanx again!

Steffen

Am Dienstag, 27. Februar 2007 13:33 schrieb Alan:
> > Some output from dmesg:
> > ...
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx ide0: I/O resource 0x1F0-0x1F7 not free.
> > ide0: ports already in use, skipping probe
> > Probing IDE interface ide1...
> > hdd: TSSTcorpCD/DVDW SN-S082D, ATAPI CD/DVD-ROM drive
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hdd: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
>
> You have one of the awkward IDE setups. If you build a kernel with just
> libata support and not old IDE your CD should appear
> as /dev/scd{something} and run fast.
>
> Alternatively you can do this using a boot option (combined_mode=libata)
>
>
> Alan
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
