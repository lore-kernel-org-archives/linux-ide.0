From: Kurt Wall <kwall@kurtwerks.com>
Subject: Fix make mandocs for libata-core.c
Date: Mon, 30 Jan 2006 22:20:29 -0500
Message-ID: <20060131032029.GO1501@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030284AbWAaDOX@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

"make mandocs" complains when on libata-core.c because several
functions have undescribed parameters. This patch adds silences those
warnings by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>


--- ./linux-2.6.16-rc1/drivers/scsi/libata-core.c.orig	2006-01-21 09:30:59.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/libata-core.c	2006-01-30 22:18:32.000000000 -0500
@@ -4163,6 +4163,8 @@
 /**
  *	ata_port_start - Set port up for dma.
  *	@ap: Port to initialize
+ *  @dev: Device whose port will be prepared for DMA
+ *  @cmd: Command to issue
  *
  *	Called just after data structures for each port are
  *	initialized.  Allocates space for PRD table.
@@ -4224,6 +4226,8 @@
 
 /**
  *	ata_device_resume - wakeup a previously suspended devices
+ *  @ap: port to which command is being issued
+ *  @dev: device to wake up from suspended state
  *
  *	Kick the drive back into action, by sending it an idle immediate
  *	command and making sure its transfer mode matches between drive
@@ -4246,6 +4250,8 @@
 
 /**
  *	ata_device_suspend - prepare a device for suspend
+ *  @ap: port to wich command is being issued
+ *  @dev: device to prepare for suspend
  *
  *	Flush the cache on the drive, if appropriate, then issue a
  *	standbynow command.
-- 
Critic, n.:
	A person who boasts himself hard to please because nobody tries
to please him.
		-- Ambrose Bierce, "The Devil's Dictionary"
