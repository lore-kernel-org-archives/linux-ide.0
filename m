Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB19298CDC
	for <linux-ide@vger.kernel.org>; Tue,  8 Jul 2025 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960346; cv=none; b=nsYsEvh+0XZa+HGjbEMGRU7z96LejrfsWTtqTWXM5MuDT6WPExtal/YeQr0J09lUWKDfNRgiRBc2lj2QkfmwkP9/wj2eilZ0Pxb2K5janHIVhPOOXtjKWbTHen8DGWGZ/jJHTGSIZhgDUr2pnqHf1Aa3L6FGesZTDqNsKi50pF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960346; c=relaxed/simple;
	bh=ED1LhiXABy7vzdSm75IxCblaQxmcMK6xsXV7Uyqy2qQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNtqpcn7H8egI5Itd8OQmW6d0q325gqRjFsHqXFoyyEO0XLrz+VIe9DPs6yNvT4H57LN/TX1OdJHgBsKC5eYilkOLSPLMY1tOoZ/b44SZ841hCkiBHd+0Hi9XvsBPe3BPXqTcRcHaj/c4lPXTbg71W080uZq96IQJV6dSY2O4aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT/m8WJp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT/m8WJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8478C4CEED;
	Tue,  8 Jul 2025 07:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751960346;
	bh=ED1LhiXABy7vzdSm75IxCblaQxmcMK6xsXV7Uyqy2qQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=VT/m8WJpfDQmg94YWlyBVCEomgOwbwdV6FnwrcwAdSLxHSl4mI2Y16xndtbTtTDGq
	 JM2OxDtLqLB6Yo11m0QuhpAdTbJzOQ4hbrVlvkLXYfWU5WLqZWfCuovxcHUMkRRcie
	 KGscXVzIVEq5VJflZkP28FB7KEVoKRcrA3668cqrgWRA2brkC6wWPU+B+Zd0O+F9by
	 763hrCzxHj/ZVFtdg3L3GXGFP/32LTC6/lc4gAWiO5PUKhlvt6bPpF4xUxOqOmC1Af
	 HDtlCmKqCf2xgExR/mq1XgNUjPEV172An5oZ0gkdsew2nET8uWGUVPrmIUad29RBT6
	 KEkefO3PSL1Lg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-ide@vger.kernel.org,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 3/3] Documentation: driver-api: Update libata error handler information
Date: Tue,  8 Jul 2025 16:36:48 +0900
Message-ID: <20250708073648.45171-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708073648.45171-1-dlemoal@kernel.org>
References: <20250708073648.45171-1-dlemoal@kernel.org>
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

