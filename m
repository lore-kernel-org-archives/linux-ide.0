Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B3DDCD
	for <linux-ide@vger.kernel.org>; Fri, 17 May 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924441; cv=none; b=cHxxJk6B8IgFv/YoNVfIyOUhvqiYjrOD/djhECuAXxMc5wBeS/2Qb/czA9ksKwY5zYoSe58suMvj+t3VWK7qglZCEpCHvquYlhbAy+AcCm/Vxlt5o8TczFIRnVY/PsQEmpDrb3TnVkcVSCsmbX7vA4+QZ0QSc9W3tODTU5iUYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924441; c=relaxed/simple;
	bh=Lmx+3oDHv+b7PgvBascSGQgkiVdlyeTdBAzDi7r3cYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHF7AcHBqgBKDpOa1RNAzKpOgozR5mi761P7x5ALunH0GA9kP4by38Bo5toNXSrzsAX9jQX3oe3PhEvHgdW8qFFXP5o9OI7vAx93pmYoVtM1AOtOslyuYNcWp6dzvSete8rdRkDROpjBUYPNhX65LuMT1+rFY1lpfFiZO2cEOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com; spf=pass smtp.mailfrom=kayoway.com; dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b=sVXkN2zf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kayoway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b="sVXkN2zf"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4472561f1so1030625b3a.0
        for <linux-ide@vger.kernel.org>; Thu, 16 May 2024 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1715924438; x=1716529238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55UtSevslBEiBwmsUoC7VIcUm6g1mhkBdh+kW3p2rE8=;
        b=sVXkN2zfloyG7Eiulfeg+w2TtqLvxnawIYyoiKiB1n/KgCMAVYD/UpWnUPXhZKzRcN
         On83RgZv0iUVk2p/nwINYPJVi6GdMwXbhH/41TlTN+H3TUApmYrbkWCPpS7SNf1RtEDM
         +xMgnWqDzIFdJ8E1L8VhruLhYA83bj6chorrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715924438; x=1716529238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55UtSevslBEiBwmsUoC7VIcUm6g1mhkBdh+kW3p2rE8=;
        b=PQE7S0K7KEi68GquE8IptARfOcgV4J8PS1Pqap3IIrWKroKSmGrrnZYzkUPlLkAvQ2
         xFqy6jit75/bDU6aGSNgu1D71ox9lvTgQAZfPjhEoEJQCG7OyJqZ8LXY8wRL8H2InB1p
         bjPDNz7AFb4Ab/UL+GDzDqWXTahlJ6nZDLO6BffSaWtZUKG6ODDfyh8RHrsMmOExE0F+
         tzQgD0QtkW2cgoDJYRjgCpRot2wukI4T0mpah7YmVL2cB+Yu21wtLQ0fFM5XPoKogc6u
         d+Gy/8eKn8N8Ewy5OetCsM51JDTopQvsoHzYy9tp441JYq4oaJOQ11n4Vhpkty4ToJks
         ZoIQ==
X-Gm-Message-State: AOJu0YyrNbZ+T0xzzSyOE6tA1ydxnRX5WemhS9K+1D4TA4RLx5akF9s5
	aqzMsq/f1X5anIefwXt6gDDucDTbsTxwIEqkjvd/wYgF//htcjH6Iz4efhtA23xjTw4mhEp+6i/
	H
X-Google-Smtp-Source: AGHT+IE6qosdd7e8oNFWMQ4Uld1N2J10aMJGCtJL/Q/PQgcypP4dZu8NLS7IRWMcJV3w7fpmjM9joQ==
X-Received: by 2002:a05:6a00:4902:b0:6f4:f898:6741 with SMTP id d2e1a72fcca58-6f4f8986751mr18028308b3a.20.1715924438248;
        Thu, 16 May 2024 22:40:38 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665a6sm13944770b3a.2.2024.05.16.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:40:37 -0700 (PDT)
From: dev@kayoway.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH v2 1/1] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller to  low power chipsets list"
Date: Fri, 17 May 2024 14:39:02 +0900
Message-ID: <20240517053902.44622-2-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240517053902.44622-1-dev@kayoway.com>
References: <20240513135302.1869084-1-dev@kayoway.com>
 <20240517053902.44622-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Nader <dev@kayoway.com>

Commit b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller
to low power chipsets list") added Intel Alder Lake to the ahci_pci_tbl.

Because of the way that the Intel PCS quirk was implemented, having
an explicit entry in the ahci_pci_tbl caused the Intel PCS quirk to
be applied. (The quirk was not being applied if there was no explicit
entry.)

Thus, entries that were added to the ahci_pci_tbl also got the Intel
PCS quirk applied.

The quirk was cleaned up in commit 7edbb6059274 ("ahci: clean up
intel_pcs_quirk"), such that it is clear which entries that actually
applies the Intel PCS quirk.

Newer Intel AHCI controllers do not need the Intel PCS quirk,
and applying it when not needed actually breaks some platforms.

Do not apply the Intel PCS quirk for Intel Alder Lake.
This is in line with how things worked before commit b8b8b4e0c052 ("ata:
ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"),
such that certain platforms using Intel Alder Lake will work once again.

Signed-off-by: Jason Nader <dev@kayoway.com>
---
 drivers/ata/ahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6548f10e61d9..07d66d2c5f0d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -429,7 +429,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
 	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.45.1

