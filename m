Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC03EC433EF
	for <linux-ide@archiver.kernel.org>; Wed, 23 Mar 2022 08:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiCWIVI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Mar 2022 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbiCWIUz (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 23 Mar 2022 04:20:55 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9695F258
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648023564; x=1679559564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH3g2J369m+VFqjsSEy8Cr91eBjEqsszX9b0beiRxtg=;
  b=Ec0Ycxe7xjgy/OzTsjKCnYGAC6OSGlSr105gpufc8ZnU8NOyXDC2uE/3
   U4vGavM80vEGlFHtv+fWN/7heRSuph8bHeoaXn6HKUO9nynx9xnRn4sRe
   9P9bQf5irbSG+ov6x8mK/RSLu5CzwX227xUaLC+x2KLJ2RpNfijvRx1Pc
   rkEBpcOVT6AFFJo96LWP7eGPa7lrZ49YVybGXaBzEWVAc14/JASRVXXnO
   r9Rh3/zmbt4uyBc+M3RyO7dirKrHZpkf6BQbc8dfxZnvRG06/op3Lkml0
   jdHblkLo08lmf4VmDHTtznghgMvTHLc38CFzB2vT/HLXQBjJQjkxqlnxS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="196047609"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 16:19:23 +0800
IronPort-SDR: 58fBmP7FN9zSaLQBqlKJlwDnRunMUcXsvIZvyvp8/KHVZqN2BZBhIsd7PDfeWyt497np+5C7ve
 /KbU1Qo086+0YEue0xMjGaSCBAUnhu4zIZ4W7qIENBCUXSxvBC76kNQc84Jhha0U7hy2Fq1agd
 OqACqCIChUQNHz7lIJcqckoEHno12vlMNZW+fcMw9Yuy/blnVzFg9s819eSjMvhpFHMBxqnCiy
 lc8HsYTwVt6oozMxB21V42qYjbu3z9j8jaU5BRF941O48F7YQp429AqjoabKvS+2CN4uKcc0dA
 fWfEkJDMGARbnlmoxjHr6ini
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:51:19 -0700
IronPort-SDR: kLOzs1+O/pgDSUokOWr0+6FVUoxhiQjONMzSRC6thu38nCHrE2dyRejebd45YKyZXLGFtvGL/8
 uOikXPgg2j0ztn9BMKMr9+xtv50sgnZ7B78oVo56kySCNp5kV1YwLUIbqRvDOzgBRf3gQXNB15
 6mNpzZBoZAS13GRAAjc94p+7OUCEOTjyjPc7oyWttDZGxg+SKk6q80T80Dhwr+kjmqRBGqphRv
 MhGB2QuGm1iCo+ycSL4BPtUq4RufPqkMCFsQFEAh2odYUJ0IjSYFFSQWE/DtRPuIJyKx+e8LYg
 /20=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:19:25 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KNh8r6dn5z1SHwl
        for <linux-ide@vger.kernel.org>; Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1648023564; x=1650615565; bh=FH3g2J369m+VFqjsSE
        y8Cr91eBjEqsszX9b0beiRxtg=; b=GBTX9SwEoFfTj7PJXsvF2Hch4tVGa9B4nd
        yrec1qCXMO0WUkJx9N7bI1BFtrvz/IrlnjwzDUrGTpnuq+udDQxhTV0CWfEI85ih
        d/pY/yrh0Jm2uJCTMqIN79gJbNRrW3Vhtcqs3QVCxmmzhYHHH74XX8vM0R9NKNMg
        sNE8xSCqUKpACQCJccI3zM2e4VjGz5BA/x48Kc86t1PTEP7daDp5PLu475aMCfTy
        wv6F9vI/l2b4hbeRS/aDEjbNtOzpdoCybMo/5JWwDt/j6XTzt8z64UpA0u9SR25o
        xQlGiHKw1IisQYDk14eWBLRFMW3/PoXhDGqQJ1O3rqyHZotbdXyg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lXK8OWDhn04E for <linux-ide@vger.kernel.org>;
        Wed, 23 Mar 2022 01:19:24 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KNh8r0B77z1Rwrw;
        Wed, 23 Mar 2022 01:19:23 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     linux-ide@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH 3/4] ata: libata-sata: Remove debounce delay by default
Date:   Wed, 23 Mar 2022 17:17:39 +0900
Message-Id: <20220323081740.540006-4-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
References: <20220323081740.540006-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Many adapters and SATA controllers are fine with accesses to the
SControl register right after resuming. For these adapters, the
additional 200ms delay implemented in sata_link_resume() is redundant
and unnecessarily increase boot time.

