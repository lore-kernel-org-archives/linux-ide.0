Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4881C4332F
	for <linux-ide@archiver.kernel.org>; Mon,  7 Nov 2022 00:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKGArs (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 6 Nov 2022 19:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGArr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 6 Nov 2022 19:47:47 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BAEBF56
        for <linux-ide@vger.kernel.org>; Sun,  6 Nov 2022 16:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667782067; x=1699318067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qrwowf62LoS5yJiBWel+BzhECjTtSrv7GdBcHRwPrqk=;
  b=Xe0dPSngh0zvHRqMStz/MJ6dUtwoeSYrBljdtoqE9pKqI8HdDVriDDka
   xCQhYjCqfERP5/b1x3jmJ9Vnuu227bK/KB6uub67at1UPNyFWdZFXkGio
   1FWNZo9zKayF6i3iI9+po+0V3IKnZq3UC2ev2bqbfTm46d6vEQkFrvesG
   PCNR5gvcYK1U8IZMZpp7Y4ZBMeSzgymu5YOAN8JBnvQPRZ/DL9jDsonVa
   dU9RjakX7mP7Xmqqm7WltBwu/TwCIncqEeuc4VEdJG4QVio8WFVYn2v6M
   LkQtM3cEGM7FJowT9XUFnOQy1gRu5g9tvI27Mur/t58GgoOi7wOejTkdV
   w==;
X-IronPort-AV: E=Sophos;i="5.96,143,1665417600"; 
   d="scan'208";a="215620059"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2022 08:47:46 +0800
IronPort-SDR: gWeUWGB3VZPLdFYAGPZ/fTlyMg3O5Z2E1lt60DuZlGp4BVWlRBk0hC9LMKXvaSFGccYNuf4o2x
 GgEpddsnkrsxAQCh2rgVqxvoLzxYtjcoxvcTNX1/KNuFbOW/9/rA1kZkOzRxXB7j1cUiDrMpgk
 kDnY/4JUHAFozLJaqASPApd62WvrWJeyhTNkyOoLiXg6QRjCPEy921RzNZS+r4I94/gCDcMmYr
 0PChs0qJy5fkUKjemoRmft/2e5T45Chx9390w5I3MqVIfXg8mkJRde8+CfosA5Xp/HsaVucjlL
 2iE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Nov 2022 16:06:54 -0800
IronPort-SDR: lLo5cLLHuVwBUmygHWtQWohgnwF/tvGk2iBxeZCSKCImHUp1P2rIkTMjYOG3FayRmyivnL6rNY
 vqZ5tHjPFHJMZxzEj5NWCfRX54wUMaUkzPQNSQoj05+QklcCwuFCgGP22K3FFLFKrk+9eNrl3e
 mHuwowgIcRSkB3nUk3cWm0hXu2aF4xBZn4ffC+fOtW+QiwezgrCqRUphQIs2cchpj7szWxLibW
 4iekiJEbsSm6hBt1isnjFl9YuRnkg7OEoNyW+FxniYRrDiS/NR5rbm9CLfPQDsXgguEWXtD9s4
 c9k=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Nov 2022 16:47:46 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] ata: libata-scsi: fix SYNCHRONIZE CACHE (16) command failure
Date:   Mon,  7 Nov 2022 09:47:45 +0900
Message-Id: <20221107004745.1540270-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SAT SCSI/ATA Translation specification requires SCSI SYNCHRONIZE CACHE
(10) and (16) commands both shall be translated to ATA flush command.
However, libata translates only SYNCHRONIZE CACHE (10). This results in
SYNCHRONIZE CACHE (16) command failures. To avoid the failure, add
support for SYNCHRONIZE CACHE (16).

This patch conflicts with kernels version 5.4 and older. Conflict
resolution will be required to back port to them.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: stable@vger.kernel.org # v5.10+
---
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

