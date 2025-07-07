Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10A27453
	for <linux-ide@vger.kernel.org>; Mon,  7 Jul 2025 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886104; cv=none; b=kO2LocWOzkOS3MwiwohJuFsTXCL6sK4ctKu1LfjBa4BFZ5QWA6/mOpbiWagh0Ni7ehmyU5Gx3mAWsv2PE92qd61RYSzgReLP/uZBgg6a82I07zm7/vUEYh1ecEo2Hgkabb002DVoS46xLHPDKwDx1K07ISrVDl1NgXZd7Dzs4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886104; c=relaxed/simple;
	bh=ED1LhiXABy7vzdSm75IxCblaQxmcMK6xsXV7Uyqy2qQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nl+cdvRKZ6lmTmdRty1SDcaklj9L43HJHVZRWPr7fAbZ9GR9Yt+5FpFQIVReE2HYVIPLcC4sf0PqiV6vdasbeCkCRtGfF/7pNZ/0UHbTBi06kCl5vKyB+fkb0YEgmD0OTjSNkzO6ZJid33B7skI1puVKhNcOzgGe/424IWitxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+z+W/ju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+z+W/ju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501C6C4CEE3;
	Mon,  7 Jul 2025 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886103;
	bh=ED1LhiXABy7vzdSm75IxCblaQxmcMK6xsXV7Uyqy2qQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=p+z+W/ju6lqSBNFTUyz0ymgnzxxV9aS3K6fLBBW5ifj91WXEr8tlmcnZhGiLwy3r0
	 BXJygTpIsF7cIjhq/V/hfy+LHT58u3M5G0q4omenMharO0yEV3sHRXfzLrMZGdnTF3
	 6V9WGCE0YdPe+o0L3rPTJfJE7mUKu3+Q6BRl6EkbRpGNDVljofgDejPlj4N4ReJ0HJ
	 xUNVJEMcImFOIjtHS56i95TgF6UpI4+Oit7s9NFJF5TdLp1GpAlTH7XIKNwPNUu/km
	 RGLtkbhXAqR9KDenRxJDL3hB+EoQkbOTY42HyW9LXEzcm3ZecfoNYJC9Q59qUI+HPS
	 AjqEjzfWuhTgA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 3/3] Documentation: driver-api: Update libata error handler information
Date: Mon,  7 Jul 2025 19:59:31 +0900
Message-ID: <20250707105931.548315-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707105931.548315-1-dlemoal@kernel.org>
References: <20250707105931.548315-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ``->error_handler()`` section of the libata documentation file
Documentation/driver-api/libata.rst to remove the reference to the
function ata_do_eh() as that function was removed. The reference to the
function ata_bmdma_drive_eh() is also removed as that function does not
exist at all. And while at it, cleanup the description of the various
port reset operations using a bullet list.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 Documentation/driver-api/libata.rst | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/libata.rst b/Documentation/driver-api/libata.rst
index 5da27a749246..e160ef2e0791 100644
--- a/Documentation/driver-api/libata.rst
+++ b/Documentation/driver-api/libata.rst
@@ -283,18 +283,21 @@ interrupts, start DMA engine, etc.
 
 ``->error_handler()`` is a driver's hook into probe, hotplug, and recovery
 and other exceptional conditions. The primary responsibility of an
-implementation is to call :c:func:`ata_do_eh` or :c:func:`ata_bmdma_drive_eh`
-with a set of EH hooks as arguments:
+implementation is to call :c:func:`ata_std_error_handler`.
 
-'prereset' hook (may be NULL) is called during an EH reset, before any
-other actions are taken.
+:c:func:`ata_std_error_handler` will call the various port reset operations as
+needed.
 
-'postreset' hook (may be NULL) is called after the EH reset is
-performed. Based on existing conditions, severity of the problem, and
-hardware capabilities,
+* The 'prereset' operation (may be NULL) is called during an EH reset, before
+  any other action is taken.
 
-Either 'softreset' (may be NULL) or 'hardreset' (may be NULL) will be
-called to perform the low-level EH reset.
+* The 'postreset' hook (may be NULL) is called after the EH reset is performed.
+  Based on existing conditions, severity of the problem, and hardware
+  capabilities,
+
+* Either the 'softreset' operation (may be NULL) or the 'hardreset' operation
+  (may be NULL) will be called to perform the low-level EH reset. If both
+  operations are defined, 'hardreset' is preferred and used.
 
 ::
 
-- 
2.50.0

