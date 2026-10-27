Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110420;
	b=r41W3mJTqsEEacphWzsco1pG0mYnNkLPiyPYhyZz+nEy6O5m6417AmNtHh2LMj/96qZV
	 YCxpjtD7MtTlw4QzRusdlZOcW84ecQXRHgpnI6jSyOcM1FR94df7QfnqK+ULYyYyJXDq9
	 pEY4svAAGjpf+nz6UhOf+MmyFbx0P1mhxmJ7/yCcaTUpyw7OY3XiO5Krs0ngIC6zARifC
	 s8ZPtZZS3zhjN8AZB58mqxw25XUudzaXCUaFYSGRyjcInXJlLVNbHAncUnefM5XPNprko
	 +sBBGRoC6DUDQ5xVdrD5JbRNlexkmFxn/ZVDFyz1HnmD1sZbwdx5pgmk4Lq3z1Xu2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110420;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Njyr1sXC6BTc6KpjDCCPrThZrn5w31hYsQpyOkaUFX8=;
	b=lyhK2sM83ojBIQHO35rdQRN8+frTAqr1fwX6+TdRm5Y4uCuwb+HiC7Prnp6lvL7IApgy
	 Ssm91W5MGjcMga28kGCY2OgLJusg89HIteEZBFEdSQkx9HB5zvZQTZFcnKkb00p90mSe+
	 pFUtgiOKTxhuIIOpi+C6+yTn0WyWOqsoTQQNaG8638Ay92bjKiL+x+dKYv8tH7F3CQOVx
	 gnVgdVop0A3DgrEtok3mep+KhpseIsgjDW3Qi9EwtAUNphCAPGK1iKdwvhvLHu5WQCqmW
	 ZfM4jUNIQ02PAj6IJfIn6PyU1pUsQCCKBw6UvwJ2fH3xxHGH7cugTtSYlRLfwIg+Q2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sxly0D54;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744E5606A335;
	Tue, 27 Oct 2026 14:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744E5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Sxly0D54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793110420; x=1824646420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZY4wfgpH0hUWAMDpOH4bafZli/xxULyQBlE1t566/+0=;
  b=Sxly0D54AqHL6syY2zMWwiaeEETWqTC77UQW/Pruz8+uKlHAqmvYuxPF
   JvFBk4SFLsBvX79AmWyi3b9914u5kmdyGB7Q/NSwlarahiJgUhQ96RH4c
   Eu1TbiD1wyCmkt0neT9uC/3PMVcpmYRHvysgkLCp+AbfD9amcR/w71bD/
   lK5vlaU47ANqP17/VVcR0lJYvtA+Q0Nm3s6IjPYQ5uQb9SacAik2BcC0A
   mvzJznjY8LEknb8dGRTuwAgyJHpnQRs2prn03OQkBd8WWLosSn3dEO7GG
   ljMZ5mpNoZFBjYcfUaVEXHIIuXk2lB9/TcmNI8ogO1tZyKpWKFT/whSrT
   g==;
X-CSE-ConnectionGUID: 3Ib54G10QLysynAt3YsNGQ==
X-CSE-MsgGUID: EcmEr4YnTMOhzCP0OIlZAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1705463"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1705463"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:13:34 -0700
X-CSE-ConnectionGUID: btlMCU9iQlmskLJy1x/KXg==
X-CSE-MsgGUID: a766eGApTgC3xKlX8Ik3OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4577942"
Received: from user-columbia-beach-bmc.igk.intel.com ([10.102.116.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:13:25 -0700
From: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
To: dlemoal@kernel.org,
	cassel@kernel.org,
	szczepan.durawa@intel.com,
	szymon.durawa@linux.intel.com,
	romanx.gardzinski@linux.intel.com
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ATA: ahci: Add Intel PCH-S RAID device ID
Date: Tue, 27 Oct 2026 15:12:40 +0100
Message-ID: <20261027141240.7850-1-romanx.gardzinski@linux.intel.com>
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

Add support for SATA devices in RAID mode for Nova Lake.
No functional changes.

Suggested-by: Szczepan Durawa <szczepan.durawa@intel.com>
Reviewed-by: Szymon Durawa <szymon.durawa@linux.intel.com>
Signed-off-by: Roman Gardzinski <romanx.gardzinski@linux.intel.com>
---
 drivers/ata/ahci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 9b8c0935001c..c60e7ba24502 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -283,6 +283,10 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		/* Comet Lake PCH-H RAID */
 		PCI_VDEVICE(INTEL, 0x06d6),
 		.driver_data = board_ahci_pcs_quirk,
+	}, {
+		/* Nova Lake PCH-S RAID */
+		PCI_VDEVICE(INTEL, 0x6e66),
+		.driver_data = board_ahci_pcs_quirk,
 	}, {
 		/* ICH6 */
 		PCI_VDEVICE(INTEL, 0x2652),
-- 
2.53.0

