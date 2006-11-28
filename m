From: Linus Torvalds <torvalds@osdl.org>
Subject: Scary Intel SATA errors..
Date: Tue, 28 Nov 2006 08:56:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611280853280.30076@woody.osdl.org>
References: <20061114150454.GA11900@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:49838 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S935889AbWK1Q5O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 11:57:14 -0500
In-Reply-To: <20061114150454.GA11900@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org


Jeff, what does this mean:

	ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
	ata1.00: (BMDMA stat 0x21)
	ata1.00: tag 0 cmd 0xca Emask 0x4 stat 0x40 err 0x0 (timeout)
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1: failed to recover some devices, retrying in 5 secs
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1: failed to recover some devices, retrying in 5 secs
	ata1: port is slow to respond, please be patient (Status 0xd0)
	ata1: port failed to respond (30 secs, Status 0xd0)
	ata1: soft resetting port
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ATA: abnormal status 0xD0 on port 0x214F
	ata1.00: qc timeout (cmd 0xec)
	ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
	ata1.00: revalidation failed (errno=-5)
	ata1.00: disabled
	ata1: EH complete

followed by various IO errors:

	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 335093
	sd 0:0:0:0: SCSI error: return code = 0x00040000
	end_request: I/O error, dev sda, sector 896217445
	Buffer I/O error on device dm-0, logical block 112001027
	lost page write due to I/O error on dm-0
	..

nasty, nasty, nasty.

This is with ata_piix on a Intel i965 motherboard (everything Intel)

		Linus
