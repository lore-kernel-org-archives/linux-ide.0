From: Borislav Petkov <petkov@uni-muenster.de>
Subject: [RFC] libata debugging
Date: Thu, 25 Aug 2005 18:36:46 +0200
Message-ID: <200508251836.46738.petkov@uni-muenster.de>
References: <430C10E7.9060502@pobox.com> <200508242304.22998.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:64694 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S932297AbVHYQgg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 12:36:36 -0400
In-Reply-To: <200508242304.22998.petkov@uni-muenster.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>

On Wednesday 24 August 2005 23:04, Borislav Petkov wrote:
Hi there,

Jeff asked for a volunteer a couple days ago on lkml to implement libata 
debugging similar to the netdev debugging (see thread "Another libata TODO 
item") and I decided to give it a try. Here's a forward message I sent to him 
with the loglevels I think should be there and some additional implementation 
details I think should be discussed first before any coding attempts. Any 
comments are greatly appreciated.

Regards,
Boris.

> Hi Jeff,
>
> after going through libata-core and libata-scsi.c here are the logging
> levels I think might be appropriate:
>
> ATA_MSG_DRV		0x0001
> ATA_MSG_INFO	0x0002
> ATA_MSG_PROBE 	0x0004
> ATA_MSG_WARN 	0x0008
> ATA_MSG_MALLOC	0x0010
> ATA_MSG_CTL 		0x0020
> ATA_MSG_INTR	0x0040
> ATA_MSG_ERR		0x0080
>
>
> ATA_MSG_DRV:
> Driver info messages such as identity, version and copyright info.
>
> ATA_MSG_INFO:
> a little more verbose device config messages (to replace all printk's with
> KERN_INFO loglevel)
>
> ATA_MSG_PROBE:
> interaction with the controller. (printing of (un-)supported features while
> configuring the device; features setting as in ata_dev_set_xfermode() for
> example)
>
> ATA_MSG_WARN:
> warning messages like
> printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
> for example.
>
> ATA_MSG_MALLOC:
> debugging allocation, deallocation and mapping of driver memory.
>
> ATA_MSG_CTL:
> highly verbose device control/hardware registers (for ex. 
> ata_dev_select()), resetting the controller, etc. To replace mostly the
> debugging DPRINTK's.
>
> ATA_MSG_INTR:
> interrupt handling
>
> ATA_MSG_ERR:
> fatal hardware and other errors
>
>
> It seems to me though that these debug levels do not have the level of
> granularity that libata should probably have, although I don't see more
> subgroupings besides maybe an additional loglevel strictly for SCSI/ATA
> commands sent to the controller.
>
> Should we also replace all those enter/exit debug statements -
> VPRINTK("ENTER\n"); - with something like
> VPRINTK("function_name():ENTER\n"); for more easly locating the place in
> the code that the problem happens while debugging.
>
> Should the userspace setting of debug levels be done maybe through /proc
> like the ide cdrom driver, for example: /proc/sys/dev/cdrom/debug, so
> writing the ATA_MSG_XXX unsigned value there would enable or disable
> debugging?
>
> I know that in open source you just do things but i still think it is
> better to run these by you first and then do the patches. :)
>
> Regards,
> Boris.
