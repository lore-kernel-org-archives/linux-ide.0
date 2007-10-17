From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Re-enabling Serial ATA ports possible?
Date: Wed, 17 Oct 2007 14:51:12 +0200 (MEST)
Message-ID: <200710171251.l9HCpCv7021811@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:48315 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494AbXJQMvS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Oct 2007 08:51:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, openembedded@haerwu.biz

On Wed, 17 Oct 2007 14:38:04 +0200, Marcin Juszkiewicz wrote:
> On my system (2.6.23-rc9) I have Serial-ATA DVD/RW drive connected 
> to sata_sil controller. Sometimes when there is a problem with CD
> or DVD disk controller shutdowns drive:
> 
> [53560.095573] cdrom: sr0: mrw address space DMA selected
> [53561.001946] ISO 9660 Extensions: Microsoft Joliet Level 3
> [53561.002777] ISOFS: changing to secondary root
> [53621.380238] ata6.00: exception Emask 0x10 SAct 0x0 SErr 0x90000 action 0x2
> [53621.380249] ata6.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0
> [53621.380252]          res 51/60:03:00:00:00/00:00:00:00:00/a0 Emask 0x10 (ATA bus error)
> [53621.380263] ata6: hard resetting port
> [53623.783961] ata6: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [53642.595278] ata6.00: qc timeout (cmd 0xa1)
> [53642.595285] ata6.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [53642.595288] ata6.00: revalidation failed (errno=-5)
> [53642.595292] ata6: failed to recover some devices, retrying in 5 secs
> [53645.092046] ata6: hard resetting port
> [53646.193870] ata6: SATA link down (SStatus 1 SControl 310)
> [53646.193881] ata6.00: limiting speed to UDMA/25:PIO3
> [53646.193884] ata6: failed to recover some devices, retrying in 5 secs
> [53648.690501] ata6: hard resetting port
> [53649.792323] ata6: SATA link down (SStatus 1 SControl 310)
> [53649.792333] ata6.00: disabled
> [53650.042442] ata6: EH pending after completion, repeating EH (cnt=4)
> [53650.042459] ata6: EH complete
> [53650.042512] sr 6:0:0:0: rejecting I/O to offline device
> [53650.042518] sr 6:0:0:0: rejecting I/O to offline device
> [53650.042522] sr 6:0:0:0: rejecting I/O to offline device
> [53650.042536] sr 6:0:0:0: rejecting I/O to offline device
> [53650.042632] ata6.00: detaching (SCSI 6:0:0:0)
> 
> Is there a way to re-enable ata6.00 in other way then power down/power up
> whole machine? Looks like reboot is not a way to get it working again.

If the driver supports SATA hotplugging, then removing the cable, waiting
for libata EH to complete, and then inserting it again, should do the trick.
