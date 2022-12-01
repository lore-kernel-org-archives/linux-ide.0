Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F38C4332F
	for <linux-ide@archiver.kernel.org>; Thu,  1 Dec 2022 22:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiLAWvN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLAWuo (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 1 Dec 2022 17:50:44 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3302C4CF9
        for <linux-ide@vger.kernel.org>; Thu,  1 Dec 2022 14:49:48 -0800 (PST)
Date:   Thu, 01 Dec 2022 22:49:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1669934984; x=1670194184;
        bh=bBxjFGE/5LJVpSosjGrisnN6ynueCgHg10xHNRARoJQ=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=eyfIB/jZwFEaFjLqw9Uq29aNt+J83e4N6jQbqKbpr1OPAwW7yOVqBLpUjzeetWGU8
         Zh0JaSQV2NCL1tmvJDaB1ec+/Q9ive4F0z4gixrMpX/tm5TZow0Darf5pYj4lyw5AH
         BO8ZeEsf674iOfCXI594t1oK9mqsgtBuZXi4L4MW7aA4Co2eGQrXaDHdg07xUG7rdT
         1nPWYTNnMDNWvdUoRroVkVE0rezWWVq5W80SRB7F6jExAQA3UMfoU7Z+w0vDzFenAX
         LRHcot5gYQvL9bvUggnh6NObH/Vp/r8aRYppl8sHcYHLWG8l+l95sVxWpDthl6ku6n
         Ky/BOBawn30Dg==
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   grozzly <grozzly@protonmail.com>
Subject: [PATCH] libata/ahci: Fix PCS quirk application for suspend
Message-ID: <GDLzJIZ_OPwuAzIjUg0sSe2tVHaJJvuAvlIv056rty6JTo-noLGRiVuY7YIEb0u-4w0kIZQvP2EwQuoKGwafcglUiXUQCkf6ufsZuv3IjgQ=@protonmail.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is a bug introduced in c312ef176399 "libata/ahci: Drop PCS quirk for =
Denverton and beyond": the quirk is not applied on wake from suspend as it =
originally was. Because of that my laptop (ICH8M controller) doesnt see KIN=
GSTON SV300S37A60G SSD disk connected into a SATA connector on wake since k=
ernel 5.3.4 or better to say 5.3.8 because there was another error in c312e=
f176399 until a fix arrived in 09d6ac8dc51a "libata/ahci: Fix PCS quirk app=
lication". Btw 4.19.y lts branch is affected as well.

The problem somewhy doesnt trigger on another disk though (WD5000LPCX HDD).=
 I discovered it upgrading the laptop with the SSD in place of a HDD with s=
ome 5.4 kernel.

Here is my hardware:
- Acer 5920G with ICH8M SATA controller
- sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE=
 caddy. It is a boot disk to test kernels
- sdb: KINGSTON SV300S37A60G SSD connected into the only SATA port

Booting into vanilla 5.3.8 and beyond (built from upstream sources with con=
figs extracted from https://kernel.ubuntu.com/~kernel-ppa/mainline/) I see =
both disks in lsblk. After wake from suspend the SSD is gone from lsblk out=
put.

Here is sample "dmesg --notime | grep -E '^(sd |ata)'" output on wake:

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
sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=3DDID_NO_CONNECT=
 driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Synchronizing SCSI cache
sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result: hostbyte=3DDID_BAD_=
TARGET driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Stopping disk
sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=3DDID_BAD_TARGET=
 driverbyte=3DDRIVER_OK

The patch is tested on 6.0.10, it solves the problem for my hardware. Compa=
red to c312ef176399, I miraculously revived ahci_pci_reset_controller() and=
 intergrated internals of ahci_intel_pcs_quirk() into it.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c1eca72b4575..2f2c8176808c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -677,6 +677,43 @@ static void ahci_pci_save_initial_config(struct pci_de=
v *pdev,
 =09ahci_save_initial_config(&pdev->dev, hpriv);
 }
=20
+static int ahci_pci_reset_controller(struct ata_host *host)
+{
+=09struct pci_dev *pdev =3D to_pci_dev(host->dev);
+=09const struct pci_device_id *id =3D pci_match_id(ahci_pci_tbl, pdev);
+=09int rc;
+
+=09rc =3D ahci_reset_controller(host);
+=09if (rc)
+=09=09return rc;
+
+=09/*
+=09 * Only apply the 6-port PCS quirk for known legacy platforms.
+=09 * Skip applying the quirk on Denverton and beyond
+=09 */
+=09if (id && id->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
+=09=09=09((enum board_ids) id->driver_data) < board_ahci_pcs7) {
+=09=09struct ahci_host_priv *hpriv =3D host->private_data;
+=09=09u16 tmp16;
+
+=09=09/*
+=09=09 * port_map is determined from PORTS_IMPL PCI register which is
+=09=09 * implemented as write or write-once register.  If the register
+=09=09 * isn't programmed, ahci automatically generates it from number
+=09=09 * of ports, which is good enough for PCS programming. It is
+=09=09 * otherwise expected that platform firmware enables the ports
+=09=09 * before the OS boots.
+=09=09 */
+=09=09pci_read_config_word(pdev, PCS_6, &tmp16);
+=09=09if ((tmp16 & hpriv->port_map) !=3D hpriv->port_map) {
+=09=09=09tmp16 |=3D hpriv->port_map;
+=09=09=09pci_write_config_word(pdev, PCS_6, tmp16);
+=09=09}
+=09}
+
+=09return 0;
+}
+
 static void ahci_pci_init_controller(struct ata_host *host)
 {
 =09struct ahci_host_priv *hpriv =3D host->private_data;
@@ -871,7 +908,7 @@ static int ahci_pci_device_runtime_resume(struct device=
 *dev)
 =09struct ata_host *host =3D pci_get_drvdata(pdev);
 =09int rc;
=20
-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;
 =09ahci_pci_init_controller(host);
@@ -907,7 +944,7 @@ static int ahci_pci_device_resume(struct device *dev)
 =09=09ahci_mcp89_apple_enable(pdev);
=20
 =09if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
-=09=09rc =3D ahci_reset_controller(host);
+=09=09rc =3D ahci_pci_reset_controller(host);
 =09=09if (rc)
 =09=09=09return rc;
=20
@@ -1624,36 +1661,6 @@ static void ahci_update_initial_lpm_policy(struct at=
a_port *ap,
 =09=09ap->target_lpm_policy =3D policy;
 }
=20
-static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_pr=
iv *hpriv)
-{
-=09const struct pci_device_id *id =3D pci_match_id(ahci_pci_tbl, pdev);
-=09u16 tmp16;
-
-=09/*
-=09 * Only apply the 6-port PCS quirk for known legacy platforms.
-=09 */
-=09if (!id || id->vendor !=3D PCI_VENDOR_ID_INTEL)
-=09=09return;
-
-=09/* Skip applying the quirk on Denverton and beyond */
-=09if (((enum board_ids) id->driver_data) >=3D board_ahci_pcs7)
-=09=09return;
-
-=09/*
-=09 * port_map is determined from PORTS_IMPL PCI register which is
-=09 * implemented as write or write-once register.  If the register
-=09 * isn't programmed, ahci automatically generates it from number
-=09 * of ports, which is good enough for PCS programming. It is
-=09 * otherwise expected that platform firmware enables the ports
-=09 * before the OS boots.
-=09 */
-=09pci_read_config_word(pdev, PCS_6, &tmp16);
-=09if ((tmp16 & hpriv->port_map) !=3D hpriv->port_map) {
-=09=09tmp16 |=3D hpriv->port_map;
-=09=09pci_write_config_word(pdev, PCS_6, tmp16);
-=09}
-}
-
 static ssize_t remapped_nvme_show(struct device *dev,
 =09=09=09=09  struct device_attribute *attr,
 =09=09=09=09  char *buf)
@@ -1788,12 +1795,6 @@ static int ahci_init_one(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 =09/* save initial config */
 =09ahci_pci_save_initial_config(pdev, hpriv);
=20
-=09/*
-=09 * If platform firmware failed to enable ports, try to enable
-=09 * them here.
-=09 */
-=09ahci_intel_pcs_quirk(pdev, hpriv);
-
 =09/* prepare host */
 =09if (hpriv->cap & HOST_CAP_NCQ) {
 =09=09pi.flags |=3D ATA_FLAG_NCQ;
@@ -1903,7 +1904,7 @@ static int ahci_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
 =09if (rc)
 =09=09return rc;
=20
-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;

