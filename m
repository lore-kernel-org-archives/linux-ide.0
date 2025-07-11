Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10387146585;
	Fri, 11 Jul 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233829; cv=none; b=ehNoNZv0qQgjxRMjNbGnyH3GMlosvkX0rON0AYdsrj6sCYtr5WZ5kTxn2J4KoXm9K+aYWb4xlHjVLSIdqII2GdqNboSB7ANTwlsLxVZzzoGy+qZOlRCvhOkOUQV1vuO6/qxiUcBB7OGpoHF158Q3yC/eX/kjNcwIjYTchGtbXTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233829; c=relaxed/simple;
	bh=cecSWB+HZVJT/b0dYkOthiSGy4tvUgtjTM32IfmWHx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeOG4vyV9S9PYcFgsflFSFZgUJ/VcLNrUY9Coa20Gm0OMcfFgx8R54IamUoCFlLIMJUZMYT8LZutQiWDiRs9cKqml7KCPiIVcZX89dVIAM0YGjwbBdoGBs8H2c7IlZoN3tNGlTr7T2wwXrEXCc9a6yFy+zUozJNZ7JNxQ8VSAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1a5KHI0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1a5KHI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752233828; x=1783769828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cecSWB+HZVJT/b0dYkOthiSGy4tvUgtjTM32IfmWHx4=;
  b=P1a5KHI0AEg4XUlWAt0tJb+i6d9y6Sf3AVjynFumvctZULCh7MMEnq9z
   1QQEgtsC0CondkdsjMg6cEGR1ZtvjQQGE27uNJ292JC3X2O7sGKMni2yF
   qUEHeJPbgeEmlkk8V+3IoumI0OD/60RkFi6U5CkrxMAxgMGALSBADJJn/
   A56iND+T1UkJod72zZFCnmVGV7R49Kc1ywwu8iBFx9Wr/2APCz2OhKPaN
   hQ2E2rPIEPCAQ7U8pyy4/+N9BqTfPD9J58G+6m2COm1M53ab/agRgsrwn
   iD+TXAxJM14/ak9u9Qr6Ncir/OPw7w/zvCfAT0ba0cFwmlQfeHBncjmPs
   A==;
X-CSE-ConnectionGUID: VlsQB8HmQvWur3fPFiNFMA==
X-CSE-MsgGUID: HhwvV1kwT3q8V0KXQHh5Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71979766"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="71979766"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 04:36:54 -0700
X-CSE-ConnectionGUID: 5AKPcXAPRNio0LuOJgS58A==
X-CSE-MsgGUID: Xz5jWvJwQSWCrEj7xw2QRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156683333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 11 Jul 2025 04:36:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EAA1D1A1; Fri, 11 Jul 2025 14:36:50 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] pata_rdc: Use registered definition for the RDC vendor
Date: Fri, 11 Jul 2025 14:36:50 +0300
Message-ID: <20250711113650.1475307-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert to PCI_VDEVICE() and use registered definition for RDC vendor
from pci_ids.h.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/pata_rdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/pata_rdc.c b/drivers/ata/pata_rdc.c
index 09792aac7f9d..19cbb5c94b42 100644
--- a/drivers/ata/pata_rdc.c
+++ b/drivers/ata/pata_rdc.c
@@ -359,8 +359,8 @@ static void rdc_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id rdc_pci_tbl[] = {
-	{ PCI_DEVICE(0x17F3, 0x1011), },
-	{ PCI_DEVICE(0x17F3, 0x1012), },
+	{ PCI_VDEVICE(RDC, 0x1011) },
+	{ PCI_VDEVICE(RDC, 0x1012) },
 	{ }	/* terminate list */
 };
 
-- 
2.47.2

