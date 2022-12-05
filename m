Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F64BC4708E
	for <linux-ide@archiver.kernel.org>; Mon,  5 Dec 2022 22:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiLEWL7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 5 Dec 2022 17:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiLEWLw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 5 Dec 2022 17:11:52 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77761A3A2
        for <linux-ide@vger.kernel.org>; Mon,  5 Dec 2022 14:11:50 -0800 (PST)
Date:   Mon, 05 Dec 2022 22:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1670278306; x=1670537506;
        bh=XJvrqB9pEdpH2QMp0uoC2a14ytuTFY4olJU8B43Y5co=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=dqEzs1o6xj4tPMjaJHS2vyzqotirDufXygezXtfPnKsa21BEr94VMDUCypSREUHj5
         tOffm7fvCPkNbEC9wgcdFRgl5klj7UDbWHUe/OLHhRYx5CxzPoZkpOFWX9ebNR6WoJ
         4NIZ8UVXyOAO2eXHbiTab4+X6SwoNomvB684GKxuXOpa76DHlvgMCY7cA77qqnz8tq
         mcZ+JM4qDZqO+TfAxajDbNJZSrT/qPQ3FzvtuBYxgdeQj/49136L9veUbvk6TJ67Gt
         BG71rsjeGT7cKiAM/YRuAhLGuZWK6KyQYeQD3wkTDlyyfmCWDVno2D2IlDLaCxKQMz
         KOlej/S6ZxiYg==
To:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
From:   grozzly <grozzly@protonmail.com>
Subject: [PATCH v2] libata/ahci: Fix PCS quirk application for suspend
Message-ID: <fLroqLOFhUGt2lB-B8_AtSA_DAiSquwKdghmGqsgLPJUZy3dz9DN81T2CE9aOJs2h9f0ZQrWvEmz5W7Xu3XE4ESlwCXNVfJoqnhc637ObGs=@protonmail.com>
Feedback-ID: 34388925:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

There is a bug introduced in c312ef176399 "libata/ahci: Drop PCS quirk for=
=20
Denverton and beyond": the quirk is not applied on wake from suspend as it=
=20
originally was. Because of that my laptop (ICH8M controller) doesnt see=20
KINGSTON SV300S37A60G SSD disk connected into a SATA connector on wake=20
since kernel 5.3.4 or better to say 5.3.8 because there was another error=
=20
in c312ef176399 until a fix arrived in 09d6ac8dc51a "libata/ahci: Fix PCS=
=20
quirk application". Btw 4.19.y lts branch is affected as well.

The problem somewhy doesnt trigger on another disk though (WD5000LPCX HDD).=
=20
I discovered it upgrading the laptop with the SSD in place of a HDD with=20
some 5.4 kernel.

Here is my hardware:
- Acer 5920G with ICH8M SATA controller
- sda: some SATA HDD connnected into the DVD drive IDE port with a SATA-IDE=
=20
caddy. It is a boot disk to test kernels
- sdb: KINGSTON SV300S37A60G SSD connected into the only SATA port

Booting into vanilla 5.3.8 and beyond (built from upstream sources with=20
configs extracted from https://kernel.ubuntu.com/~kernel-ppa/mainline/) I=
=20
see both disks in lsblk. After wake from suspend the SSD is gone from lsblk=
=20
output.

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
=20
driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Synchronizing SCSI cache
sd 2:0:0:0: [sdb] Synchronize Cache(10) failed: Result:=20
hostbyte=3DDID_BAD_TARGET driverbyte=3DDRIVER_OK
sd 2:0:0:0: [sdb] Stopping disk
sd 2:0:0:0: [sdb] Start/Stop Unit failed: Result: hostbyte=3DDID_BAD_TARGET=
=20
driverbyte=3DDRIVER_OK

The patch is tested on 6.0.10, it solves the problem for my hardware.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index c1eca72b4575..28d8c56cb4dd 100644
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
=20
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
=20
-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;
 =09ahci_pci_init_controller(host);
@@ -907,7 +927,7 @@ static int ahci_pci_device_resume(struct device *dev)
 =09=09ahci_mcp89_apple_enable(pdev);
=20
 =09if (pdev->dev.power.power_state.event =3D=3D PM_EVENT_SUSPEND) {
-=09=09rc =3D ahci_reset_controller(host);
+=09=09rc =3D ahci_pci_reset_controller(host);
 =09=09if (rc)
 =09=09=09return rc;
=20
@@ -1788,12 +1808,6 @@ static int ahci_init_one(struct pci_dev *pdev, const=
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
@@ -1903,7 +1917,7 @@ static int ahci_init_one(struct pci_dev *pdev, const =
struct pci_device_id *ent)
 =09if (rc)
 =09=09return rc;
=20
-=09rc =3D ahci_reset_controller(host);
+=09rc =3D ahci_pci_reset_controller(host);
 =09if (rc)
 =09=09return rc;

