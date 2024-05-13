Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA871E497
	for <linux-ide@vger.kernel.org>; Mon, 13 May 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608396; cv=none; b=H2hJRXnIXw4ZrwIHdgzDUtiFvniTMK5c4P1tZr/CGLK2Un1fxtYIMA693jX+olee/APmBQbNx2vkbm50cIfX+zFFK9aOjqhlc0yDTpgTh1zNB++kGxFpYwmVAP0mynTla5mrdhUNV4xKKtJc0b0pfHm2sUJ0mKTpjzuelxc1OhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608396; c=relaxed/simple;
	bh=gz+nq/bpqCqaiqoGTjUShOShk8L6nXGb8iXQ4uY+PGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgxwhOxxTAongc2g+PFf5UQS4+vqXUOpUbLMw9A0YN9LxKioWlLo9ijIFeIrdm5z6z9p1lpFWU51VX9As9ENS3vXgtOZfOtnKl7DPqpKUAhE1I+qUcAvXMYBKMK+nMkJ+faP0/kdpAjB9XvhFvpEO+OC/KPZsSKcGymZ+gaAyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com; spf=pass smtp.mailfrom=kayoway.com; dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b=jq9qQkOY; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kayoway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b="jq9qQkOY"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f0e975f67fso2269119a34.0
        for <linux-ide@vger.kernel.org>; Mon, 13 May 2024 06:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1715608391; x=1716213191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RjhsiEjeSxYEFtEZIFqgPeTz0HCrVqBXR9WLAVvRqFU=;
        b=jq9qQkOYdBwhJqI+MiIF/DcwKUDOaUGh6fWXtyPpRYfXLw/OrPg2w7F/y0yR+7Z6xr
         4i654neFNBQ7Df4qkYZxN55trG16BtnzZf5BjI9DExJdD8HAPOo/GUACe+jlPFQkQWQg
         YGE1zAI8vBDCoNARY+PfkkZwo6sz5bTILkdek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715608391; x=1716213191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjhsiEjeSxYEFtEZIFqgPeTz0HCrVqBXR9WLAVvRqFU=;
        b=X3fKh8Oah74DJNlmj8uOt9uWjI/1LZQRmi8JTnbH371YznKKgyDJfiU7gZkfGM3hBB
         BIaDhlN1vrgYcFVxo2TJmZrT9D2n43jD1wiILfoY1xyf9L5rNzPDZkssQC/ulpLmjiJM
         AqTLa5nELPr2Fm0m52M8kqmvzY8K/CfkHqG3F0eGheoy+stouuiIWaKjY4O/4l3Ndkmw
         3BYYilOhZOX+pT+Xyh/0DEBA1wVATSU5raJKzemD3XgA8XgSU7e4QGfEqi2QnB+9950N
         MegoFPM8rS9km7Jk4b5D1zxyK/46tYLnFltNX84rrWYT9PCVEIJDCZGVYBXualbX2Zm8
         C7og==
X-Gm-Message-State: AOJu0YzhEJhHUWgNREsMtL3IPXZpXrvcMioWb8OBVwNOhYDAdacPT7WC
	8Otp4xz67FDrQoGUCFA6TVlzmpJuH23uG9BETPxD0JInwd6+UqWQ1DyskrQb1KYCHexPpsKSYPj
	FUSg=
X-Google-Smtp-Source: AGHT+IEPyWHioFrRUQ+AtMaCRyFgVWPsjCEtziH4Y/ZwDYlpppe/r7YHZmXAxzuYsn0K9IcYogdjIg==
X-Received: by 2002:a05:6870:9624:b0:233:4c14:bb1 with SMTP id 586e51a60fabf-24172a2376emr11833672fac.10.1715608391368;
        Mon, 13 May 2024 06:53:11 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66476sm7373778b3a.28.2024.05.13.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:53:10 -0700 (PDT)
From: dev@kayoway.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org
Subject: [PATCH] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"
Date: Mon, 13 May 2024 22:53:01 +0900
Message-ID: <20240513135302.1869084-1-dev@kayoway.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Nader <dev@kayoway.com>

Commit b8b8b4e0c052b2c06e1c4820a8001f4e0f77900f ("ata: ahci: Add Intel 
Alder Lake-P AHCI controller to low power chipsets list") enabled LPM for
Alder Lake-P AHCI adaptors, however this introduced a regression on at 
least one system which causes the SATA ports to become unusable [1].

The original commit stated it is for Alder Lake-P, which I understand is a 
mobile CPU, however the device ID added (0x7ae2) matches the one reported
by my system which has an Alder Lake-S desktop CPU [2]. Searching for this 
device on other websites points to 0x7ae2 being for the desktop "-S" 
suffix [3] and not for the "-P" suffix, which is apparently 0x51d3 [4][5].

Reverting this commit restores SATA port functionality on my system [6][7].

[1] This Ubuntu bug report also appears to suffer from the same issue, so 
there are more affected systems out there:
 https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2063229

[2] System details:
CPU: Intel i5-12400
Motherboard: Biostar B660GTN
BIOS Settings: Intel VMD off, SATA hot plug off, CSM off
>lspci -nn -s 00:17
00:17.0 SATA controller [0106]: Intel Corporation Alder Lake-S PCH SATA Controller [AHCI Mode] [8086:7ae2] (rev 11)

[3] https://devicehunt.com/view/type/pci/vendor/8086/device/7AE2
[4] https://linux-hardware.org/?id=pci:8086-51d3-1462-1333
[5] https://linux-hardware.org/?view=search&vendorid=8086&deviceid=51d3#list

[6] Kernel logs before revert:
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
ata5: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702300 irq 124 lpm-pol 3
ata6: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702380 irq 124 lpm-pol 3
ata7: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702400 irq 124 lpm-pol 3
ata8: SATA max UDMA/133 abar m2048@0x80702000 port 0x80702480 irq 124 lpm-pol 3
ata5: SATA link down (SStatus 4 SControl 300)
ata6: SATA link down (SStatus 4 SControl 300)
ata8: SATA link down (SStatus 4 SControl 300)
ata7: SATA link down (SStatus 4 SControl 300)

[7] Kernel logs after revert:
ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf0 impl SATA mode
ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 0
ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 0
ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 0
ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 0
ata8: SATA link down (SStatus 0 SControl 300)
ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

Jason Nader (1):
  ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller
    to  low power chipsets list"

 drivers/ata/ahci.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.45.0

