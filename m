Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE00C433F5
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 23:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648A6610A0
	for <linux-ide@archiver.kernel.org>; Mon,  8 Nov 2021 23:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241050AbhKIAAN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:00:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50555 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhKIAAN (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 8 Nov 2021 19:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636415848; x=1667951848;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IW+rTFPRMzZz65iH/6YcqC2O5H0yUPET4v9xUL6p6SQ=;
  b=MZ6CwjmV5ssLYLMbCNboCK/X3lYait2nvqgC5EHp801MeKW9ygUjZsZk
   LiOLvNrLoygu1atcv+GoNr56Cfi32N/G+0c6iyVK8W+5bVSKmMGji+tpg
   G5/iefVMQ0/i7eCI3b2BcMlTtvVtnKAYFki2dkCtXRcMNzydyyqXmzVDC
   Rm+oGdcch8RDovGPryOkh9ZkojDtIddsTVPDt7y+om0ZJ3ekQizO9K8sd
   bgcjDGI75N+zkblT7i7L2OCOLYKa8BJ65UBnj/nRGHr/bTZUr/rpa84dE
   8HvGVcLTjfuZ4hoNMWYS6Gut9d1JmqCT3tN/5GCle/Lq+V1zIS4+Wq+rK
   w==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631548800"; 
   d="scan'208";a="288986673"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2021 07:57:27 +0800
IronPort-SDR: HM8pvKR6LN6mmGncyDvNXdTrH5L73fUwh8j/0tDpn9Mfo1dbgc92cr5cQsNk0PoKwQUl8+kq30
 XSwvk6Cnc9VWC+ukv7/5xu9tU6YN0QO/rpm8Lh5hUyy18IzHWziLhfDTMVPoN/LqR2PqiBx+gI
 Weng9mJUZeHy6duT5eAiJ9cc2m+E6yWsy3VjGGAyiyvQ31rClTa4u7xy+tyE4WW/dEqQ+uuray
 QsYlN6S1MAviT7W7wZ270ITuVc0daCX4l7QCom2j4ItmsP8OU7atxAyR9BdAVKu1VszTd6wdfz
 DwkZsReiwc6+QiQMBSPlnWWu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:32:40 -0800
IronPort-SDR: w2cwN15ozP6oDcsVA9p+mnlpdoxP1kmxb21Df3V9AFMsJbLNu1ULkKV0AgcQkaw+aHG1DdgXXM
 peX3zWwGYMpa75pUaZ7u1/jgLSfurI78Xjs1D/OAoTuBLROQDOrZ1hlHz44OhdKidDZV1IyIJH
 DTpfNjcgKKfCnnKpyO/1Ng0x8CtWAAWc7Zx+tm9jxxj4n/KJP7atepu5PCiS3MIzZLg+Q0ko/D
 jNJERE2z00tENQcV9FXnxDUb/PxVyvvxuz9cYJgIyKyOpytTNQiXowUbxBpMXXrr92SIDe4Pdb
 8lk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:57:28 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Hp7MW3h7qz1RtVm
        for <linux-ide@vger.kernel.org>; Mon,  8 Nov 2021 15:57:27 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1636415846;
         x=1639007847; bh=IW+rTFPRMzZz65iH/6YcqC2O5H0yUPET4v9xUL6p6SQ=; b=
        pDXBXEd/+/oZNTAzT7JprmpbnYBqDY9gae5JCrTNibP5qeHrjzPmSC6CZgOK1y6c
        9q1/NmNFguMMNb6sN0LeBJIrIuNWFXLNIezT4H5ysgogV8MnxM6ovr6OhnNh/a2Q
        0ECQnBgVv9Ks1UkD0tGiplOXvyo5RBCm+w0JtbH6fG+effzJEQe6eaii5K/IvGx9
        aW8O8uhMXg+eUOOEYZujF9xhFdBquOFAjvl7gpFLOfqEzIvbETqIK9AsNovmKquk
        hXJnB2srmOgBTaDDP0UcMbzdNM0ERIm2Onr2Dry8E7SryIWNnY3MexIAIISr4E79
        NbbGRUh9PCuT/3DtSbb2Bg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tkwqwBAdYdFa for <linux-ide@vger.kernel.org>;
        Mon,  8 Nov 2021 15:57:26 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Hp7MV2wbJz1RtVl
        for <linux-ide@vger.kernel.org>; Mon,  8 Nov 2021 15:57:26 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Subject: [PATCH] libata: add horkage for missing Identify Device log
Date:   Tue,  9 Nov 2021 08:57:23 +0900
Message-Id: <20211108235723.408711-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

ACS defines the ATA Identify Device Data log as mandatory. A warning
message currently signals to the user if a device does not report
supporting this log page in the log directory page. However, it is
useless to constantly access the log directory and warn about this lack
of support once we have discovered that the device does not support
this mandatory log page.

Introduce the horkage flag ATA_HORKAGE_NO_ID_DEV_LOG to mark a device as
lacking support for the Identify Device Data log page. Set this flag
when ata_log_supported() returns false in ata_identify_page_supported().
The warning is printed only once on device scan and the log directory
not accessed again to test for Identify Device Data log page support.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/libata-core.c | 4 ++++
 include/linux/libata.h    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 3018ca84a3d8..de1eff94c76d 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2052,8 +2052,12 @@ static bool ata_identify_page_supported(struct ata=
_device *dev, u8 page)
 	struct ata_port *ap =3D dev->link->ap;
 	unsigned int err, i;
=20
+	if (dev->horkage & ATA_HORKAGE_NO_ID_DEV_LOG)
+		return false;
+
 	if (!ata_log_supported(dev, ATA_LOG_IDENTIFY_DEVICE)) {
 		ata_dev_warn(dev, "ATA Identify Device Log not supported\n");
+		dev->horkage |=3D ATA_HORKAGE_NO_ID_DEV_LOG;
 		return false;
 	}
=20
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 5331557316e8..2a8404b26083 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -427,6 +427,7 @@ enum {
 	ATA_HORKAGE_MAX_SEC_1024 =3D (1 << 25),	/* Limit max sects to 1024 */
 	ATA_HORKAGE_MAX_TRIM_128M =3D (1 << 26),	/* Limit max trim size to 128M=
 */
 	ATA_HORKAGE_NO_NCQ_ON_ATI =3D (1 << 27),	/* Disable NCQ on ATI chipset =
*/
+	ATA_HORKAGE_NO_ID_DEV_LOG =3D (1 << 28),	/* Identify device log missing=
 */
=20
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
--=20
2.31.1

