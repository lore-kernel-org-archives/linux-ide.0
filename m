Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03571F30BB
	for <linux-ide@vger.kernel.org>; Sun, 21 Jun 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782036533; cv=none; b=FgtNqbqwczj9PvMR+0sHSBIO65OcJ1VjrYFKVw+zaMSiduZnPd4mAGoUr44FN8zmN9Uk+4iBZhrhnhNQ3e0MCkCSHrxqVOhOKUmfhVfbbGAFYR0Sk2Sx1bKJOGR2ns1OBGDjzQqd1G4UcoL+CsfBUAgOFhWe59NRfswIcjJFGj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782036533; c=relaxed/simple;
	bh=dtWdOxwNWwXH7pw0zgQYfBj0nw9Rt475E7W4gPVnOIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgBnQMRtWUHKsZKJED0K7suLKM4xDQijuz3FvEkaD+JTrxFls7bDTmJf82Rxr0OAxvgFxXEj8J2+0TGVsAPM2xzjKkabB20ZUuSZJutlue0EJz4H/sQAx7hNRoo9f+Jlx0ArRwWvH+VpEtLzFpv7HTHN042oazTQn+psw8MSelI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd4jdKFv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd4jdKFv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-922951391d6so72636185a.0
        for <linux-ide@vger.kernel.org>; Sun, 21 Jun 2026 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782036531; x=1782641331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai/vQMf9K304uLaJT6I2I2q88PcbGz+JfSMbI420XYw=;
        b=Sd4jdKFvOh0+5nWQiYuFkcM1Vc++CqfAtYl/rz5SytYXG/uFGtW5TeO0aKMjhbH2fF
         fCbhr+zQjZ7EooDMGQWE6YiQMX9hMl5nmU/MgPdElwkJVLIp0g5e0KNZ5nBqfSgLw7hG
         2ei9Rtv9ZiE3Zl+4JnezkTi0G7UG4YbVySFg1S1O+1Uqpt4fkqSd4hDgyFdh0OmRCD86
         1XF+IRKQxXWkkPFHM1uiPsQSNOETA14E9VkhALgTk/5rIhS2Jukc71MvUoi+klJKIX5a
         i7Neds8cTo1skFAQAnZrpLpLltgszjQEpdBTyo7NBkI1sH5E+W1Tn3fVRUOqNdmGQOHO
         gxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782036531; x=1782641331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai/vQMf9K304uLaJT6I2I2q88PcbGz+JfSMbI420XYw=;
        b=hTmfYelvYM2ZDb7TBRT8e3EAHLi4FHtk1pQGnMXH/Swl510GWsLU5a2bMmFFvMTk8F
         nYy4ugpN2kbVAxGlWxcIs7wNFgYxJ9tkCCtJVn6EhmTM5ldWxuyI27Nq3RhwrMNCDSP6
         zmvG2flH0KmXR6JCevdkXubxNWpARLxYV5vjdihkFkAmWK6Av21lcS0YrAqg+4+hmGwn
         F4erLsL2gZiKj3kOTVNRg8PL9h1ffT8vF5uCPfZlUSt8vilHGJrt7Yzl7qhUfe2/qkgH
         wEi5byPIqzB/hiUb05+oF2yvZS+o9C8sPHPUDtbwT9YtNrbLDvqm5lBCZk3BrJpkDIO0
         VvBw==
X-Gm-Message-State: AOJu0Yw/YtYXuHV3DgD0/qibpEWHxBozHCAyhj9o8k8trP5duHDESt2C
	ltMB6S9/vSIOFc839JD94tM8wEZh0n0y7AZ1Pp/SQzuw8iMQkAodRv//e6uWZ+g032MCAw==
