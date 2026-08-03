Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371E33A715;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769443; cv=none; b=ZRoycrHJAkugP36aOotmqrHidPmTB2DqsghseEY0SwxIWbhVhw8g2ipSRlymAioIl1OZi2Z4PMxm6l2IGso5j6ggmtdzjpoWQmT/2cs1qVm/R2gsSdmplkGK63MK3xzJeMNQMwp2Yny8gkktpxqA8XrXpiAAlZxh7oX9bux9zzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769443; c=relaxed/simple;
	bh=I9kKXk45Fx/bC1i8ICXNMpf3fIxhgN36l0pxu7VEFCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GI15q/ElbuHguR0uJBKNJg8jSQarXh6ju3h5FqryEG5J/+s6GXs7ld6BXfUweToYsrp4aPuB9TpjimcHOlwWGe4BjiYgVhAk2nw1yJtsX+Ala0MaBXYFWsZm4kbxnfOTftsM2M0VRdvLVGEl1qREKYCknRisnf2CcnRtNlCvdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJJKTeFb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJJKTeFb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F3DDC2BCF6;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785769443;
	bh=I9kKXk45Fx/bC1i8ICXNMpf3fIxhgN36l0pxu7VEFCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WJJKTeFbjhnqwWG/X46/QAS5mQf8EktsbriUyTndFRjzTppL6XxDGzhM8W23qvV7S
	 swL5werVEHf40Nl9g+cyqUNX1vYvomucGx1u9JPxgnLcube3UH6Jkxco61/6qhGr1s
	 pc9EmP/XrHZkaoxdoRvr8stuq0unOV7EU0qbeLweSqTicC5Z9iECHB2OyljZs3XiaP
	 n0yri8Rdq5PtuS0Ki+V7JC9JqYCiaUwLenHmkwzzrVpseNRBY8ywTZw7tG9QQhkLDL
	 LW9NRo4EadBX3kfTDznTsZsyy+292fIj7A0pQuO7EpkX24pxB4CE7TwVGU+uw9EKaL
	 bAdl8442Dwb4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15821C55184;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
From: Pawel Zalewski via B4 Relay <devnull+pzalewski.thegoodpenguin.co.uk@kernel.org>
Date: Mon, 03 Aug 2026 16:03:50 +0100
Subject: [PATCH 1/2] ata: use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-ata-acpi-v1-1-f606afaacad1@thegoodpenguin.co.uk>
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
In-Reply-To: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769441; l=2352;
 i=pzalewski@thegoodpenguin.co.uk; s=20260803; h=from:subject:message-id;
 bh=WMyRqpKRasvtDzYDnFf0+c4OYkQwjZjb+uf6e+s2Npo=;
 b=PbTHyx1WSZfMEhOhxM9hmNcXZFILmH388MaASnrWgAbeuHMoifugHG966KQFhmtyx3di43las
 Owk2gLaALFrC4gvY+NrEhNq/wh1SqD/c8X2pr7LWnikpN0sfOa6oJuP
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=W3zk1cb/wRnj6pNGbl3/2Zf3GmPA6IBpNHpDPyJ05k8=
X-Endpoint-Received: by B4 Relay for
 pzalewski@thegoodpenguin.co.uk/20260803 with auth_id=913
X-Original-From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Reply-To: pzalewski@thegoodpenguin.co.uk

From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>

Use a named initializer for the acpi_device_id fields which
makes the code more readable and consistent with how lists
are initialized in the rest of the kernel code base.

While we are at it - unify the list terminator to have
a single space between the brackets and no trailing
comma.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/ata/ahci_platform.c | 4 ++--
 drivers/ata/ahci_qoriq.c    | 2 +-
 drivers/ata/ahci_xgene.c    | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index c18054333f7c..d97f0ad3b4cd 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -88,9 +88,9 @@ static const struct of_device_id ahci_of_match[] = {
 MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static const struct acpi_device_id ahci_acpi_match[] = {
-	{ "APMC0D33", (unsigned long)&ahci_port_info_nolpm },
+	{ .id = "APMC0D33", .driver_data = (unsigned long)&ahci_port_info_nolpm },
 	{ ACPI_DEVICE_CLASS(PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff) },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 0dec1a17e5b1..96492159fa7c 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -80,7 +80,7 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
 
 static const struct acpi_device_id ahci_qoriq_acpi_match[] = {
-	{"NXP0004", .driver_data = (kernel_ulong_t)AHCI_LX2160A},
+	{ .id = "NXP0004", .driver_data = (kernel_ulong_t)AHCI_LX2160A },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ahci_qoriq_acpi_match);
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 98c99b5a8242..2ebfe86e429b 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -710,9 +710,9 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgene_ahci_acpi_match[] = {
-	{ "APMC0D0D", XGENE_AHCI_V1},
-	{ "APMC0D32", XGENE_AHCI_V2},
-	{},
+	{ .id = "APMC0D0D", .driver_data = XGENE_AHCI_V1 },
+	{ .id = "APMC0D32", .driver_data = XGENE_AHCI_V2 },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, xgene_ahci_acpi_match);
 #endif

-- 
2.54.0


