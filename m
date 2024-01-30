Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCA160B9F
	for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2024 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608828; cv=none; b=V3mBfl7poXAVTowly6ld/v9OXEXDqsAexr0IvZGdNdfdfHgyKMhigv2GqVckF2xHYk0lHid1EVp/9wuAtWC31U8TtH7cBAmWSOaQkq8QHsU/Xl/s7lXYoSg1/D0ZN05asKvcw8gyYTbG4Cr0zPCTRDKMIGl8JTAWwmuF96Y8w/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608828; c=relaxed/simple;
	bh=UXxOFnzyPjSmWhL7VN01cLQZkxTaV1mX68f4OmqP1C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPPdyYwGeGRZ5DtSxxtCJunJmI8deKwPnISPi+Q0/lTD4A29NfH/apQs8ua+LFRXmsgrJ7u6f1/TQonFdmR7Rdn1QtYvKjWeQK0YeEf1JvkpgxYoFQoBpErfCpI9fgpkk1SofMA0KkTEyXIo1VJ/k0MUtuebmhRssuJjUbKfil8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=XFxZfmIC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="XFxZfmIC"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddb1115e82so2468442b3a.0
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2024 02:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706608826; x=1707213626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b8wT6bcymUslDtltBZzAISdjS3jJfOOrz/LevDJCQnA=;
        b=XFxZfmICV3268PQyy8LsPPvJWfUwpbnkOgIuLrCTHiIIwHU4+G5pj/9KBrVGiA5DZI
         gr3rHTmTnECx62dynyV94UXRv3x1wDvmOlfPUYN7aN3NxfKHRB7XPL2kTk8PUJUKwGBQ
         kfu1Mb1rTwfZZLiB6IFgnybZyYoY8Fmd5lLW93r6C2ElBL8CH/q4jEgI8gcAgJMRbdvF
         p9o11P5r1oSSjGGYVP5+Z4pOqIEQnMpoEDCSBw7tfLWYWLq52vhuSwB72ZwFCexnUki4
         QUSHGgyiy4r/nWhL2YwWyOIUSbLJ9xv8NlQWP8ocphquFTM4Oj3tNY/tQXVD33w5nMg5
         V61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608826; x=1707213626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8wT6bcymUslDtltBZzAISdjS3jJfOOrz/LevDJCQnA=;
        b=mDfUsCrPImKysxywfqvEloj9hGbUNPGNsgDcYABKRJOjTa2TuCEF4Q8vWJ2g1gn4dD
         4lB0L+5p3gIkjqTl/AWsHFS3wI2pYt/Z1v+csnbErcC7MXBJ1h/pgECxJNwKTAxc+RiJ
         F3AwY+MvPTiNvRjLH3R0p1QJMwSZDH+lX3R77ougD8NcFexfxcVIVIQE/X3l1kJ1hcPl
         w1VNAlTD8x7+YhGK5nuJ6rPLLNspziSPOxW+pENwDXyleXIlvkUAk9M8Y2YzOYUhCiet
         dNUXiGZW5QXo7AbzTIB+XOrVbLl565ofJbcXvpQ4SbbDd4QR5xkB3//EJ4PWs0BOYOA+
         gRVA==
X-Gm-Message-State: AOJu0Yw4FWThWA6QF20mNBea5lZpOmqay7XLjB3O4p3WgohormoICHc7
	FVvkAHt7LlZnJEaosPd9U4bihDp07km+yXwO4quPek49WowlpOWw+Q1DOgEIgvk=
X-Google-Smtp-Source: AGHT+IGDHT0UPx/DNjOeTCfqAlne/0fbxsadm9lL9NrmGBXb7/BJ1WXgntbW37yuK8GXzLGuWXYMBA==
X-Received: by 2002:a05:6a00:179c:b0:6dd:7fd4:9fa1 with SMTP id s28-20020a056a00179c00b006dd7fd49fa1mr6712516pfg.8.1706608826374;
        Tue, 30 Jan 2024 02:00:26 -0800 (PST)
Received: from localhost.localdomain ([123.51.167.56])
        by smtp.googlemail.com with ESMTPSA id w22-20020aa78596000000b006dde44a2d16sm7345021pfn.199.2024.01.30.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:00:26 -0800 (PST)
From: Jian-Hong Pan <jhp@endlessos.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	David Box <david.e.box@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-ide@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@endlessos.org,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
Date: Tue, 30 Jan 2024 17:59:33 +0800
Message-ID: <20240130095933.14158-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some systems, like ASUS B1400CEAE equipped with the SATA controller
[8086:a0d3] can use LPM policy to save power, especially for s2idle.

However, the same controller may be failed on other platforms. So,
commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
controller") drops LPM policy for [8086:a0d3]. But, this blocks going
to deeper CPU Package C-state when s2idle with enabled Intel VMD.

This patch adds ahci_force_lpm_policy DMI quirk for ASUS B1400CEAE to
fix s2idle's power consumption issue when Intel VMD feature is enabled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218394
Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
---
 drivers/ata/ahci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index d2460fa985b7..6bc5298a4adf 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1434,6 +1434,33 @@ static bool ahci_broken_devslp(struct pci_dev *pdev)
 	return pci_match_id(ids, pdev);
 }
 
+static bool ahci_force_lpm_policy(void)
+{
+	/*
+	 * Some systems, like ASUS B1400CEAE equipped with the SATA controller
+	 * [8086:a0d3] can use LPM policy to save power, especially for s2idle.
+	 * However, the same controller may be failed on other platforms. So,
+	 * commit (ata: ahci: Revert "ata: ahci: Add Tiger Lake UP{3,4} AHCI
+	 * controller") drops LPM policy for [8086:a0d3].
+	 *
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=218394
+	 */
+	static const struct dmi_system_id sysids[] = {
+		{
+			.ident = "ASUS B1400CEAE",
+			.matches = {
+				DMI_MATCH(DMI_SYS_VENDOR,
+					  "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_NAME,
+					  "ASUS EXPERTBOOK B1400CEAE"),
+			},
+		},
+		{ }	/* terminate list */
+	};
+
+	return dmi_first_match(sysids);
+}
+
 #ifdef CONFIG_ATA_ACPI
 static void ahci_gtf_filter_workaround(struct ata_host *host)
 {
@@ -1760,6 +1787,11 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			ahci_pci_bar = AHCI_PCI_BAR_LOONGSON;
 	}
 
+	if (ahci_force_lpm_policy()) {
+		pi = ahci_port_info[board_ahci_low_power];
+		dev_info(&pdev->dev, "force controller follow LPM policy\n");
+	}
+
 	/* acquire resources */
 	rc = pcim_enable_device(pdev);
 	if (rc)
-- 
2.43.0

