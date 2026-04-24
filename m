Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457A3246FE;
	Fri, 24 Apr 2026 10:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777027117; cv=none; b=Pp9SYj7TTkH9L2g/o+2Qw0J1N84b4w0WZjBwWpo03GeuNnnbe+Russ9f2jppDx+341FxpTeiHCs76egtDc6LWrcCFKl1AbHDw7hPZkcd3Idd4Y8IXWc6sgy2YJiz0VUR13yIb16nYfdlrKzWGmkBWY8sVOn3OPPNDxLKUngzO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777027117; c=relaxed/simple;
	bh=GH07ZywBc/puIudYXCSDjjs+0laQLGuUD7SZCd8Xd5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGCaEksENNhMcQraaeEjr4vs+Xffxe/1GTPOlABGF7fqz6gbiRdEo5iH6azSrxaShMvwMMx38qAdMvAIcx3VgWn8xojwugBZ6S9b+edV1gE6NSHXpJoya6+y5LK9NewguhDM4BAp/JZ1PjA4c1hvDhNCZCUQLcJuGP0Q2xOEJJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jak0U6Ny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jak0U6Ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B42C19425;
	Fri, 24 Apr 2026 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777027117;
	bh=GH07ZywBc/puIudYXCSDjjs+0laQLGuUD7SZCd8Xd5g=;
	h=From:To:Cc:Subject:Date:From;
	b=jak0U6Ny6Uo02DGaMVQlE4MhTK7T65hvi2mWUb3/kQtF+F4KwQe/mL5cTobd13YY6
	 9qIF+Vi+u8/MFrWQFbKSGppg1/WXhJhYAafg+7JKzaE3OieCACsGRxn8Y6oyvOFNBk
	 8s94cEivdh00xgH0sc/lRmfI01BcfxGzP0Q5ubTspsaAb8l30/+kWCifJx1hZBcKE4
	 VnXZlQ86CywD+3asrjQLMAeKoSHQVZSu+x/7cRuZGo43IGMaDGJxrS09V1L68PR28H
	 tR29Nnb6sE+en9udoR/9z5xx8Pwsae3auTeKD7aOsF5L2V1Zxkhf/WVVGBU8L8TbuA
	 RztcZS448xPag==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wGDvf-0000000Ayl5-1DjU;
	Fri, 24 Apr 2026 12:38:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH] ata: pata_parport: switch to dynamic root device
Date: Fri, 24 Apr 2026 12:38:30 +0200
Message-ID: <20260424103830.2616828-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver core expects devices to be dynamically allocated and will, for
example, complain loudly when no release function has been provided.

Use root_device_register() to allocate and register the root device
instead of open coding using a static device.

Note that this also fixes a reference leak in the unlikely event that
device_register() ever fails.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/ata/pata_parport/pata_parport.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index a5b959891cb7..40baeac594a9 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -459,19 +459,11 @@ static void pata_parport_dev_release(struct device *dev)
 	kfree(pi);
 }
 
-static void pata_parport_bus_release(struct device *dev)
-{
-	/* nothing to do here but required to avoid warning on device removal */
-}
-
 static const struct bus_type pata_parport_bus_type = {
 	.name = DRV_NAME,
 };
 
-static struct device pata_parport_bus = {
-	.init_name = DRV_NAME,
-	.release = pata_parport_bus_release,
-};
+static struct device *pata_parport_bus;
 
 static const struct scsi_host_template pata_parport_sht = {
 	PATA_PARPORT_SHT("pata_parport")
@@ -518,7 +510,7 @@ static struct pi_adapter *pi_init_one(struct parport *parport,
 	}
 
 	/* set up pi->dev before pi_probe_unit() so it can use dev_printk() */
-	pi->dev.parent = &pata_parport_bus;
+	pi->dev.parent = pata_parport_bus;
 	pi->dev.bus = &pata_parport_bus_type;
 	pi->dev.driver = &pr->driver;
 	pi->dev.release = pata_parport_dev_release;
@@ -780,8 +772,9 @@ static __init int pata_parport_init(void)
 		return error;
 	}
 
-	error = device_register(&pata_parport_bus);
-	if (error) {
+	pata_parport_bus = root_device_register(DRV_NAME);
+	if (IS_ERR(pata_parport_bus)) {
+		error = PTR_ERR(pata_parport_bus);
 		pr_err("failed to register pata_parport bus, error: %d\n", error);
 		goto out_unregister_bus;
 	}
@@ -811,7 +804,7 @@ static __init int pata_parport_init(void)
 out_remove_new:
 	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
 out_unregister_dev:
-	device_unregister(&pata_parport_bus);
+	root_device_unregister(pata_parport_bus);
 out_unregister_bus:
 	bus_unregister(&pata_parport_bus_type);
 	return error;
@@ -822,7 +815,7 @@ static __exit void pata_parport_exit(void)
 	parport_unregister_driver(&pata_parport_driver);
 	bus_remove_file(&pata_parport_bus_type, &bus_attr_new_device);
 	bus_remove_file(&pata_parport_bus_type, &bus_attr_delete_device);
-	device_unregister(&pata_parport_bus);
+	root_device_unregister(pata_parport_bus);
 	bus_unregister(&pata_parport_bus_type);
 }
 
-- 
2.53.0

