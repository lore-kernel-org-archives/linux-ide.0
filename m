Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AE2931FA;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769443; cv=none; b=Q2sN2btSwU3S0UtwJM/WueYLj53lbPbBoQbj2CLhaeA3sdQnIuOgVLJkrBIkIFl/2rDyWISjifBNuIGS7CiXuhPDCTjqeQRKYdgNuDb0Fnbwd38+hIblA1ZxrONo302SI2vDRi+KscDg8OaCsJyoQsYjuAr5kSwyvOQ4W0ZKQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769443; c=relaxed/simple;
	bh=iq+SM7rJUXSs4k5NukSDtbdt4eahBkIns2wi7WY9PjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alBPFIWbJsXw6/uXSxHGGaX6CsmI63c0+UsJC/yCm119jdK1rLQQYjIHWBRAltG0gvT/Lpc0P+7G/mLs+79KGrH/KnIlL2z/NiivUvhbsMTBHRjjLGQyExbYvIRP7tf/NEbatxw55nywDNrkvNTrCfRp8wHi8UL4oxsKQNVzKJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHO4BAUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHO4BAUg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F1D7C2BCFD;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785769443;
	bh=iq+SM7rJUXSs4k5NukSDtbdt4eahBkIns2wi7WY9PjU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eHO4BAUgmSZLypj8CKJSG8yVvAXU4o6kbphvlGhwvKLVz9YMddoE+Rg1aeDG7NI9c
	 XJEWoncTmif0rDRs79xoTMiIJr+Sjrq6Q8s26JFiAVCcpYmoVhPzoBTXvOb98XS6yc
	 oD5vXTMv62TWgzXPUIR08v9d10Pi5JlsgkIHxaKoDWK8FU9BMiymO1V1XhsQ87OZSs
	 bi4IcdvH3tGyI1Mt0305V9vVsoeVSvHDzj0v9OlnbmwtJY5/MLevBmxwGKsI279J6K
	 wsob9NDhM6DmOqxOOP6AjgtdqEMEpZkf0+64Ja3KLJwSh2XOwREPM7GRCUYKIDOl1r
	 FsOujT45jlM0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27019C5518F;
	Mon,  3 Aug 2026 15:04:03 +0000 (UTC)
From: Pawel Zalewski via B4 Relay <devnull+pzalewski.thegoodpenguin.co.uk@kernel.org>
Date: Mon, 03 Aug 2026 16:03:51 +0100
Subject: [PATCH 2/2] ata: ahci_seattle: drop unused
 acpi_device_id::driver_data
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-ata-acpi-v1-2-f606afaacad1@thegoodpenguin.co.uk>
References: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
In-Reply-To: <20260803-ata-acpi-v1-0-f606afaacad1@thegoodpenguin.co.uk>
To: Hans de Goede <hansg@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769441; l=991;
 i=pzalewski@thegoodpenguin.co.uk; s=20260803; h=from:subject:message-id;
 bh=NTXTlwoJq1lj+SCnk1cP3pBirwDRzp26Eqhz/VVpz7g=;
 b=hHVIY0FHG/LCgvw64RMEFNmMBpCnkPqpMqMd6efOPU7QrZ1NAtnXzGy3uFJjdGguQ9l7vQCEH
 fPUT++WnuooByct+CmewiYse55NReJ8kyyscIC9owlzfOrgnPhB8n0z
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=W3zk1cb/wRnj6pNGbl3/2Zf3GmPA6IBpNHpDPyJ05k8=
X-Endpoint-Received: by B4 Relay for
 pzalewski@thegoodpenguin.co.uk/20260803 with auth_id=913
X-Original-From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Reply-To: pzalewski@thegoodpenguin.co.uk

From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>

This module sets the acpi_device_id::driver_data to 0 but
the id is not actually used within the module, we can
just drop it from the list.

While we are at it - used a named initializer for the
acpi_device_id::id field to increase readability and
modify the list terminator to have a single space in
between the brackets.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/ata/ahci_seattle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 3f16c1678402..9758fa0260ac 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -178,8 +178,8 @@ static SIMPLE_DEV_PM_OPS(ahci_pm_ops, ahci_platform_suspend,
 			 ahci_platform_resume);
 
 static const struct acpi_device_id ahci_acpi_match[] = {
-	{ "AMDI0600", 0 },
-	{}
+	{ .id = "AMDI0600" },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 

-- 
2.54.0


