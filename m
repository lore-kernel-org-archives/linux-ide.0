From: Borislav Petkov <petkovbb@googlemail.com>
Subject: [PATCH] ide-cd: replace ntohs with generic byteorder macro
	be16_to_cpu
Date: Fri, 8 Feb 2008 07:29:03 +0100
Message-ID: <20080208062903.GA20018@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:49255 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYBHG3T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 01:29:19 -0500
Received: by fk-out-0910.google.com with SMTP id z23so3336918fkz.5
        for <linux-ide@vger.kernel.org>; Thu, 07 Feb 2008 22:29:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

commit d41c6bc739e7ea7880f7f5983a9694f2e0214d92
Author: Borislav Petkov <petkovbb@gmail.com>
Date:   Fri Feb 8 07:25:44 2008 +0100

    ide-cd: replace ntohs with generic byteorder macro be16_to_cpu
   =20
    Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 5e42c19..354c91d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1555,7 +1555,7 @@ int ide_cd_read_toc(ide_drive_t *drive, struct re=
quest_sense *sense)
 	if (stat)
 		return stat;
=20
-	toc->hdr.toc_length =3D ntohs (toc->hdr.toc_length);
+	toc->hdr.toc_length =3D be16_to_cpu(toc->hdr.toc_length);
=20
 	if (info->cd_flags & IDE_CD_FLAG_TOCTRACKS_AS_BCD) {
 		toc->hdr.first_track =3D BCD2BIN(toc->hdr.first_track);
--=20
Regards/Gru=DF,
    Boris.
