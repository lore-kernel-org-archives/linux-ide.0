Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06815695
	for <linux-ide@vger.kernel.org>; Wed, 24 Jul 2024 05:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799942; cv=none; b=sFgTz7fPBec4dd+RVq7nOJmEoVRgZh0MjzLbF29rMghQmbFP3LX6kOVd6XLv3gNsvBL25MrPgUh+AZ05VDpxzS6ktgBw7pDWpC2zUH0OukoVjctmHz/sPgt2xrYKqWThSbBjMVuH/nxR0tOt6G4YGyn77vmZo1/UtF3HnTLm1CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799942; c=relaxed/simple;
	bh=qAo6DmgOz6INe7lueGb9cEF9x97gqqXvYI5WgiwmC84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UmRDKP9JjBTXC3Fi3vqkAjtklepS39cbkfxeKAp4gRo1ECKYPoq6+tM3gMxs5aqjvBLgXO0RQS96TFutqyUq4ILv/0aIoUNoQPqSQ1xTTB3ZSJP55Lph3GwzN2R5KVx8VM4WZK5KQQK8lv9kZRJJoPM/Bu5dFlTYAu9T3y7huok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUnbTbqi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUnbTbqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1205BC32782;
	Wed, 24 Jul 2024 05:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721799942;
	bh=qAo6DmgOz6INe7lueGb9cEF9x97gqqXvYI5WgiwmC84=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nUnbTbqioaFcLpyK9mZE5ggEpxRn2Q3T5W75T9B3qAwdoqhuw3ezk63glErHiWS7F
	 /4E8MZYzGIrhlsE3JzeTAJsMaiXl6keI7EVKSj4WIPPcwHsK7/pyBry+4ZFklYE4Hl
	 h8AzkZfm+De6xvRhEpZaoj+0K0i0dC3Ja5W43MpIxTIbydCbuq1J3K3EQNIVZLIGS/
	 nmHhpb3t+hC9DJuCL2H090xrub59WaNyzYKQpq70J+og2rhojyd/RJNFInyCqUIWmB
	 5dSaiXxhCgtM8hjVyGlJM4BlLIgWRMT8ICtzxNkkE0p1jLNSzbLgVlwSS0wZpKXez4
	 XkDyLjaH0qyHA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 2/4] ata: libata: Rename ata_dev_blacklisted()
Date: Wed, 24 Jul 2024 14:45:37 +0900
Message-ID: <20240724054539.182655-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724054539.182655-1-dlemoal@kernel.org>
References: <20240724054539.182655-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the function ata_dev_blacklisted() to ata_dev_horkage() as this
new name:
1) Does not use an expression that can be considered as negatively loaded.
2) The name does not reflect what the function actually does, which is
   returning a set of horkage flag for the device, of which only one
   flag will completely disable the device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a35bce4236d3..272770f09609 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -84,7 +84,7 @@ static unsigned int ata_dev_init_params(struct ata_device *dev,
 					u16 heads, u16 sectors);
 static unsigned int ata_dev_set_xfermode(struct ata_device *dev);
 static void ata_dev_xfermask(struct ata_device *dev);
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev);
+static unsigned long ata_dev_horkage(const struct ata_device *dev);
 
 static DEFINE_IDA(ata_ida);
 
@@ -2223,7 +2223,7 @@ static inline u8 ata_dev_knobble(struct ata_device *dev)
 {
 	struct ata_port *ap = dev->link->ap;
 
-	if (ata_dev_blacklisted(dev) & ATA_HORKAGE_BRIDGE_OK)
+	if (ata_dev_horkage(dev) & ATA_HORKAGE_BRIDGE_OK)
 		return 0;
 
 	return ((ap->cbl == ATA_CBL_SATA) && (!ata_id_is_sata(dev->id)));
@@ -2830,7 +2830,7 @@ int ata_dev_configure(struct ata_device *dev)
 	}
 
 	/* set horkage */
-	dev->horkage |= ata_dev_blacklisted(dev);
+	dev->horkage |= ata_dev_horkage(dev);
 	ata_force_horkage(dev);
 
 	if (dev->horkage & ATA_HORKAGE_DISABLE) {
@@ -3987,13 +3987,13 @@ int ata_dev_revalidate(struct ata_device *dev, unsigned int new_class,
 	return rc;
 }
 
-struct ata_blacklist_entry {
+struct ata_dev_horkage_entry {
 	const char *model_num;
 	const char *model_rev;
 	unsigned long horkage;
 };
 
-static const struct ata_blacklist_entry ata_device_blacklist [] = {
+static const struct ata_dev_horkage_entry ata_dev_horkages[] = {
 	/* Devices with DMA related problems under Linux */
 	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
 	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
@@ -4111,7 +4111,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* Devices which get the IVB wrong */
 	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB },
-	/* Maybe we should just blacklist TSSTcorp... */
+	/* Maybe we should just add all TSSTcorp devices... */
 	{ "TSSTcorp CDDVDW SH-S202[HJN]", "SB0[01]",  ATA_HORKAGE_IVB },
 
 	/* Devices that do not need bridging limits applied */
@@ -4266,11 +4266,11 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 	{ }
 };
 
-static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
+static unsigned long ata_dev_horkage(const struct ata_device *dev)
 {
 	unsigned char model_num[ATA_ID_PROD_LEN + 1];
 	unsigned char model_rev[ATA_ID_FW_REV_LEN + 1];
-	const struct ata_blacklist_entry *ad = ata_device_blacklist;
+	const struct ata_dev_horkage_entry *ad = ata_dev_horkages;
 
 	ata_id_c_string(dev->id, model_num, ATA_ID_PROD, sizeof(model_num));
 	ata_id_c_string(dev->id, model_rev, ATA_ID_FW_REV, sizeof(model_rev));
@@ -4372,8 +4372,7 @@ static int cable_is_40wire(struct ata_port *ap)
  *
  *	Compute supported xfermask of @dev and store it in
  *	dev->*_mask.  This function is responsible for applying all
- *	known limits including host controller limits, device
- *	blacklist, etc...
+ *	known limits including host controller limits, device horkages, etc...
  *
  *	LOCKING:
  *	None.
-- 
2.45.2