X-Gm-Gg: AfdE7cnZf+sOjLih3zoy8zB0KafGVZxuG2tUueMN+ZR38s1MqCUFClgPd1EesdgDqxs
	GL80CGIcKqzB+yXiV7y4XsxhU+my0+lwqdBlkVZ0KjbpCVXZtUuYV788fIQgb8t+9ibjERh/RHr
	x2CKiRBlx8Ndwnl3op21hymd6mxItYRMlsGojkM5HwEfIcLTo33oBPGkf0S2keAb0uedmLjh7Jx
	+KWtfTeaylMG7EGWak0Q67l1b/ghinz7UWjSBykLNmPeI0e0+vdeYncaVDyCNQkMcyNchNQJoxB
	sBpqa8RODZXF8M0cUxSErcaWka2PnNFo2O7eE6sh0ET+Gu3DX81QS+c0Ic6hNP8N7pZIqo/S/bO
	MYxnD8M09TryY5vPLX93NHTAJ/UPG2cO7nJmY/8g2/wLVhXKoEJy2guEkvkA29piq/s7dWNDik4
	kMeO0EEXPZG4fa69vSK4mdUcC0CpwTClnIkpHfg/8=
X-Received: by 2002:a05:620a:6cc1:b0:920:56af:ceee with SMTP id af79cd13be357-9208ef628d6mr1675860985a.17.1782036530765;
        Sun, 21 Jun 2026 03:08:50 -0700 (PDT)
Received: from claudeLX-01.hammies.cc ([165.173.24.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-921db359a7csm545405085a.38.2026.06.21.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 03:08:49 -0700 (PDT)
From: Alvin Lim <alvinwylim@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-kernel@vger.kernel.org,
	Alvin Lim <alvinwylim@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Date: Sun, 21 Jun 2026 18:08:44 +0800
Message-ID: <20260621100844.1224301-1-alvinwylim@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
can be handed DMA addresses above 4 GB - it silently corrupts data in
transit. Reads return different, wrong data on each access. SMART is clean,
there are no SATA link resets and no MCE is raised, so the corruption is
invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
or, on Ceph, mass scrub errors across multiple independent filesystems at
once - i.e. host-level, not filesystem-level.

This is the same failure mode already quirked for other controllers that
falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
The ASM1166 currently maps to plain board_ahci with no DMA limit.

Limit the ASM1166 to 32-bit DMA. 32-bit is the guaranteed-correct lower
bound; the only cost is extra SWIOTLB bounce-buffering on transfers above
4 GB, negligible for storage. A future change can widen it to the
controller's true addressable width if characterised. Until this lands the
only workarounds are disabling the IOMMU (amd_iommu=off / intel_iommu=off)
or using an HBA.

Reproduced on an AOOSTAR WTR MAX (AMD Ryzen 7 PRO 8845HS) whose six SATA
bays all hang off one ASM1166: with the IOMMU on, six concurrent
'dd ... | md5sum' of the same large file return six different sums; with
amd_iommu=off they are identical, and a full Ceph deep-scrub of a 5.4 TiB
/ 1.43M-object pool re-reads end-to-end with zero scrub errors.

Add a board_ahci_32bit_dma board type (mirroring board_ahci_43bit_dma)
and point the ASM1166 entry at it.

Fixes: 3bf614106094 ("ata: ahci: add identifiers for ASM2116 series adapters")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Alvin Lim <alvinwylim@gmail.com>
---
 drivers/ata/ahci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 58f512f8952a..895956c2ca15 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -48,6 +48,7 @@ enum {
 enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
+	board_ahci_32bit_dma,
 	board_ahci_43bit_dma,
 	board_ahci_ign_iferr,
 	board_ahci_no_debounce_delay,
@@ -132,6 +133,13 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_32bit_dma] = {
+		AHCI_HFLAGS	(AHCI_HFLAG_32BIT_ONLY),
+		.flags		= AHCI_FLAG_COMMON,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_43bit_dma] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_43BIT_ONLY),
 		.flags		= AHCI_FLAG_COMMON,
@@ -1559,7 +1567,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	}, {
 		/* ASM1166 */
 		PCI_VDEVICE(ASMEDIA, 0x1166),
-		.driver_data = board_ahci,
+		.driver_data = board_ahci_32bit_dma,
 	}, {
 		/*
 		 * Samsung SSDs found on some macbooks.  NCQ times out if MSI is

base-commit: 322008f87f917e2217eeac386a9410945092eb2e
-- 
2.47.3

