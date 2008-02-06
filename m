From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: ide-tape redux (was: Re:)
Date: Wed, 6 Feb 2008 06:27:15 +0100
Message-ID: <20080206052715.GB14349@gollum.tnic>
References: <1202132440-26648-1-git-send-email-petkovbb@gmail.com> <200802050220.22637.bzolnier@gmail.com> <20080206052343.GA14349@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.236]:41960 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbYBFF10 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 00:27:26 -0500
Received: by hu-out-0506.google.com with SMTP id 19so3955068hue.21
        for <linux-ide@vger.kernel.org>; Tue, 05 Feb 2008 21:27:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080206052343.GA14349@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

=2E.. and while we're at it ...

commit c824f79fe4040f7541d7e35c546bb57a22d2fe11
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Wed Feb 6 06:23:10 2008 +0100

    ide-tape: move all struct and other defs to the top
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 9455ce4..398aea8 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -225,6 +225,69 @@ enum {
 	PC_FL_WRITING		=3D (1 <<	5),
 };
=20
+/* Tape door status */
+#define DOOR_UNLOCKED			0
+#define DOOR_LOCKED			1
+#define DOOR_EXPLICITLY_LOCKED		2
+
+/* Tape flag bits values. */
+enum {
+	IDETAPE_FL_IGNORE_DSC		=3D (1 << 0),
+	/* 0 When the tape position is unknown */
+	IDETAPE_FL_ADDRESS_VALID	=3D (1 <<	1),
+	/* Device already opened */
+	IDETAPE_FL_BUSY			=3D (1 << 2),
+	/* Error detected in a pipeline stage */
+	IDETAPE_FL_PIPELINE_ERR	=3D (1 <<	3),
+	/* Attempt to auto-detect the current user block size */
+	IDETAPE_FL_DETECT_BS		=3D (1 << 4),
+	/* Currently on a filemark */
+	IDETAPE_FL_FILEMARK		=3D (1 << 5),
+	/* DRQ interrupt device */
+	IDETAPE_FL_DRQ_INTERRUPT	=3D (1 << 6),
+	/* pipeline active */
+	IDETAPE_FL_PIPELINE_ACTIVE	=3D (1 << 7),
+	/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
+	IDETAPE_FL_MEDIUM_PRESENT	=3D (1 << 8),
+};
+
+/* A define for the READ BUFFER command */
+#define IDETAPE_RETRIEVE_FAULTY_BLOCK	6
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
+	REQ_IDETAPE_READ_BUFFER	=3D (1 << 4),
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
+
 /* A pipeline stage. */
 typedef struct idetape_stage_s {
 	struct request rq;			/* The corresponding request */
@@ -445,68 +508,6 @@ static void ide_tape_put(struct ide_tape_obj *tape=
)
 	mutex_unlock(&idetape_ref_mutex);
 }
=20
-/* Tape door status */
-#define DOOR_UNLOCKED			0
-#define DOOR_LOCKED			1
-#define DOOR_EXPLICITLY_LOCKED		2
-
-/* Tape flag bits values. */
-enum {
-	IDETAPE_FL_IGNORE_DSC		=3D (1 << 0),
-	/* 0 When the tape position is unknown */
-	IDETAPE_FL_ADDRESS_VALID	=3D (1 <<	1),
-	/* Device already opened */
-	IDETAPE_FL_BUSY			=3D (1 << 2),
-	/* Error detected in a pipeline stage */
-	IDETAPE_FL_PIPELINE_ERR	=3D (1 <<	3),
-	/* Attempt to auto-detect the current user block size */
-	IDETAPE_FL_DETECT_BS		=3D (1 << 4),
-	/* Currently on a filemark */
-	IDETAPE_FL_FILEMARK		=3D (1 << 5),
-	/* DRQ interrupt device */
-	IDETAPE_FL_DRQ_INTERRUPT	=3D (1 << 6),
-	/* pipeline active */
-	IDETAPE_FL_PIPELINE_ACTIVE	=3D (1 << 7),
-	/* 0 =3D no tape is loaded, so we don't rewind after ejecting */
-	IDETAPE_FL_MEDIUM_PRESENT	=3D (1 << 8),
-};
-
-/* A define for the READ BUFFER command */
-#define IDETAPE_RETRIEVE_FAULTY_BLOCK	6
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
-	REQ_IDETAPE_READ_BUFFER	=3D (1 << 4),
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
Regards/Gru=DF,
    Boris.
