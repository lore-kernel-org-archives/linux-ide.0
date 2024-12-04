Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4D851C4A
	for <linux-ide@vger.kernel.org>; Wed,  4 Dec 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332247; cv=none; b=Ux0YM+RYdSTM02cd1pav8u1rkp3OyK+IZqIFv57vurem9g+IhAbukb7Ej2tINVPnaSv7Mq/5JCsNh71iiJ4FYJgVnpJVDLB6I+UqphHzJFvYOijLkbUQi4Iq55z+2su8qTOm7oDqChkzs/xppCpSiChmaJirfe7pj2JxgnvC5KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332247; c=relaxed/simple;
	bh=gkEnIFPyAj18HlI4xFlGO+AhQTxO1FXBH3LxNu22s8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh9nIS1/eDCpfMunMILVZSze6nV7pCdlHotwrAD9bgFjNHcNlfkNSPNET3qXkaoUX3F00dmbGeCEouV4Z8cj3mK6ao19usxMVLTylhOxgVSj1m4yTWrV/olzUJe5LwzMmqHP48wON2U4xhQoQ6jYkHW2jBwdjqR0pbocg1E3TzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YThcI1Pn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YThcI1Pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5/CqBabOzgKP5OCgCUiJ8LP1w3MtwNU5aNtjpSlwCo=;
	b=YThcI1PnlLcK5vqOXLvcYhWBFcGZSZiArDRbd0Yw0y38J1MrKBiew7Sc7lVIUCTBxyiTWN
	2IigU9UBHKJYXfEk4msjbboYekWVu3l4ajZ05Tuudl4OwoGLN3j4DHgkNrh4Nw3jyeJizL
	Q13jK8YzDIm8QbkfLWn+1wG7VHDIBGg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-lOgIUcivOXiGHP1DgDCd-Q-1; Wed, 04 Dec 2024 12:10:42 -0500
X-MC-Unique: lOgIUcivOXiGHP1DgDCd-Q-1
X-Mimecast-MFC-AGG-ID: lOgIUcivOXiGHP1DgDCd-Q
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e9c698e7so36054f8f.0
        for <linux-ide@vger.kernel.org>; Wed, 04 Dec 2024 09:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332241; x=1733937041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5/CqBabOzgKP5OCgCUiJ8LP1w3MtwNU5aNtjpSlwCo=;
        b=q/gXiphjTtu58Wj4XVPQ7MNwsTyM7wTxLg8tq6TZBPWXeHtYgHMEuS8WdiQmpJfjT9
         L2BY6eZG9qGSvYP/VmrylpBsl13gXB/TMNerS4CfuSbva2kSwtxvIqDohIowi8Qj0xSW
         5VJPAZ5GEG8eIzJqfAmOu1UqJej3S9ykY5sml3dInrI6+kSCqranWjhLEhrhDizdZeAn
         A0Xaj1uCmSNCzMAlRwKamFAdl7xchIf6hZukRrzGWVRhGX69umY6B3+C3rHgT0lsj3mI
         JnyCdi2BoOyy01U3wCuA55hLG5dUCrUpdoS4Cimnw23ZxUphFGaG31AifnvCXv9u5OLY
         gXgw==
X-Gm-Message-State: AOJu0YyP/7Cg8Zf42dfbs0FZgI0ZNzk6FoLOlU736x5gwbYMqKadXAHH
	+L3XK/Zu8VxnMDzkeRDCXcEycSgtPUgG0nt89fbKK2Ru9KlU7v7O8iH8a++wNcIwJbTHmMK9UxB
	c8PnGUTwt/H7VSRRfUSkLyF1OdWx+fFVO20AJSRoY1P1ygkB8n/SUILWI8g==
X-Gm-Gg: ASbGncvfCeeuXaMplvHyxcBjRW8nhvxJfCtLUCgdOhXyQuUaCv+Jh0Jc109wGpQWUCk
	OtyGSO2l96KXfyXn12iZvRDMKJKGaey/m002UMWwA0O8yc4LNo+u+M4VoIr2Qi3I3gRtP7NZqyf
	BQMoAeIQlbaubj1QGwCE8VdQocqTa0D9XiBYjoCUoAgYNNVlIRe/VFYNLJB8yTJ6wRst/RlF8w4
	t1/yqXZ4Aq6T3TtdN7U5qJUGDqLfx8IX+3k+AidnEgy93vIFmedEqLNe9HqGF8ZPa7/xTINYhnl
	aj2xTMCA
X-Received: by 2002:a5d:47a1:0:b0:385:eeb9:a5d9 with SMTP id ffacd0b85a97d-3861bb4c757mr130351f8f.2.1733332241584;
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8h5IdGp8jQgne0vlx5CXDQ/AWZbEN4VvTpEdLEDpVWoj+5ul8SKKwg6TIXjbXydGxkFUvZA==
X-Received: by 2002:a5d:47a1:0:b0:385:eeb9:a5d9 with SMTP id ffacd0b85a97d-3861bb4c757mr130334f8f.2.1733332241215;
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:40 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 0/3] ATA: Replace deprecated PCI functions
Date: Wed,  4 Dec 2024 18:10:31 +0100
Message-ID: <20241204171033.86804-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

many of you probably know that I'm trying to remove pcim_iomap_regions()
from the kernel. One of the more difficult users is ATA, because it's
the only subsystem I've seen so far that accesses that table
pcim_iomap_table() administrates.

This series only builds as a whole because of patch 1. That's why I
submit it as an RFC.

I want to know whether you agree with the basic idea, and whether your
subsystem wants this series to be squashed into a single commit that
builds.

Another solution would be to provide a struct ata_host.iomap2 or
something like that, phase out the pcim_iomap_regions() users, and then
remove iomap2 again.

Please tell me your preferred way.

(This is the revived version of an old series from August. In case
someone is wondering)

Thx,
P.

Philipp Stanner (3):
  ata: Allocate PCI iomap table statically
  ata: Replace deprecated PCI functions
  libata-sff: Simplify request of PCI resources

 drivers/ata/ata_piix.c      |   7 +-
 drivers/ata/libata-sff.c    | 130 +++++++++++++++++++++++-------------
 drivers/ata/pata_atp867x.c  |  13 ++--
 drivers/ata/pata_hpt3x3.c   |  10 +--
 drivers/ata/pata_ninja32.c  |  11 +--
 drivers/ata/pata_pdc2027x.c |  11 ++-
 drivers/ata/pata_sil680.c   |  12 ++--
 drivers/ata/pdc_adma.c      |   9 ++-
 drivers/ata/sata_inic162x.c |  10 ++-
 drivers/ata/sata_mv.c       |   9 +--
 drivers/ata/sata_nv.c       |   8 +--
 drivers/ata/sata_promise.c  |   8 ++-
 drivers/ata/sata_qstor.c    |   7 +-
 drivers/ata/sata_sil.c      |   8 ++-
 drivers/ata/sata_sil24.c    |  20 +++---
 drivers/ata/sata_sis.c      |   8 +--
 drivers/ata/sata_svw.c      |  10 +--
 drivers/ata/sata_sx4.c      |  19 +++++-
 drivers/ata/sata_via.c      |  31 +++++----
 drivers/ata/sata_vsc.c      |   8 ++-
 include/linux/libata.h      |   7 +-
 21 files changed, 216 insertions(+), 140 deletions(-)

-- 
2.47.0

