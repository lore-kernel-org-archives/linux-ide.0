Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B9626D7
	for <linux-ide@vger.kernel.org>; Thu,  1 Feb 2024 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804122; cv=none; b=HnZHfTAHBJ1muC7AlFrIgtVZTwZY3fiKTywsVWIStBguRC3UV8WGkfDqooYf9canj/DTzjf7BZVoVY0IvnUczfnF52hIC/ot08M08WkcBBCkk10DFR/3YAx38pRk22L/puJLnYjMI+db0AvNtu71fskaEZEOkBPcqb8hiwOpodQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804122; c=relaxed/simple;
	bh=7u5txi2BZgTrKl0BJ+paP2Z3dV8tSPFgtBmXOtG4NBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAjl+R8OVNk4ovpHihzvCVxB/RL0zmKsNL3lHFErjJH9n1ZmiOr/V+SAmQl9Qd9XJtKzSZTXHOKij+nmeSzvmtOnCPEPxGI4v9/7iomkaGjMub+NlKIOgUplQw9TSymrLf6eZso9byehyFwYDOWXElwqfe7ifKRnbh6XO5Wg+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOOkw/UJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOOkw/UJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75753C433C7;
	Thu,  1 Feb 2024 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706804121;
	bh=7u5txi2BZgTrKl0BJ+paP2Z3dV8tSPFgtBmXOtG4NBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOOkw/UJ6xOd4rzA+OsdR9f/iuYSQolGDE/9EDgSzWXyQvNL+zFjh94P2N1uIozAV
	 aCyXe92rbWy2m/38+/t48+UjFN802OELi4XT7oBBk+8gD97q7bebDaUgeXHC6R8mMQ
	 6N/cSPOk66+kel0iBAEUVya6BWXFuUO+I7KE4QAVA3hYLvV4oBGs9OVFoirGY6VhMj
	 3thDdSy2Yi7HguDTVl1tAk7iIJt/YfRMvfXBfAptZonaeds6T0EMa+HzszKaqPVuAu
	 gQZv7ILQskz9ExBpj7/KTI/VpqK8eQn5tnUooFapdPbWKjUTgPcLlP3gfWs4fiwoAk
	 cvT3+nEK6bSTg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Werner Fischer <devlists@wefi.net>,
	Daniel Drake <drake@endlessos.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Dieter Mummenschanz <dmummenschanz@web.de>,
	linux-ide@vger.kernel.org
Subject: [PATCH 2/5] ata: ahci: a hotplug capable port is an external port
Date: Thu,  1 Feb 2024 17:14:59 +0100
Message-ID: <20240201161507.1147521-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201161507.1147521-1-cassel@kernel.org>
References: <20240201161507.1147521-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hotplug capable port is an external port, so mark it as such.

We even say this ourselves in libata-scsi.c:
/* set scsi removable (RMB) bit per ata bit, or if the
 * AHCI port says it's external (Hotplug-capable, eSATA).
 */

This also matches the terminology used in AHCI 1.3.1
(the keyword to search for is "externally accessible").

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 157ab88bdf75..8c8403bae36f 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1649,7 +1649,8 @@ static void ahci_mark_external_port(struct ata_port *ap)
 	u32 tmp;
 
 	tmp = readl(port_mmio + PORT_CMD);
-	if ((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS))
+	if (((tmp & PORT_CMD_ESP) && (hpriv->cap & HOST_CAP_SXS)) ||
+	    (tmp & PORT_CMD_HPCP))
 		ap->pflags |= ATA_PFLAG_EXTERNAL;
 }
 
@@ -1945,7 +1946,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
-		/* mark esata ports */
+		/* mark external ports (hotplug-capable, eSATA) */
 		ahci_mark_external_port(ap);
 
 		ahci_update_initial_lpm_policy(ap, hpriv);
-- 
2.43.0

