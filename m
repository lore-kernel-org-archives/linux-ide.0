Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56836C48BE5
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26964610EA
	for <linux-ide@archiver.kernel.org>; Tue, 15 Jun 2021 19:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOTKH (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 15 Jun 2021 15:10:07 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:23860 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230299AbhFOTKH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jun 2021 15:10:07 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FJ2RKp030043
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 15:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=L03ViAwb+0UYFh+FCQrWmeTfOKa0tSmSwdRItbxlsno=;
 b=g4+SVdICImcKcHxv4+OOd8Vo+StDyjP5ABugOhzEAvBRMdffw3U4cfOqP8GLAA2lVPfD
 5h7BUphruoJ6KWy4s+DOPQP0exePRGbFSjVaPBK3mfRMIu91ypBx/jJZVENrNLLmKFxX
 wLn89UjdyWstcVBZzP713fnXLCqB9zLfrdjfzv/lHHFbiO+1JXpnwfeICYnmKDsf12vM
 5VLVZSUxwK2bdSA+iv5Re/K6cFEoIrMFHg8pqIZ5nEin38b+zuydLiG3mcJahF+3i2/z
 0XhxgByrUbPQpuvoDrM+TtrtJSestRvdTBZFXr2MoP57+9cPR+hsahixYcrdOWBe7Jpd ug== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 396bep6m02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 15:08:02 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FJ0k3u102805
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 15:08:02 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 396p8gn5u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-ide@vger.kernel.org>; Tue, 15 Jun 2021 15:08:02 -0400
X-LoopCount0: from 10.177.160.151
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.83,276,1616475600"; 
   d="scan'208";a="616574870"
From:   Charles Rose <charles.rose@dell.com>
To:     linux-ide@vger.kernel.org, axboe@kernel.dk, hdegoede@redhat.com
Cc:     charles.rose@dell.com, Mika Westerberg <mika.westerberg@intel.com>
Subject: [PATCH] ahci: Add support for Dell S140 and later controllers
Date:   Tue, 15 Jun 2021 14:08:01 -0500
Message-Id: <20210615190801.1744466-1-charles.rose@dell.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_07:2021-06-15,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150119
X-Proofpoint-GUID: 1arVvBjezX10asLG7cmK5gqSyOS6E7EE
X-Proofpoint-ORIG-GUID: 1arVvBjezX10asLG7cmK5gqSyOS6E7EE
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106150119
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

This patch enables support for Dell S140 and later controllers
that use Intel's PCHs configured as PCI_CLASS_STORAGE_RAID.

Reviewed-by: Mika Westerberg <mika.westerberg@intel.com>
Signed-off-by: Charles Rose <charles.rose@dell.com>
---
 drivers/ata/ahci.c      | 4 ++++
 include/linux/pci_ids.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 33192a8f687d..186cbf90c8ea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -446,6 +446,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
 
+	/* Dell S140/S150 */
+	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_SUBVENDOR_ID_DELL, PCI_ANY_ID,
+	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
+
 	/* VIA */
 	{ PCI_VDEVICE(VIA, 0x3349), board_ahci_vt8251 }, /* VIA VT8251 */
 	{ PCI_VDEVICE(VIA, 0x6287), board_ahci_vt8251 }, /* VIA VT8251 */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa5293d76..803ec446a729 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -631,6 +631,8 @@
 #define PCI_DEVICE_ID_DELL_RAC4		0x0012
 #define PCI_DEVICE_ID_DELL_PERC5	0x0015
 
+#define PCI_SUBVENDOR_ID_DELL		0x1028
+
 #define PCI_VENDOR_ID_MATROX		0x102B
 #define PCI_DEVICE_ID_MATROX_MGA_2	0x0518
 #define PCI_DEVICE_ID_MATROX_MIL	0x0519
-- 
2.25.4