Drivers can opt out from this additional delay using the
ATA_LFLAG_NO_DEBOUNCE_DELAY link flag, but by default, this additional
delay exists for all adapters.

Reverse the situation and do not add by default this 200ms delay. For
adapters that actually need this delay, rename the
ATA_LFLAG_NO_DEBOUNCE_DELAY link flag to ATA_LFLAG_DEBOUNCE_DELAY and
execute the 200ms delay in sata_link_resume() only if a driver request
it using the new link flag. Otherwise, arbitrarily delay by 1ms only.

Since ata_piix adapters are known to require the longer delay, specify
the ATA_LFLAG_DEBOUNCE_DELAY for all adapters supported by the ata_piix
driver.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/ata/ahci.c        | 12 ++----------
 drivers/ata/ahci_brcm.c   |  1 -
 drivers/ata/ata_generic.c |  1 +
 drivers/ata/ata_piix.c    | 17 +++++++++++++++++
 drivers/ata/libata-sata.c | 18 +++++++++++-------
 include/linux/libata.h    |  2 +-
 6 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index ccf94e8a3056..ac1e227a07cd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -51,7 +51,6 @@ enum board_ids {
 	board_ahci,
 	board_ahci_ign_iferr,
 	board_ahci_low_power,
-	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
@@ -142,13 +141,6 @@ static const struct ata_port_info ahci_port_info[] =3D=
 {
 		.udma_mask	=3D ATA_UDMA6,
 		.port_ops	=3D &ahci_ops,
 	},
-	[board_ahci_no_debounce_delay] =3D {
-		.flags		=3D AHCI_FLAG_COMMON,
-		.link_flags	=3D ATA_LFLAG_NO_DEBOUNCE_DELAY,
-		.pio_mask	=3D ATA_PIO4,
-		.udma_mask	=3D ATA_UDMA6,
-		.port_ops	=3D &ahci_ops,
-	},
 	[board_ahci_nomsi] =3D {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		=3D AHCI_FLAG_COMMON,
@@ -445,7 +437,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D =
{
 		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
-	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Huds=
on-2 (AHCI mode) */
+	{ PCI_VDEVICE(AMD, 0x7801), board_ahci }, /* AMD Hudson-2 (AHCI mode) *=
/
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardin=
e */
 	/* AMD is using RAID class only for ahci controllers */
@@ -583,7 +575,7 @@ static const struct pci_device_id ahci_pci_tbl[] =3D =
{
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9235),
-	  .driver_data =3D board_ahci_no_debounce_delay },
+	  .driver_data =3D board_ahci },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L *=
/
 	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L *=
/
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index ab8552b1ff2a..e4584aed0ded 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -333,7 +333,6 @@ static struct ata_port_operations ahci_brcm_platform_=
ops =3D {
=20
 static const struct ata_port_info ahci_brcm_port_info =3D {
 	.flags		=3D AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	=3D ATA_LFLAG_NO_DEBOUNCE_DELAY,
 	.pio_mask	=3D ATA_PIO4,
 	.udma_mask	=3D ATA_UDMA6,
 	.port_ops	=3D &ahci_brcm_platform_ops,
diff --git a/drivers/ata/ata_generic.c b/drivers/ata/ata_generic.c
index 20a32e4d501d..f02c824b26e6 100644
--- a/drivers/ata/ata_generic.c
+++ b/drivers/ata/ata_generic.c
@@ -165,6 +165,7 @@ static int ata_generic_init_one(struct pci_dev *dev, =
const struct pci_device_id
 	u16 command;
 	static const struct ata_port_info info =3D {
 		.flags =3D ATA_FLAG_SLAVE_POSS,
+		.link_flags =3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask =3D ATA_PIO4,
 		.mwdma_mask =3D ATA_MWDMA2,
 		.udma_mask =3D ATA_UDMA5,
diff --git a/drivers/ata/ata_piix.c b/drivers/ata/ata_piix.c
index ade5e894563b..dcfcfb5d8a05 100644
--- a/drivers/ata/ata_piix.c
+++ b/drivers/ata/ata_piix.c
@@ -1112,6 +1112,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[piix_pata_mwdma] =3D	/* PIIX3 MWDMA only */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok =
but slow */
 		.port_ops	=3D &piix_pata_ops,
@@ -1120,6 +1121,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[piix_pata_33] =3D	/* PIIX4 at 33MHz */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok =
but slow */
 		.udma_mask	=3D ATA_UDMA2,
@@ -1129,6 +1131,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich_pata_33] =3D		/* ICH0 - ICH at 33Mhz*/
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* Check: maybe MWDMA0 is ok  */
 		.udma_mask	=3D ATA_UDMA2,
@@ -1138,6 +1141,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich_pata_66] =3D		/* ICH controllers up to 66MHz */
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* MWDMA0 is broken on chip */
 		.udma_mask	=3D ATA_UDMA4,
@@ -1147,6 +1151,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich_pata_100] =3D
 	{
 		.flags		=3D PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY,
 		.udma_mask	=3D ATA_UDMA5,
@@ -1156,6 +1161,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich_pata_100_nomwdma1] =3D
 	{
 		.flags		=3D PIIX_PATA_FLAGS | PIIX_FLAG_CHECKINTR,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2_ONLY,
 		.udma_mask	=3D ATA_UDMA5,
@@ -1165,6 +1171,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich5_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1174,6 +1181,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich6_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1183,6 +1191,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich6m_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1192,6 +1201,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1201,6 +1211,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_2port_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1210,6 +1221,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[tolapai_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1219,6 +1231,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8m_apple_sata] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1228,6 +1241,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[piix_pata_vmw] =3D
 	{
 		.flags		=3D PIIX_PATA_FLAGS,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA12_ONLY, /* mwdma1-2 ?? CHECK 0 should be ok =
but slow */
 		.udma_mask	=3D ATA_UDMA2,
@@ -1241,6 +1255,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_sata_snb] =3D
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO16,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1251,6 +1266,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	{
 		.flags		=3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR
 					| PIIX_FLAG_PIO16,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask	=3D ATA_PIO4,
 		.mwdma_mask	=3D ATA_MWDMA2,
 		.udma_mask	=3D ATA_UDMA6,
@@ -1260,6 +1276,7 @@ static struct ata_port_info piix_port_info[] =3D {
 	[ich8_2port_sata_byt] =3D
 	{
 		.flags          =3D PIIX_SATA_FLAGS | PIIX_FLAG_SIDPR | PIIX_FLAG_PIO1=
6,
+		.link_flags	=3D ATA_LFLAG_DEBOUNCE_DELAY,
 		.pio_mask       =3D ATA_PIO4,
 		.mwdma_mask     =3D ATA_MWDMA2,
 		.udma_mask      =3D ATA_UDMA6,
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index be46833d77a6..87ad03c2e49f 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -302,9 +302,18 @@ static int __sata_link_resume(struct ata_link *link,
 			      unsigned long deadline)
 {
 	int tries =3D ATA_LINK_RESUME_TRIES;
+	unsigned int db_delay =3D 1;
 	u32 scontrol, serror;
 	int rc;
=20
+	/*
+	 * Some PHYs react badly if SControl is pounded immediately after
+	 * resuming. For drivers requesting it, delay 200ms before debouncing.
+	 * Otherwise, only delay by 1ms (arbitrary delay).
+	 */
+	if (link->flags & ATA_LFLAG_DEBOUNCE_DELAY)
+		db_delay =3D 200;
+
 	if ((rc =3D sata_scr_read(link, SCR_CONTROL, &scontrol)))
 		return rc;
=20
@@ -317,13 +326,8 @@ static int __sata_link_resume(struct ata_link *link,
 		scontrol =3D (scontrol & 0x0f0) | 0x300;
 		if ((rc =3D sata_scr_write(link, SCR_CONTROL, scontrol)))
 			return rc;
-		/*
-		 * Some PHYs react badly if SStatus is pounded
-		 * immediately after resuming.  Delay 200ms before
-		 * debouncing.
-		 */
-		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
-			ata_msleep(link->ap, 200);
+
+		ata_msleep(link->ap, db_delay);
=20
 		/* is SControl restored correctly? */
 		if ((rc =3D sata_scr_read(link, SCR_CONTROL, &scontrol)))
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 166263d9bbc7..cc3a8e9c78b0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -143,7 +143,7 @@ enum {
 	ATA_LFLAG_NO_LPM	=3D (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	=3D (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	=3D (1 << 10), /* LPM state changed on this link */
-	ATA_LFLAG_NO_DEBOUNCE_DELAY =3D (1 << 11), /* no debounce delay on link=
 resume */
+	ATA_LFLAG_DEBOUNCE_DELAY =3D (1 << 11), /* Debounce delay on link resum=
e */
=20
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	=3D (1 << 0), /* host supports slave dev */
--=20
2.35.1

