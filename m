Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B57CA0FF3
	for <linux-ide@archiver.kernel.org>; Fri,  1 Sep 2023 18:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjIASYA (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 1 Sep 2023 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350573AbjIASX7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 1 Sep 2023 14:23:59 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAD19E
        for <linux-ide@vger.kernel.org>; Fri,  1 Sep 2023 11:23:56 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381E9GLn009032
        for <linux-ide@vger.kernel.org>; Fri, 1 Sep 2023 11:23:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=wyV2jqoQ3Z3yyOPF29+Co3RyUIBzoTWzHWUL149KlXA=;
 b=lIzJyYozgnjOXy1j7Nomt489Ur9PxEanaMpxm/GdvHRqdJx5Bqa1e+ZgAXfImlEH6Nj8
 qX18TT3rjiJVseWmwqtuGNk3J2p04TpjHqluflViwzXGh+05y0xDdv8pcx1Ko91kmSKi
 FBHXUin4O92YgkhpnzgySEFYXFIE41wy5wso2JADXiqA78SPDqm5L9vz+Vwax8jSOfiv
 OM8OudS30GpC2Jb/ZVuFeJT0+emaULcCEOVZjw1EVKjA4hdrGz+5nqea+3mfWuWKyUlT
 bQhkKrrsHpV5AcPLjm58NFoGEJjyXrNPNVtUpv5GQxzWuvJ3urJ1xTEcIJXd1DtyTlNC ow== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3su3rqju01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-ide@vger.kernel.org>; Fri, 01 Sep 2023 11:23:47 -0700
Received: from twshared2388.07.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 1 Sep 2023 11:23:39 -0700
Received: by devvm5565.lla0.facebook.com (Postfix, from userid 378941)
        id E0D42126E33A; Fri,  1 Sep 2023 11:23:34 -0700 (PDT)
From:   Pawel Zmarzly <pzmarzly@meta.com>
To:     Damien Le Moal <dlemoal@kernel.org>, <Niklas.Cassel@wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pawel Zmarzly <pzmarzly@meta.com>
Subject: [PATCH v2] ata: Disable NCQ_TRIM on Micron 1100 drives
Date:   Fri, 1 Sep 2023 11:23:17 -0700
Message-ID: <20230901182317.3243660-1-pzmarzly@meta.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZPGznkRMxemW2N9E@x1-carbon>
References: <ZPGznkRMxemW2N9E@x1-carbon>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n_nzKED7VucDVRqcUOKaXxO0w7IEfAXN
X-Proofpoint-GUID: n_nzKED7VucDVRqcUOKaXxO0w7IEfAXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_15,2023-08-31_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Micron 1100 drives lock up when encountering queued TRIM command.
It is a quite old hardware series, for past years we have been
running our machines with these drives using
libata.force=3Dnoncqtrim.
---
V1 -> V2: Fixed formatting.
---
 drivers/ata/libata-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 175b2a9dc000..116f5fd6e3f7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
 	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
 						ATA_HORKAGE_ZERO_AFTER_TRIM, },
+	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
+						ATA_HORKAGE_ZERO_AFTER_TRIM, },

 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
--
2.39.3
