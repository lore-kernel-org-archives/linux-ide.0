Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C51C4332F
	for <linux-ide@archiver.kernel.org>; Fri,  9 Dec 2022 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiLIJ05 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 9 Dec 2022 04:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiLIJ0w (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 9 Dec 2022 04:26:52 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2A36C42
        for <linux-ide@vger.kernel.org>; Fri,  9 Dec 2022 01:26:50 -0800 (PST)
Date:   Fri, 09 Dec 2022 09:26:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1670578006; x=1670837206;
        bh=SaQqFGMB4zlTVDIp+8+OylfDuHROWtDOmnto9sohhEY=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=gHq7w2qvZyGBBrKMGibKloUlSTelvDul7KgMA/4vr3P1hZeGWETYYRpBw9uAd4xvz
         UgKbzOEqnM5nd0+FFG/TFSb7m6weINJtgRRZjzjQQmj3cbWABi+uQlR3lao/2fPqAB
         mI3WXsxWb1JnTWGOHHwFLYNFJmwHbYXicNCjRyGgK7+Yb243UXJ1REBCXMDrzI6Lds
         fhY07ZL+pUD6cYDFQf34Tj4sabRwoOOL85smA6IDVrCdlnNRm3gntoctcCkQ8VuU8M
         9oskLQCfkjq1JlDDxx/kWspFonSomMJy5BG1+vBjf+rCFnYX5P1iIxsq9ot7cQkre2
         7C39IxELpg1Yg==
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   Adam Vodopjan <grozzly@protonmail.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v4] ata: ahci: Fix PCS quirk application for suspend
Message-ID: <vl5wEUZGVJ2BjH9t6T0GGSs9qLIE5A7NQkpDYGJB6iFamXyhw1zjnrx-TeO-XJB2doendW_7lDvNblGJLb_YeehRZN0iyUHXyvdQ6Em1aXI=@protonmail.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Since kernel 5.3.4 my laptop (ICH8M controller) does not see Kingston
SV300S37A60G SSD disk connected into a SATA connector on wake from suspend.
The problem was introduced in c312ef176399 "libata/ahci: Drop PCS quirk for
Denverton and beyond": the quirk is not applied on wake from suspend as it
originally was.

It is worth to mention the commit contained another bug: the quirk is not
applied at all to controllers which require it. The fix 09d6ac8dc51a
"libata/ahci: Fix PCS quirk application" landed in 5.3.8. So testing my
patch anywhere between c312ef176399 and 09d6ac8dc51a is pointless.

Not all disks trigger the problem. For example nothing bad happens with
Western Digital WD5000LPCX HDD.

Test hardware:
- Acer 5920G with ICH8M SATA controller
- sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE
caddy. It is a boot disk
- sdb: Kingston SV300S37A60G SSD connected into the only SATA port

Sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:

sd 0:0:0:0: [sda] Starting disk
sd 2:0:0:0: [sdb] Starting disk
ata4: SATA link down (SStatus 4 SControl 300)
ata3: SATA link down (SStatus 4 SControl 300)
ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 (SET FEATURES) filtered out
ata1.00: ACPI cmd ef/03:42:00:00:00:a0 (SET FEATURES) filtered out
ata1: FORCE: cable set to 80c
ata5: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 4 SControl 300)
ata3: SATA link down (SStatus 4 SControl 300)
ata3.00: disabled
sd 2:0:0:0: rejecting I/O to offline device
ata3.00: detaching (SCSI 2:0:0:0)
sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=3DDID_NO_CONNECT
=09driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Synchronizing SCSI cache
sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:
=09hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Stopping disk
sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=3DDID_BAD_TARGET
=09driverbyte=3DDRIVER_OK

c312ef176399 dropped ahci_pci_reset_controller() which internally calls
ahci_reset_controller() and applies the PCS quirk if needed after that. It
was called each time a reset was required instead of just
ahci_reset_controller(). This patch puts the function back in place.

Fixes: c312ef176399 ("libata/ahci: Drop PCS quirk for Denverton and beyond"=
)
Signed-off-by: Adam Vodopjan <grozzly@protonmail.com>
---
 drivers/ata/ahci.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 639de2d75d63..53ab2306da00 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -84,6 +84,7 @@ enum board_ids {
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id =
*ent);
 static void ahci_remove_one(struct pci_dev *dev);
 static void ahci_shutdown_one(struct pci_dev *dev);
+static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_pr=
iv *hpriv);
 static int ahci_vt8251_hardreset(struct ata_link *link, unsigned int *clas=
s,
 =09=09=09=09 unsigned long deadline);
 static int ahci_avn_hardreset(struct ata_link *link, unsigned int *class,
@@ -677,6 +678,25 @@ static void ahci_pci_save_initial_config(struct pci_de=
v *pdev,
 =09ahci_save_initial_config(&pdev->dev, hpriv);
 }

+static int ahci_pci_reset_controller(struct ata_host *host)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(host->dev);
+=09struct ahci_host_priv *hpriv =3D host->private_data;
+=09int rc;
+
+=09rc =3D ahci_reset_controller(host);
+=09if (rc)
+=09=09return rc;
+
+=09/*
+=09 * If platform firmware failed to enable ports, try to enable
+=09 * them here.
+=09 */
+=09ahci_intel_pcs_quirk(pdev, hpriv);
+
+=09return 0;
+}
+
 static void ahci_pci_init_controller(struct ata_host *host)
 {
 =09struct ahci_host_priv *hpriv =3D host->private_data;
@@ -871,7 +891,7 @@ static int ahci_pci_device_runtime_resume(struct device=
 *dev)
 =09struct ata_host *host =3D pci_get_drvdata(pdev);
 =09int rc;

-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;
 =09ahci_pci_init_controller(host);
@@ -907,7 +927,7 @@ static int ahci_pci_device_resume(struct device *dev)
 =09=09ahci_mcp89_apple_enable(pdev);

 =09if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
-=09=09rc =3D ahci_reset_controller(host);
+=09=09rc =3D ahci_pci_reset_controller(host);
 =09=09if (rc)
 =09=09=09return rc;

@@ -1785,12 +1805,6 @@ static int ahci_init_one(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 =09/* save initial config */
 =09ahci_pci_save_initial_config(pdev, hpriv);

-=09/*
-=09 * If platform firmware failed to enable ports, try to enable
-=09 * them here.
-=09 */
-=09ahci_intel_pcs_quirk(pdev, hpriv);
-
 =09/* prepare host */
 =09if (hpriv->cap & HOST_CAP_NCQ) {
 =09=09pi.flags |=3D ATA_FLAG_NCQ;
@@ -1900,7 +1914,7 @@ static int ahci_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
 =09if (rc)
 =09=09return rc;

-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;

--
2.34.1

