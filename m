Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054F10A13
	for <linux-ide@vger.kernel.org>; Fri, 17 May 2024 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715924421; cv=none; b=UTwvDwr3vsQ2bFVaxs6+XJxeBqh5uvmITOW8dfSXfZxPV+zIoGrcFVHlbDPcUb1hD4lDiCcKXU69PhaO4mJhkNFto3wS8XVf2dUk3lVxd7Bfuih6r/uoBkdfqavXHuBi+MjXStgHck3WgvUFEwulgORgEhxW/ZaF0b8FYoxSe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715924421; c=relaxed/simple;
	bh=CSZnd8eKfl5gkfJW4prxBTGZTRN8I7q3N0OSwfk0jxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl5Mbibhmuj4tQcB7r/wKHIInzcFNwzh5pohxPOuLq9tbPZHVE14T87ucAB6s8v9fSDR6ibvtoZr0+VeyqWlkkZd+9wLBiYJZrwmJDMdc4uCEYx86qNTETXsD3jO32aFY2zJxNSQ/qoSEt1XShujw8iIiEtKhcS9ZStHkIb/skw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com; spf=pass smtp.mailfrom=kayoway.com; dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b=kGtSdPh7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kayoway.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b="kGtSdPh7"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b2e942171cso608083eaf.3
        for <linux-ide@vger.kernel.org>; Thu, 16 May 2024 22:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1715924417; x=1716529217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nH7y/iVQkVGz1VDCv8caPe7X2u4sc7v1eOWmfQlvSHU=;
        b=kGtSdPh72hOl3VUOsNqdFR+q5p6PDtaZLSwvM5X4BWB4i2LNbYLnFww8BPdTin/6uE
         QbaPBrABR1mEupSVRqEhd1D7oxZEvO1Ml08OkNiw3vCtui1L6gKthkh0Wl0CBL5+ROAx
         vpzUw01itEiN31yXHxWkFHG0PrT3Pw0xYRYlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715924417; x=1716529217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nH7y/iVQkVGz1VDCv8caPe7X2u4sc7v1eOWmfQlvSHU=;
        b=lqXudrvloeriLz/l8ua6oHzpIj6uAb4XyCBBX+0rHL/6/q6TBhTV185XhA8v4QhwEd
         goii92ImdpqhgcdAx4+p3nj7YVpN6WDaJlflbCpTCpsom9NcPZ3eWZCNv9Mixmnd8CVx
         CqMD+wjIKaMkJChAUjU0aWvRoB1QDN4ja3d6GQw+6numUVaeKj1BkFUWHcqwYzi8Kkha
         QX3cvrWnN9tuYGt8/pP0oq4qn0y/vh+RnbFJpZdhAOWuwd2FT+YK/ZfMT91Qkb8q3wlN
         cs1YaBxRcAQP4qFp/h0qDSL7z/sj8QQA8M/a4AKQTGx5b3kDT4RTHF0aTXCdlCfMRplw
         6NHA==
X-Gm-Message-State: AOJu0Yx+GYhfqJ88gJifSAqc/YzL46GduIeJ7F2gRt8TNksaA1LazkoS
	I0bX6TmaPAXAIOA41kq6g7iLy6C1BnbKD6GOM1FYZIjqk2qqtkTSUhWFUk9GjceFg9muN+gQPVm
	p
X-Google-Smtp-Source: AGHT+IEMGkN97umJzxQ9wVp0hBgNxABoTccWtyZkBGR4p8mOiuxQWjRrIrS0mzyr1VEPddXi5jIw1A==
X-Received: by 2002:a05:6870:d627:b0:23a:fb36:ffb3 with SMTP id 586e51a60fabf-24172a77f76mr24751600fac.19.1715924417598;
        Thu, 16 May 2024 22:40:17 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a665a6sm13944770b3a.2.2024.05.16.22.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:40:17 -0700 (PDT)
From: dev@kayoway.com
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	Jason Nader <dev@kayoway.com>
Subject: [PATCH v2 0/1] ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller to  low power chipsets list"
Date: Fri, 17 May 2024 14:39:01 +0900
Message-ID: <20240517053902.44622-1-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
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

Changes - updated commit message as per the kind guidance from Niklas.

I was not sure whether to cc stable, but if so it would allow affected
users to start to be able to use kernel versions > 6.6.10.

Below are logs including the extra logging asked for by Niklas.

Kernel logs with this patch:
>journalctl --boot 0 | rg 'Linux version|SATA|external port'
Linux version linux6.9.disableAlderLakequirk@archlinux
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 3
ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 3
ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 3
ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 3
ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

Kernel logs without this patch: 
>journalctl --boot 0 | rg 'Linux version|SATA|external port'
Linux version linux6.9.enableAlderLakequirk@archlinux
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 3
ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 3
ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 3
ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 3
ata8: SATA link down (SStatus 4 SControl 300)
ata5: SATA link down (SStatus 4 SControl 300)
ata6: SATA link down (SStatus 4 SControl 300)
ata7: SATA link down (SStatus 4 SControl 300)

Note I also tested a patch that changes the Alder Lake entry from 
board_ahci_pcs_quirk to board_ahci, and that booted fine as well.
However since it is not clear whether it is Alder Lake-S or
Alder Lake-P that was meant to be added to the list in the first place,
I have not committed that patch.

Kernel logs for board_ahci_pcs_quirk to board_ahci patch:
>journalctl --boot -1 | rg 'Linux version|SATA|external port'                                                                                                                                                                                                                                              master|0.1s|14:07:07
Linux version linux6.9.enableAlderLakeboardahci@archlinux
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ata4294967295: external port, not enabling LPM
ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
ata5: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802300 irq 125 lpm-pol 3
ata6: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802380 irq 125 lpm-pol 3
ata7: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802400 irq 125 lpm-pol 3
ata8: SATA max UDMA/133 abar m2048@0x80802000 port 0x80802480 irq 125 lpm-pol 3
ata7: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
ata8: SATA link down (SStatus 0 SControl 300)
ata6: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

Jason Nader (1):
  ata: ahci: Revert "ata: ahci: Add Intel Alder Lake-P AHCI controller
    to  low power chipsets list"

 drivers/ata/ahci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.45.1

