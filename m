From: Fang Wenqi <anton.fang@gmail.com>
Subject: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Wed, 21 Apr 2010 22:07:26 +0800
Message-ID: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42605 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0DUOHJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Apr 2010 10:07:09 -0400
Received: by wyb39 with SMTP id 39so4052893wyb.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Apr 2010 07:07:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@redhat.com, linux-ide@vger.kernel.org
Cc: antonf@turbolinux.com.cn, anton.fang@gmail.com

  CC      drivers/ata/libata-eh.o
drivers/ata/libata-eh.c: In function =E2=80=98ata_eh_analyze_ncq_error=E2=
=80=99:
drivers/ata/libata-eh.c:1642: warning: =E2=80=98tf.flags=E2=80=99 may b=
e used uninitialized in this function

Signed-off-by: Fang Wenqi <antonf@turbolinux.com.cn>
---
 drivers/ata/libata-eh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 9f6cfac..125ec25 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1601,7 +1601,7 @@ void ata_eh_analyze_ncq_error(struct ata_link *li=
nk)
 	struct ata_eh_context *ehc =3D &link->eh_context;
 	struct ata_device *dev =3D link->device;
 	struct ata_queued_cmd *qc;
-	struct ata_taskfile tf;
+	struct ata_taskfile uninitialized_var(tf);
 	int tag, rc;
=20
 	/* if frozen, we can't do much */
--=20
1.6.6.1

