From: Kurt Wall <kwall@kurtwerks.com>
Subject: (Fixed Whitespace) Fix make mandocs on libata-scsi.c
Date: Mon, 30 Jan 2006 22:37:06 -0500
Message-ID: <20060131033706.GS1501@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from spooner.celestial.com ([192.136.111.35]:36831 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1030317AbWAaDa7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Jan 2006 22:30:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, linux-ide@vger.kernel.org

"make mandocs" complains when on libata-scsi.c because
ata_scsi_simulate() has undescribed parameters. This patch adds silences 
this warnings by adding descriptions for the undescribed parameters.

Signed-off-by: Kurt Wall <kwall@kurtwerks.com>

--- ./linux-2.6.16-rc1/drivers/scsi/libata-scsi.c.orig	2006-01-21 09:30:59.000000000 -0500
+++ ./linux-2.6.16-rc1/drivers/scsi/libata-scsi.c	2006-01-30 22:34:44.000000000 -0500
@@ -2492,7 +2492,8 @@
 
 /**
  *	ata_scsi_simulate - simulate SCSI command on ATA device
- *	@id: current IDENTIFY data for target device.
+ *	@ap: Port to which command is being sent
+ *	@dev: Device to which to send command
  *	@cmd: SCSI command being sent to device.
  *	@done: SCSI command completion function.
  *
