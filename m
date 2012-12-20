From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] libata: Shut up annoying native_sectors warning
Date: Thu, 20 Dec 2012 13:25:55 +0100
Message-ID: <1356006355-6819-1-git-send-email-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:57186 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab2LTM0D (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Dec 2012 07:26:03 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

I'm getting this

drivers/ata/libata-core.c: In function =E2=80=98ata_hpa_resize=E2=80=99=
:
drivers/ata/libata-core.c:1397:3: warning: =E2=80=98native_sectors=E2=80=
=99 may be used uninitialized in this function [-Wmaybe-uninitialized]

for a couple of kernel releases now with gcc (Debian 4.7.2-4) 4.7.2.

And the warning is bogus because ata_read_native_max_address either
returns a sensible max_sectors aka native_sectors through its second
arg pointer or an error value which is properly handled in its caller
ata_hpa_resize().

So shut up gcc already.

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org
Signed-off-by: Borislav Petkov <bp@alien8.de>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9e8b99af400d..3860f6be8c19 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1324,7 +1324,7 @@ static int ata_hpa_resize(struct ata_device *dev)
 	int print_info =3D ehc->i.flags & ATA_EHI_PRINTINFO;
 	bool unlock_hpa =3D ata_ignore_hpa || dev->flags & ATA_DFLAG_UNLOCK_H=
PA;
 	u64 sectors =3D ata_id_n_sectors(dev->id);
-	u64 native_sectors;
+	u64 native_sectors =3D 0;
 	int rc;
=20
 	/* do we need to do it? */
--=20
1.8.1.rc2

