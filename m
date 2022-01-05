Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E5C433F5
	for <linux-ide@archiver.kernel.org>; Wed,  5 Jan 2022 05:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiAEFSA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 5 Jan 2022 00:18:00 -0500
Received: from rap-us.hgst.com ([199.255.44.250]:41823 "EHLO
        usg-ed-osssrv.wdc.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237443AbiAEFR5 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 5 Jan 2022 00:17:57 -0500
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JTHmy6zlVz1VSkb
        for <linux-ide@vger.kernel.org>; Tue,  4 Jan 2022 21:17:54 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1641359874; x=1643951875; bh=igD7KXBPcf6kP912Mr
        9O5BzJG3DkVrdQKO8xH3XkiUo=; b=tnddr5E0lPDhXwcdtJXSck8pPlBYOTSYVQ
        wi7YDXKQn9eEmuN+bR1jWWzsVxp9DnoCZfflMT26ColBW0HLPdNKzGHEbbQnkn4s
        kxmIaLoOqCwjCvDE+8QxyPmmjisS7120VxfkMkLoVw9T0KrYl/eMBX2cyI+ZgEC9
        hLGl0AToU3StYWWLT1oDKXyUE46r8GoBiPuFLOsnd46nBltN+UFo8obcQ2ZVPIM3
        GswOMal7oP8Wm5rVtqceQD56o/itH2/0xXJY6LGMGLGpEDS1bxJpf1L5p+Q93f32
        0hdGuMt/z3dAQP9hMzzbx+immVSFQNSBqiHSYq2PEhiv87NP4Mww==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qLbw3KapOklj for <linux-ide@vger.kernel.org>;
        Tue,  4 Jan 2022 21:17:54 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JTHmy1mCvz1VSkg;
        Tue,  4 Jan 2022 21:17:54 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 20/22] ata: sata_fsl: fix cmdhdr_tbl_entry and prde struct definitions
Date:   Wed,  5 Jan 2022 14:17:33 +0900
Message-Id: <20220105051735.1871177-21-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
References: <20220105051735.1871177-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

The fields of the cmdhdr_tbl_entry structure all store __le32 values,
and so are the dba and ddc_and_ext fields of the prde structure. Define
these fields using the __le32 type to avoid sparse warnings about
incorrect type in assignment.

The debug message in sata_fsl_setup_cmd_hdr_entry() is changed to
display the correct values of the cmdhdr_tbl_entry fields on big endian
systems.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ata/sata_fsl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 101d4dd79f62..da0152116d9f 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -221,10 +221,10 @@ enum {
  * 4 Dwords per command slot, command header size =3D=3D  64 Dwords.
  */
 struct cmdhdr_tbl_entry {
-	u32 cda;
-	u32 prde_fis_len;
-	u32 ttl;
-	u32 desc_info;
+	__le32 cda;
+	__le32 prde_fis_len;
+	__le32 ttl;
+	__le32 desc_info;
 };
=20
 /*
@@ -259,9 +259,9 @@ struct command_desc {
  */
=20
 struct prde {
-	u32 dba;
+	__le32 dba;
 	u8 fill[2 * 4];
-	u32 ddc_and_ext;
+	__le32 ddc_and_ext;
 };
=20
 /*
@@ -426,10 +426,10 @@ static void sata_fsl_setup_cmd_hdr_entry(struct ata=
_port *ap,
 	pp->cmdslot[tag].desc_info =3D cpu_to_le32(desc_info | (tag & 0x1F));
=20
 	ata_port_dbg(ap, "cda=3D0x%x, prde_fis_len=3D0x%x, ttl=3D0x%x, di=3D0x%=
x\n",
-		pp->cmdslot[tag].cda,
-		pp->cmdslot[tag].prde_fis_len,
-		pp->cmdslot[tag].ttl, pp->cmdslot[tag].desc_info);
-
+		     le32_to_cpu(pp->cmdslot[tag].cda),
+		     le32_to_cpu(pp->cmdslot[tag].prde_fis_len),
+		     le32_to_cpu(pp->cmdslot[tag].ttl),
+		     le32_to_cpu(pp->cmdslot[tag].desc_info));
 }
=20
 static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cm=
d_desc,
--=20
2.31.1

