Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFFE1B947
	for <linux-ide@vger.kernel.org>; Tue,  6 Feb 2024 21:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254068; cv=none; b=CZMBkGyf+NYvdbEYFFETpIyHWN80I2N6KEOsupT1E50t5sx4gNBO0hlLWfzN/LZMz3IFTSdZzlVxol/eQv/TGZ7ur8MCywzqRZkIzT3gSkUpP5FoTaRTcIan+7PURlXUdxT/HFOT5+F2RRVTunZTClrEAUtJeQ1x9rzLRvP3gMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254068; c=relaxed/simple;
	bh=MJbUy/b/djxswCYIGOdYtzscULgpwapoy5GI8z/Bm4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQH0MXhHw9hIpGHYzfn0BpOS6UtgrhlzNuEX6H8eQF8mg14U6ejA21V+8S0SY/N+3q2dsDvQY30r/FsauWaudFaPI2BH99o/bGCuDVn0jlboVochJBdkJ38Ek4xXgww/LS7/qfzUI3LqpR0yBWkOitjfQ/3zBrJtwXCkYOsQhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2eE9DmX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2eE9DmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C268C433C7;
	Tue,  6 Feb 2024 21:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707254068;
	bh=MJbUy/b/djxswCYIGOdYtzscULgpwapoy5GI8z/Bm4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2eE9DmXwYWLBWsgcmmbiq3L6qevVvmVVC7k1eUN9sVpaKADHn/o+Z19blLg0KNgA
	 u3OxujCtN1V41XMu6ODskm6XXq0UNpWaeDRjl0HvdPyYE6dTwqlHC640DjtKPxa7L9
	 RkQTYsETp28fiCnSQ9DAcdrn72/YY1dW20WFz0KIJCOLiwXLE5AaqYrO+urZT7qpOD
	 CJ12M0TEONeaESRn8aR4nYlV/GUWf/w/ZOJqorIJkGjDL2jsslmFs97lym310ga9iM
	 /yg0Aq0x1a5Jpj4SRDJpYTtLfHVJhr0r0uI8pfrtvPchdCli5Iy/rORISsv16J4lhV
	 ITNWKTBox0RhA==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH v2 3/5] ata: ahci: drop hpriv param from ahci_update_initial_lpm_policy()
Date: Tue,  6 Feb 2024 22:13:44 +0100
Message-ID: <20240206211352.1664816-4-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206211352.1664816-1-cassel@kernel.org>
References: <20240206211352.1664816-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need for ahci_update_initial_lpm_policy() to take hpriv as a
parameter, it can easily be derived from the ata_port.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 4d3ec6d15ad1..346a0f9ef246 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1655,9 +1655,9 @@ static void ahci_mark_external_port(struct ata_port *ap)
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
-static void ahci_update_initial_lpm_policy(struct ata_port *ap,
-					   struct ahci_host_priv *hpriv)
+static void ahci_update_initial_lpm_policy(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
 
 
@@ -1949,7 +1949,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 		ahci_mark_external_port(ap);
 
-		ahci_update_initial_lpm_policy(ap, hpriv);
+		ahci_update_initial_lpm_policy(ap);
 
 		/* disabled/not-implemented port */
 		if (!(hpriv->port_map & (1 << i)))
-- 
2.43.0

