Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C314EC7A
	for <linux-ide@vger.kernel.org>; Mon, 13 May 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608395; cv=none; b=MwaxA2czOQU4U0TWr4KoInev0rW+Js8uaY3Q4Rs0CWozTuH/GF4nI92M5M2wr7hHj8ReQksV1IiZ0o4UgaYtmT78aV1Al8kfiZDTXgpx2e8Ts2Gdz+q4VvuEyBuLaI+pg+PtABI4mO9R/ONGq0CC3wlFbGCj9sA7sokBXsW1ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608395; c=relaxed/simple;
	bh=nKCtgVqnuVwYGwE44693TwDYxtDt7TZTYPBAiMrDCxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srhFpyH33VbIiheTMZXMWI1UrJjnogFzv3pLWw5ePHiTHu4zkYnHhnDFCzONJBucKEpEqIrPDdx17xE1W2azDMruimE4ppgGFXk66pqzrE/uF34ESf1QCiZNfpH1Ppv3AMtyQkYa9Mig7MIa99j4RFYRC6wdpRfQ10IvedKDLRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com; spf=pass smtp.mailfrom=kayoway.com; dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b=a7o5lJcv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kayoway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b="a7o5lJcv"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f490b5c23bso3656951b3a.3
        for <linux-ide@vger.kernel.org>; Mon, 13 May 2024 06:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1715608393; x=1716213193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udVn4LZw64M3seB+IwLN3PdqbZ+w/sTwgfjJfmGjScc=;
        b=a7o5lJcvjvFNch3xfelL/B2pqGg4IOkUCqaNBlYbXKbOBvCu/QEU7SkAhVaqCXMjnS
         F5+WbBr4osaaa16PR86zKQLzoAp2tNQ6+RZzP+oaBIch1U0XhcqjM/2j4YuQvWkmz+ex
         qd2bMZRa+4BRbxvZRIWp/B14VNZXiaq/2intY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715608393; x=1716213193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udVn4LZw64M3seB+IwLN3PdqbZ+w/sTwgfjJfmGjScc=;
        b=VGM/c78Cz1tkQ4OxJpPrsuhwsHGktYLQGJ9JqPqGiDWio7iGNtUZAZ1SMTwezwK5lF
         7lZc6rsAUu3hPPT1R5ZI3Bnb8SQ/tEu1UIIecU9yxgtZw4G+eJZpS+RONID0h56OgT8U
         42KnKNLxuOurvu1IzgAwW5SYkmp+O3GpQhAlWNwKRWQRBxHpAuQKophzMq3twmE2aB1B
         bzL9P0mpVTiNcuUR5Ytq/gu/Zzdz/nbGHGb/glfVupMc/czJc3Ih/1+zNIyLxPRnxklo
         B+099hESVeHX1BRT4AkfAGycron4iD0pT/fXm4YtNt/XXPLo9a5/5nIcqsLlJKl4kd1G
         7i4g==
X-Gm-Message-State: AOJu0YxYFZ52H8dGbmBzyPljd/qvuNbEy3tcXmgbm1PBY0+xra4RWwNK
	9klZ7rtuq7Z7D6plEol3kubpzaiS0dSo0eEKiVYP/rKtC54WhSNeCDdTkxrdWkhrAQshhftdxe0
	jPxw=
X-Google-Smtp-Source: AGHT+IFyU7PCnj1fH8qDM7VMqA76E0sy5xErr1LCXa1BK52ZIqXfU9cxG6ectpxu+TT/zkTLoOJ1MA==
X-Received: by 2002:a05:6a00:13a6:b0:6ed:5f64:2fef with SMTP id d2e1a72fcca58-6f4e02cec14mr11729614b3a.17.1715608393081;
        Mon, 13 May 2024 06:53:13 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66476sm7373778b3a.28.2024.05.13.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:53:12 -0700 (PDT)
From: dev@kayoway.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org
Subject: [PATCH 1/1] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller to  low power chipsets list"
Date: Mon, 13 May 2024 22:53:02 +0900
Message-ID: <20240513135302.1869084-2-dev@kayoway.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240513135302.1869084-1-dev@kayoway.com>
References: <20240513135302.1869084-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Nader <dev@kayoway.com>

Commit b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f ("ata: ahci: Add Intel
Alder Lake-P AHCI controller to low power chipsets list") enabled low
power mode for Alder Lake-P AHCI adaptors in order to reduce idle power
consumption, however this introduced a regression on at least one system.
Revert the patch until a better solution is found.

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
2.45.0

