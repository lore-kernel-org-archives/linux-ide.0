Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282465;
	b=TYPmlz3OLd0bAMdAfAenG6lOWdtNzCgryh84ECmQRepDa0u8KS/4Et/gVA2QJLbuilw1
	 BW/XIulBXl64GbQbtowNj03pjeq9RVHtl/J06A79EZjvk0JXrCy8K9uflHTtXiUsPdRHj
	 IcNrQRFz4GOE0nuZzgrxUksltsNlghgzNZ5OT1aq15t7qoYDXDMPH2nj3B/ksU2TLy/j6
	 JlELwTJNzpSOo3FE0jA1pnHGCtL2LHB1Op2cKxAQQeqZe321Aay/UkAPt9dixSQCcP/gt
	 8lyJm6qOsbRmTsoUSFasKMy89D8a3NAirJ/1B17oVGFgthbBP9qNob9UZfZyLCar+xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282465;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=1NW8f2FaSFykGnch/E9fgBTLK2+pxRc9w1tLk9Rm0p8=;
	b=L41dXYrk/u+qrFE8FLFf9YLkGcn/c2tDSffclzsBIqkw5wbtndXgibbCHc6F5FptQDN7
	 I4V8f8IYN8cf7K52D9VtRG76AXku6mfUlljC4t0l6Ab5ChmB1OQKZv19GlkVW3DTaIX2r
	 TyYk966nJwMkGPZ21IJVGPW/MyfbAQCDhUSNMTD4BCW1+uRmthieWMzFA5NrnLpad45lL
	 7mVd9lfhggKrjEDDy3BsZv1hJz0+pzyd2owwL7htN7C5qdR9DpVlBI507YCi3m5u2wYM+
	 il9dguGZOe80nx0FZn2Xc2DV7ZzwDZRZCINIeU9rN70RfYKPLJR78gwwYtorZBKxkxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ac45ANIN;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB666606A32F;
	Thu, 29 Oct 2026 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB666606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ac45ANIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793282465; x=1824818465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/JK4egaMQ6o9Sf/I5NjAvigrmy36ltelcrOmAGCM6cg=;
  b=Ac45ANINYUgTG9fMIikgQ0Wy6Sc6tPeUplmrpm9oQw9JGCHJi1Vvyqgd
   42pdZ4fFqFQwHMelM7PlHm3+Z8nXJZ+c1+1YMCpTu29aJ5KgYL5FY71si
   eej7HXNFAa17AeabQ3hr2Wwi96MbXgphRBhIhV4wmOOWl8F78NYeWm1hT
   wRsNqWLK8S1DJsR0zCNh7b5zRz2sgAlBt95Nbf1W83PZYKBqzkN+HpKaw
   zp7Ow7c9FX4CeyllLWPXUn7ZSpCq/QXQl9GcqJAzmPOu78J9DRkW2KBOP
   FEniwIGQJgKnrGlX/OLJ+UmKLZF/dC293cUlIfygIMSUYTfsTpp9Ryas+
   w==;
X-CSE-ConnectionGUID: PCURvS/gTc22VHt9uLnjWg==
X-CSE-MsgGUID: DzJGl45NRJCToU5ZiYjtwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1907774"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1907774"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:01:04 -0700
X-CSE-ConnectionGUID: M2tkaBdlTPeKtpn5j+Hmvg==
X-CSE-MsgGUID: cotb+veYQjmTZ9uV40QkYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5279292"
Received: from user-columbia-beach-bmc.igk.intel.com ([10.102.116.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 07:01:02 -0700
From: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	szczepan.durawa@intel.com,
	szymon.durawa@linux.intel.com,
	romanx.gardzinski@linux.intel.com
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ATA: ahci: Add Intel PCH-S RAID device ID
Date: Thu, 29 Oct 2026 15:00:03 +0100
Message-ID: <20261029140004.6991-1-romanx.gardzinski@linux.intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Intel Nova Lake SATA controller is configured in RAID mode (rather
than AHCI), the generic entry in ahci_pci_tbl which matches any device with
the PCI class code for AHCI, is not sufficient, since the SATA controller
in RAID mode uses a different PCI class code.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>

Suggested-by: Szczepan Durawa <szczepan.durawa@intel.com>
Reviewed-by: Szymon Durawa <szymon.durawa@linux.intel.com>
Signed-off-by: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
---
v1 -> v2:
 - update RAID entry in ahci_pci_tbl to board_ahci from board_ahci_pcs_quirk
 - update commit description

 drivers/ata/ahci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001c..cee67c64fbea 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -280,6 +280,10 @@ static const struct ata_port_info ahci_port_info[] = {
 static const struct pci_device_id ahci_pci_tbl[] = {
 	/* Intel */
 	{
+		/* Nova Lake PCH-S RAID */
+		PCI_VDEVICE(INTEL, 0x6e66),
+		.driver_data = board_ahci,
+	}, {
 		/* Comet Lake PCH-H RAID */
 		PCI_VDEVICE(INTEL, 0x06d6),
 		.driver_data = board_ahci_pcs_quirk,
-- 
2.53.0

