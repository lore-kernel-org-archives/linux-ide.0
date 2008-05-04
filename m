From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Asus DRW-2014L1T SATA DVD drive and sata_via
Date: Sun, 04 May 2008 07:49:15 -0400
Message-ID: <481DA2BB.3050309@pobox.com>
References: <MTAwMDAxMi5zZXJ2YW50cw.1209822671@quikprotect>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:43988 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755089AbYEDLtU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 May 2008 07:49:20 -0400
In-Reply-To: <MTAwMDAxMi5zZXJ2YW50cw.1209822671@quikprotect>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Bruce Hill, Jr." <servants@cotse.net>
Cc: linux-ide@vger.kernel.org

Bruce Hill, Jr. wrote:
> Jeff,
> 
> I don't know where to start, and am asking for direction.
> 
> I bought an Asus DRW-2014L1T SATA DVD drive. I can blank CD-RWs with 
> cdrecord, but can not burn a good CD-R or CD-RW with cdrecord or cdrdao 
> from CLI or with K3B. I also can not burn a good DVD with growisofs.
> 
> I can burn just fine to my TSSTcorp DVD drive (it is PATA).
> 
> I'm using sata_via and pata_via ... no IDE stuff in the kernel. I've 
> tried different kernel selections, but nothing works.
> 
> mingdao@silas:~$ uname -a
> Linux silas 2.6.25.1-libata #1 PREEMPT Fri May 2 07:37:20 CST 2008 i686 
> AMD Athlon(tm) 64 Processor 3200+ AuthenticAMD GNU/Linux
> 
> mingdao@silas:~$ /sbin/lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host 
> Bridge (rev 01)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
> [K8T800/K8T890 South]
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID 
> Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc. 
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 
> I sent a request for help to cdrecord, and Jorge Schilling basically 
> made excuses and blamed my media, my drive, and the Linux kernel. He 
> offered nothing technical whatsoever.
> 
> I updated the firmware in the drive, and have built the latest cdrtools 
> and dvd+rw-tools.
> 
> Perhaps this Asus DVD burner is not even supported. I've read sata_via.c 
> and LKML and every hit on Google and <Linux> Google.
> 
> If you could just tell me what to do to submit a possible bug report or 
> request for support, I would be grateful.
> 
> And though my knowledge is not real deep, I will do anything you ask 
> from here to work with you on this ... if it's even something you have 
> one minute of time for.

Can you show full 'dmesg' output, including (a) everything from boot and 
(b) an attempt to burn a CD with cdrecord and (c) an attempt to burn a 
DVD with growisofs

Full lspci would also be nice (I don't think the above is all of it, is it?)

If you want to collect stupid amounts of [quite helpful] debug output, 
you may s/undef/define/ on the following lines of include/linux/libata.h 
in the kernel:

#undef ATA_DEBUG                /* debugging output */
#undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

If you are seeing error messages, this helps understand them:

http://ata.wiki.kernel.org/index.php/Libata_error_messages

Regards,
	
	Jeff


