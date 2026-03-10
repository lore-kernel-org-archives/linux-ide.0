Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD143AB261
	for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157802; cv=none; b=LDQSLC5tx4C6340u3e89fZzI3NQrVSZLF8JMfiP+/IOgbQP0W46OnECZVyfz9gp9YZetchNTEmznc5qmHxNF232LUHji1kMsITNW3fRuFXhSppeSyi+FgQjqkOVn8SWu4zQ9VdaNwW+NQFHTbQ9ZJWEGSP9yOOUEfMM8g8Sud9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157802; c=relaxed/simple;
	bh=qRJ2RXIfOp119UAforntleD5Dh68J7+BswyTXnCO9VE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9vNl0CxgF0toGnMXyRWTMeIMxsM5XMRqTcNlfEcwrWnK2u2RvCnvnuCw6ZIpjScd6gZxGHExDJD4WHkQFAQzCFzjGXHvEfZ9vWfVwiTlJ2hJfpMrm3MpfHowLzhoTxXo8DucOY3wdXhI5P2f0bCN4kjFWphMBa6D2cqDGTdt1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Nn4iNR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Nn4iNR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so8649254f8f.0
        for <linux-ide@vger.kernel.org>; Tue, 10 Mar 2026 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773157798; x=1773762598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gD7Bgyxpv85G+VPy9BAW6wYBIhVRoNpHt++/EVQLMCY=;
        b=E5Nn4iNRUPhzQUOVW1a0ux+VQviNwrei+cdDQq/bfDgxZVP+VlbHD/GthCVv7EyqNe
         Zt4A8Dnl5LUqA1Oq1uYE7BXDFTG1zrQezhPM31r1tNRyyUkg4lFX1gtk4b7one+MNFAP
         j4PrFXIMfwbiXLhYuHsOiCtMafHSYUJrD+SM4LmA6lhZzQjP97a5qgZqO5LOr3gfggTB
         RnztlNv0dNrhbkyPzxT/ucEn9n0fLTySsB5jZphdgG00sb0JjlUyVxiKwNY9IqPoBkVa
         56+R3bbXvfYBADBhTz0Q7Kt+ZdYXrFYPwV2PCRGK6kZM5DcZj2vpBxCgdXA81iKs1ahA
         UDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773157798; x=1773762598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD7Bgyxpv85G+VPy9BAW6wYBIhVRoNpHt++/EVQLMCY=;
        b=iIvaxEkOj6bvG9Vyo7NYjCcOHkvAgOnQ6rsEzho1VNOjx7WLwCDEghdBzgxeEWQKfU
         N8LXrMdsBHUDZMZ10QO+onj4vK70vlfCcVnmA+EVWhvOkM+Q6KelOS9jSYbpx3LyeOda
         qTTp6sWpr11KEZqLAffvDU4e0Ud9OF+L7d/+YHSZDatR9o0on4iRnPmNq0zwNK/9tojt
         0LVL0nhJbAWEXPhVXK051Zwbv3QM4ymnPDMTz8gxbRLz2WlKMFVcFzz3Wi9F0DtlfkLg
         pvT3CtuKLER5Fq+eEhftg53jjpRsLPnQnVU1fSa7S6k7iAjOV++l41/4stUpMk/5Pt7z
         eB1Q==
X-Gm-Message-State: AOJu0YwO1oQ0OZdfkC/6WMs7HVTDYgmj2lenwUtcXnU9r5XR+7d3qztY
	RFVNODUKt70+pxAK3PfzguWfTxqxhtsoVvdXKSctUz2DlsIklur7xOJY
X-Gm-Gg: ATEYQzx75nvq61F8/jzFHhWS/y27wXkaA5FBdUI1j+OF/dY/mFx3QoJLu+gY9yrOOrl
	T8zmS0gVzX65PBT2W8XxADjym2WlB+D46W3TG496Jw8LT67EZ9ekzEtZGm5oE0xfNEzZJJ8dabX
	KmdUnECFdbG1Q0TpewPRfylcmNQY0kvoUaXaIpfdfsSU8lZIFSfRWv0rLYf1ad0ISyDDyR8cwfA
	T+aawky2suCThABObEMGksBExy2eiGcD3IFuXohzoTp21YR5JyEL1hOP3obgNL3iEz4sRbB3oGB
	k6fjjqtAlty6y0clK0vfUdfZE7e8RFtiLoPhyT/KjAZ8TlsDvRWcJfxDBeOIpT+my1pBBOM1Oht
	7Jekz3LmErrWVvOd3WqVGTVQ5SnG5BZbLmXCPtr8+4m6pKhbTJ91h8gtYqIIeujnDwPsvMMHzwN
	/fZyTM+1Zy
X-Received: by 2002:a05:6000:2008:b0:439:aefe:5cc3 with SMTP id ffacd0b85a97d-439da555783mr26822032f8f.5.1773157797983;
        Tue, 10 Mar 2026 08:49:57 -0700 (PDT)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2b9d8sm38155827f8f.21.2026.03.10.08.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 08:49:57 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH] ata: ahci: Add AMD 600 Series Chipset SATA Controller (0x43f6)
Date: Tue, 10 Mar 2026 15:49:56 +0000
Message-ID: <20260310154956.743071-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PCI ID 0x43f6 for the AMD 600 Series Chipset (B850/X870) SATA
controller to ahci_pci_tbl. Without this entry, the AHCI driver does
not bind to the controller and SATA devices are invisible at boot.

Users can work around the issue with:
  echo "1022 43f6" > /sys/bus/pci/drivers/ahci/new_id

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221193
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/ata/ahci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 931d0081169b9..a4935f9b80789 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -466,6 +466,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
 	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x43f6), board_ahci }, /* AMD 600 Series Chipset */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
-- 
2.43.0

