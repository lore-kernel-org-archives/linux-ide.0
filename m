From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATA ATAPI work in progress
Date: 15 May 2004 09:56:30 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1084636590.3083.25.camel@patibmrh9>
References: <1084393233.3999.2.camel@patibmrh9> <40A28BB6.7090204@pobox.com>
	<1084403654.3196.31.camel@patibmrh9>  <40A3E595.8000003@pobox.com><108455  
	9	000.4017.52.camel@patibmrh9>  <40A51604.8070208@pobox.com><1084578453.5 3
	4	 3.	26.camel@patibmrh9><1084579362.3271.5.camel@patibmrh9> <40A5669B.608
	010	8@pobox.com><1084626376.3079.8.camel@patibmrh9> <1084628978.5082.7.ca m
	el@patibmrh9><40A636D2.3090205@pobox.com>  <1084636180.3083.17.camel@patibm
	rh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out2.iomega.com ([147.178.1.83]:13545 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264639AbUEOP4x
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 May 2004 11:56:53 -0400
In-Reply-To: <1084636180.3083.17.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

> > Or just that we made progress?
> 
> Yes I have three or more new troubles to report ...

Personally I vote we chase three troubles in three threads, not all
three here, but I won't act that way unless someone seconds my motion.

In short I am now reporting SATA ATAPI UDMA trouble in:

1) linux-2.6.6-bk2
2) open O_NONBLOCK ioctl SG_IO
3) /proc/ide

At length:

1) linux-2.6.6-bk2

I tried substituting linux-2.6.6-bk2 for -bk1.  My -bk2 crashed in the
second dump_stack past a *NULL of ata_qc_issue_prot.  Seemingly the same
crash, both times I tried it.

My -bk1 and -bk2 diff's vs. kernel.org are byte-for-byte identical when
I compare:

include/linux/ata.h
include/linux/libata.h
drivers/scsi/libata-core.c
drivers/scsi/libata-scsi.c

My .config differ by only adding new # comments.

2) open O_NONBLOCK ioctl SG_IO

I tried `plscsi /dev/scd0` i.e. an open O_NONBLOCK/ ioctl SG_IO/ close
of a standard op x12 Inquiry for up to x24 bytes.

That died in a way that defeated Ctrl+C and `modprobe -r ata-piix`,
though `reboot` worked.  I'll try ioctl CDROM_SEND_PACKET next, then
think harder.

Meanwhile, seemingly relevant /var/log/messages include:

kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00
kernel: ata_scsi_translate: ENTER
kernel: ata2(0): empty request buffer
kernel: ata_scsi_badcmd: ENTER
kernel: ata_scsi_translate: EXIT - badcmd
kernel: ata_scsi_dump_cdb: CDB (2:0,0,0) 00 00 00 00 00 00 00 00 00

3) /proc/ide

/proc/ide, perhaps by design, does not show the device (and thus
neglects to publish its op xA1 Identify data).

Pat LaVarre


