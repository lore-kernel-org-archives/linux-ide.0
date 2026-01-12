Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682C433B3
	for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220463; cv=none; b=E8a9CN0RWzEomtsl8j2eIraCPwQQiLhVj0O3tO+vg9FaVg9aBJq7aUtjf3DPG5wEU3Zoz37Ta6UHZMu90hu8jZfZMJSrOdIFlKieruVDgAB7/+1XHRVFplFwz0r0ERp/W2isnG/NOrhqCsiqS3ODvDksodjAeV5DK+2Hx2GeNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220463; c=relaxed/simple;
	bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SptqZFOKvnTjkcTeFF6+b45uMaJuNuhXOixYttx+Uu4X1kxGQtmwsT/3m0WI4fXNuSsr72BJ3VSe4Bv5lW84wSWGvBIlozTQx7c1zXThsVYY3ZCC361WtRDhDJeb1UM24cx3q8K7QOt3CgrHvL2NV+ppUSs7PhDbP5JpV0TOYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nctt2BFg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nctt2BFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2219C16AAE;
	Mon, 12 Jan 2026 12:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768220462;
	bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nctt2BFge006I/VweyHVhZMxXzbxACKieYf9BIpKCJMtkrw5ScoxmU3DXIen1w2ui
	 L1p0nUFqC03S/ZqmZqgtbQZhQFzd/yfKeiGB860A37T/uTV1j1jX+iZahwRwqkpr9a
	 NkcYMP9VM/Aoisg9kotWSeOKcjFiC9OGyc6AAhoXxlGgEhAg8ypomRbekmCny3+BdT
	 Eopmb9x3gbO30nUk3B0TX4RMw2cwWuMCI3b6PgynOM4hyF+axwjxfLeuOtKX5t38H8
	 +OsWYc2vUo0v8fv+MyZfnqeQLfpnsu8bABdhZnQyL06NYi5BM5MZEYfwGDvfV+6vC0
	 /jkkSPfrGYCuA==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org
Cc: linux-ide@vger.kernel.org,
	wolf@yoxt.cc,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/6] ata: libata-sata: Improve link_power_management_supported sysfs attribute
Date: Mon, 12 Jan 2026 13:20:48 +0100
Message-ID: <20260112122044.143637-11-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112122044.143637-8-cassel@kernel.org>
References: <20260112122044.143637-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1644; i=cassel@kernel.org; h=from:subject; bh=SW1S0wQDf7mPg3VxzJ1YDckoyI7DNHRoVegcNv7P0jk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJTniuWPo7X3bCzrXyZBOfVlBbfQ/o9kx8n839gz2I++ P5Vgv3WjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEzkGz8jw7yOK0wx4TLzOoXu 3X4VMrtt1aOk4gULSlvXS220DnpaupeR4db7rVdOvZ7y0EHm1L2barNz898zB12O06tPFT7/oVP /OQcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The link_power_management_supported sysfs attribute is currently set as
true even for ata ports that lack a .set_lpm() callback, e.g. dummy ports.

This is a bit silly, because while writing to the
link_power_management_policy sysfs attribute will make ata_scsi_lpm_store()
update ap->target_lpm_policy (thus sysfs will reflect the new value) and
call ata_port_schedule_eh() for the port, it is essentially a no-op.

This is because for a port without a .set_lpm() callback, once EH gets to
run, the ata_eh_link_set_lpm() will simply return, since the port does not
provide a .set_lpm() callback.

Thus, make sure that the link_power_management_supported sysfs attribute
is set to false for ports that lack a .set_lpm() callback. This way the
link_power_management_policy sysfs attribute will no longer be writable,
so we will no longer be misleading users to think that their sysfs write
actually does something.

Fixes: 0060beec0bfa ("ata: libata-sata: Add link_power_management_supported sysfs attribute")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-sata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index b2817a2995d6..04e1e774645e 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -909,7 +909,7 @@ static bool ata_scsi_lpm_supported(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	if (ap->flags & ATA_FLAG_NO_LPM)
+	if ((ap->flags & ATA_FLAG_NO_LPM) || !ap->ops->set_lpm)
 		return false;
 
 	ata_for_each_link(link, ap, EDGE) {
-- 
2.52.0

