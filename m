From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH 1/2] ide-tape: move all struct and other defs at the top
Date: Sat, 9 Feb 2008 20:42:48 +0100
Message-ID: <20080209194247.GE23177@gollum.tnic>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <20080206052343.GA14349@gollum.tnic> <20080206052715.GB14349@gollum.tnic> <200802091725.29207.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.237]:17224 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbYBITnL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 9 Feb 2008 14:43:11 -0500
Received: by wx-out-0506.google.com with SMTP id h31so4360573wxd.4
        for <linux-ide@vger.kernel.org>; Sat, 09 Feb 2008 11:43:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200802091725.29207.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi Bart,

thanks for the update earlier. I'll look into blk_{get,put}_request lat=
er and
try it on idefloppy. In the meantime, here are the patches as requested=
:

---
=46rom 0d91862fc802d6f5aa79947b2685de6c209236f2 Mon Sep 17 00:00:00 200=
1
=46rom: Borislav Petkov <petkovbb@gmail.com>
Date: Sat, 9 Feb 2008 19:48:13 +0100
Subject: [PATCH 1/2] ide-tape: move all struct and other defs at the to=
p

Signed-off-by: Borislav Petkov <petkovbb@gmail.com>
---
 drivers/ide/ide-tape.c |  107 ++++++++++++++++++++++++----------------=
-------
 1 files changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index b3269d7..1fff560 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -225,6 +225,61 @@ typedef struct idetape_packet_command_s {
 /* Data direction */
 #define	PC_WRITING			5
=20
+/* Tape door status */
+#define DOOR_UNLOCKED			0
+#define DOOR_LOCKED			1
+#define DOOR_EXPLICITLY_LOCKED		2
+
+/*
+ *	Tape flag bits values.
+ */
+#define IDETAPE_IGNORE_DSC		0
+/* 0 When the tape position is unknown */
+#define IDETAPE_ADDRESS_VALID		1
+#define IDETAPE_BUSY			2	/* Device already opened */
+/* Error detected in a pipeline stage */
+#define IDETAPE_PIPELINE_ERROR		3
+/* Attempt to auto-detect the current user block size */
+#define IDETAPE_DETECT_BS		4
+#define IDETAPE_FILEMARK		5	/* Currently on a filemark */
+#define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
+#define IDETAPE_READ_ERROR		7
+#define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
+/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
+#define IDETAPE_MEDIUM_PRESENT		9
+
+/* Some defines for the SPACE command */
+#define IDETAPE_SPACE_OVER_FILEMARK	1
+#define IDETAPE_SPACE_TO_EOD		3
+
+/* Some defines for the LOAD UNLOAD command */
+#define IDETAPE_LU_LOAD_MASK		1
+#define IDETAPE_LU_RETENSION_MASK	2
+#define IDETAPE_LU_EOT_MASK		4
+
+/*
+ * Special requests for our block device strategy routine.
+ *
+ * In order to service a character device command, we add special requ=
ests to
+ * the tail of our block device request queue and wait for their compl=
etion.
+ */
+
+enum {
+	REQ_IDETAPE_PC1		=3D (1 << 0), /* packet command (first stage) */
+	REQ_IDETAPE_PC2		=3D (1 << 1), /* packet command (second stage) */
+	REQ_IDETAPE_READ	=3D (1 << 2),
+	REQ_IDETAPE_WRITE	=3D (1 << 3),
+};
+
+/* Error codes returned in rq->errors to the higher part of the driver=
=2E */
+#define	IDETAPE_ERROR_GENERAL		101
+#define	IDETAPE_ERROR_FILEMARK		102
+#define	IDETAPE_ERROR_EOD		103
+
+/* Structures related to the SELECT SENSE / MODE SENSE packet commands=
=2E */
+#define IDETAPE_BLOCK_DESCRIPTOR	0
+#define	IDETAPE_CAPABILITIES_PAGE	0x2a
+
 /* A pipeline stage. */
 typedef struct idetape_stage_s {
 	struct request rq;			/* The corresponding request */
@@ -446,58 +501,6 @@ static void ide_tape_put(struct ide_tape_obj *tape=
)
 	mutex_unlock(&idetape_ref_mutex);
 }
=20
-/* Tape door status */
-#define DOOR_UNLOCKED			0
-#define DOOR_LOCKED			1
-#define DOOR_EXPLICITLY_LOCKED		2
-
-/*
- *	Tape flag bits values.
- */
-#define IDETAPE_IGNORE_DSC		0
-#define IDETAPE_ADDRESS_VALID		1	/* 0 When the tape position is unknow=
n */
-#define IDETAPE_BUSY			2	/* Device already opened */
-#define IDETAPE_PIPELINE_ERROR		3	/* Error detected in a pipeline stag=
e */
-#define IDETAPE_DETECT_BS		4	/* Attempt to auto-detect the current use=
r block size */
-#define IDETAPE_FILEMARK		5	/* Currently on a filemark */
-#define IDETAPE_DRQ_INTERRUPT		6	/* DRQ interrupt device */
-#define IDETAPE_READ_ERROR		7
-#define IDETAPE_PIPELINE_ACTIVE		8	/* pipeline active */
-/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
-#define IDETAPE_MEDIUM_PRESENT		9
-
-/* Some defines for the SPACE command */
-#define IDETAPE_SPACE_OVER_FILEMARK	1
-#define IDETAPE_SPACE_TO_EOD		3
-
-/* Some defines for the LOAD UNLOAD command */
-#define IDETAPE_LU_LOAD_MASK		1
-#define IDETAPE_LU_RETENSION_MASK	2
-#define IDETAPE_LU_EOT_MASK		4
-
-/*
- * Special requests for our block device strategy routine.
- *
- * In order to service a character device command, we add special requ=
ests to
- * the tail of our block device request queue and wait for their compl=
etion.
- */
-
-enum {
-	REQ_IDETAPE_PC1		=3D (1 << 0), /* packet command (first stage) */
-	REQ_IDETAPE_PC2		=3D (1 << 1), /* packet command (second stage) */
-	REQ_IDETAPE_READ	=3D (1 << 2),
-	REQ_IDETAPE_WRITE	=3D (1 << 3),
-};
-
-/* Error codes returned in rq->errors to the higher part of the driver=
=2E */
-#define	IDETAPE_ERROR_GENERAL		101
-#define	IDETAPE_ERROR_FILEMARK		102
-#define	IDETAPE_ERROR_EOD		103
-
-/* Structures related to the SELECT SENSE / MODE SENSE packet commands=
=2E */
-#define IDETAPE_BLOCK_DESCRIPTOR	0
-#define	IDETAPE_CAPABILITIES_PAGE	0x2a
-
 /*
  * The variables below are used for the character device interface. Ad=
ditional
  * state variables are defined in our ide_drive_t structure.
--=20
1.5.3.7



--=20
Regards/Gru=DF,
    Boris.
