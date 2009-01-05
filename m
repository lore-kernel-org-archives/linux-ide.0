From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SB600 in AHCI mode will not run SATA optical drive
Date: Mon, 05 Jan 2009 00:07:24 -0600
Message-ID: <4961A39C.30405@shaw.ca>
References: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:5154 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbZAEGH1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 01:07:27 -0500
In-Reply-To: <21155.72.218.132.189.1231111986.squirrel@webmail.tuffmail.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Darrick Burch <darrick@tuffmail.com>
Cc: linux-ide@vger.kernel.org

Darrick Burch wrote:
> Hey, all:
> 
> I'm having a bit of an issue with running my Pioneer BDC-202BK BD-ROM
> drive on my motherboard's (MSI K9A2-CF) AMD SB600-based SATA controller
> and I was wondering if anyone has seen anything similar.
> 
> The problem is that the drive does not initialize at all under Linux.  I
> get errors from the ahci driver which, from what I've read from the wiki,
> is the only driver under which the SATA ports on the SB600 are supported.
> 
> The errors I'm getting loop infinitely until I remove the drive data cable:
> 
> Nov  9 21:51:51 linux kernel: ata3: soft resetting link
> Nov  9 21:51:51 linux kernel: ata3: SATA link down (SStatus 1 SControl 300)
> Nov  9 21:51:51 linux kernel: ata3: EH complete
> Nov  9 21:51:51 linux kernel: ata3: exception Emask 0x10 SAct 0x0 SErr
> 0x40c0000 action 0xa frozen
> Nov  9 21:51:51 linux kernel: ata3: irq_stat 0x00000040, connection status
> changed
> Nov  9 21:51:51 linux kernel: ata3: SError: { CommWake 10B8B DevExch }
> Nov  9 21:51:51 linux kernel: ata3: soft resetting link
> Nov  9 21:51:51 linux kernel: ata3: SATA link down (SStatus 1 SControl 300)
> Nov  9 21:51:51 linux kernel: ata3: EH complete
> Nov  9 21:51:51 linux kernel: ata3: exception Emask 0x10 SAct 0x0 SErr
> 0x40c0000 action 0xa frozen
> Nov  9 21:51:51 linux kernel: ata3: irq_stat 0x00000040, connection status
> changed
> Nov  9 21:51:51 linux kernel: ata3: SError: { CommWake 10B8B DevExch }
> 
> I've been able to get around this problem (which prevents me from booting
> completely) by commenting the PCI_VDEVICE definition for the SB600.  Of
> course, this means that the controller is effectively disabled.  I'm not
> in desperate need for my optical drive in Linux at the moment, but it
> would be nice to have access to it someday.
> 
> I suppose my questions are the following:
> 
> 1. Is it possible that the drive simply does not want to run under AHCI
> mode?  I should note that the drive works correctly under Windows XP with
> the controller set to IDE emulation mode.

Could be some kind of SATA PHY quirk or incompatibility that only shows 
up in AHCI mode or something. It seems from the output that the SATA 
link may be going up and down. You could try forcing 1.5Gbps 
(libata.force=1.5Gbps if libata is built in, or force=1.5Gbps when the 
libata module gets loaded) and see if that helps.

Maybe Tejun has some more ideas..

> 2. I'm thinking that the best thing for me to do is to get another PCIe
> SATA controller and dedicate it to this one drive.  Does anyone want to
> give their opinion on this?
> 
> Thanks in advance,
> -Darrick
> 
> PS - I have no other devices on the SATA controller; my two hard drives
> are PATA and they're connected to the single PATA header available on the
> motherboard.  These, of course, are working fine.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

