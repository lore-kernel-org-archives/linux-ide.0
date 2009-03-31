From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] at91_ide: fix ->ftf_flags handling
Date: Tue, 31 Mar 2009 19:34:30 +0200
Message-ID: <200903311934.30792.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:53574 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522AbZCaR7F (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Mar 2009 13:59:05 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fix some incorrect IDE_FTFLAG_* changes which slipped in commit
"ide: add "flagged" taskfile flags to struct ide_taskfile (v2)"
(commit 19710d25d50ae0be05eebe4231ed8918b1092d82) few days ago.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/at91_ide.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: b/drivers/ide/at91_ide.c
===================================================================
--- a/drivers/ide/at91_ide.c
+++ b/drivers/ide/at91_ide.c
@@ -192,10 +192,10 @@ static void at91_ide_tf_load(ide_drive_t
 	struct ide_taskfile *tf = &cmd->tf;
 	u8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
 
-	if (cmd->tf_flags & IDE_FTFLAG_FLAGGED)
+	if (cmd->ftf_flags & IDE_FTFLAG_FLAGGED)
 		HIHI = 0xFF;
 
-	if (cmd->tf_flags & IDE_FTFLAG_OUT_DATA) {
+	if (cmd->ftf_flags & IDE_FTFLAG_OUT_DATA) {
 		u16 data = (tf->hob_data << 8) | tf->data;
 
 		at91_ide_output_data(drive, NULL, &data, 2);
@@ -233,7 +233,7 @@ static void at91_ide_tf_read(ide_drive_t
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	struct ide_taskfile *tf = &cmd->tf;
 
-	if (cmd->tf_flags & IDE_FTFLAG_IN_DATA) {
+	if (cmd->ftf_flags & IDE_FTFLAG_IN_DATA) {
 		u16 data;
 
 		at91_ide_input_data(drive, NULL, &data, 2);
