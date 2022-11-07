Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF32EC433FE
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 04:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKGECg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 23:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiKGECf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 23:02:35 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B95AC1C
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 20:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667793753; x=1699329753;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GVVSyApT1eY0VchTxYjQ1+YYQ25iD5+NDwZU2jU/nCA=;
  b=CjFFilDUokrhgG+2yne+POecZXn35RbE1mpeUR/sY0S7+2jsYly1kQWX
   4nLCyWVrz2b/B6590les87Dtzgj2mcXPZgWc60fX5Zj+iSQo8NkJ6hiq9
   2XwVnLvoXM5VdP+DvnJt8zTkUGwIoM1+JKYT9V32yFjFLxJ4fKvIsJk8o
   cfYcQZsIDkzppMn7r8tkuprjuRCFJnxfZ18CGtoR9PiNy6YJE4bf+Mmar
   JCe4xAMtUA4F8MiQJOx5Ge01UN7i4vZpXp8aWR1ZDwtmBv00CpbTbPr0z
   HsPF1xDjJmjgNtcC8SpTfRRiXgNgTk6W286phHjeMoGtue1ItvOQqwzrO
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="327732269"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 12:02:33 +0800
IronPort-SDR: DtWeR32emf32jXkV1y2d+PDjZCfO68U3WpgAsKw7VJGJ+gIusdSyZDGaREU9c88oiU4leJGHjn
 bBOJhoTNNKFfe/IZgEwTRNGV1cz86XYPpJcR7bNBS4kjkx+l/gdEsSFvtgZqCrWxMg11tI8+tX
 qOtlhm0UOF1c26oE12fUbfJDfsQ/DFyB3a4kQygdvXfSchQxNps3u7eEHvUc2I/MivjZsPt+cJ
 PMGz607CIFgHXWhkGq4/Ze0ANK+PimaRjTWZrHDLDtLwX5dRtwbLieKXZ5MSE60nbyo+CZzy9P
 LxQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 19:15:56 -0800
IronPort-SDR: sGB5fpMkQ/Wfy2wTQlvz4/j1cT5cEmMosfxKXj4IAVNaCVii+QrQzeI4zUm1Io65feLM9ZU6e4
 gNuk1F/U5mCI4ul63aBZwD8ztKYKUAqpqpTo/epEHHh9ygxqaDAcWF5tDxfSfNduwLotT7qdz1
 j0KjK3axhVNivmJPoUMe7OinkbEJOA0sS44iA0CQFTM7Rr4bS00cLsY0TQMrR/Z4TVHMd/Zj9d
 cKkOsuyaJxfRH4YGISuaZAM2w671dGB6sN7vWfvCPzQ7k0p4sPDo6v7z2v1lqB1w2Z4PwV0qiS
 ePI=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Nov 2022 20:02:30 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command failure
Date:   Mon,  7 Nov 2022 13:02:29 +0900
Message-Id: <20221107040229.1548793-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
(10) and (16) commands both shall be translated to ATA flush command.
Also, ZBC Zoned Block Commands specification mandates SYNCHRONIZE CACHE
(16) command support. However, libata translates only SYNCHRONIZE CACHE
(10). This results in SYNCHRONIZE CACHE (16) command failures on SATA
drives and then libata translation does not conform to ZBC. To avoid the
failure, add support for SYNCHRONIZE CACHE (16).

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org
---
Changes from v1:
* Improved commit message per comments on the list

 drivers/ata/libata-scsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e2ebb0b065e2..61cd4e90e4e7 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3264,6 +3264,7 @@ static unsigned int ata_scsiop_maint_in(struct ata_scsi_args *args, u8 *rbuf)
 	case REPORT_LUNS:
 	case REQUEST_SENSE:
 	case SYNCHRONIZE_CACHE:
+	case SYNCHRONIZE_CACHE_16:
 	case REZERO_UNIT:
 	case SEEK_6:
 	case SEEK_10:
@@ -3922,6 +3923,7 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
 		return ata_scsi_write_same_xlat;
 
 	case SYNCHRONIZE_CACHE:
+	case SYNCHRONIZE_CACHE_16:
 		if (ata_try_flush_cache(dev))
 			return ata_scsi_flush_xlat;
 		break;
@@ -4145,6 +4147,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 	 * turning this into a no-op.
 	 */
 	case SYNCHRONIZE_CACHE:
+	case SYNCHRONIZE_CACHE_16:
 		fallthrough;
 
 	/* no-op's, complete with success */
-- 
2.37.1

