Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553339E9B0
	for <linux-ide@vger.kernel.org>; Mon,  8 Jun 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955259; cv=none; b=UII0q6XWN87VbZa4n13xQ4OzLJy3TNyMq7KgZRQsoj1PuXfMTky1nNTAs4V/jmUh/AuufhB7y4bkx4oHS3ANKBjfen6MF8a3weNj77e6SwTG30ECuQjC55guQwZuVGMEeF1SdE3Wf7hb07/Zy9n7TfxFbFLyGC63gSLpTgu6hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955259; c=relaxed/simple;
	bh=Cs8RF66VXH0FZvNEec15nNUfJ+jOAg4nrbIAlIRIjWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d1n1Lq7slPzJs+slJ32jSMNLhMSg1Sz/yIwE/3ymmMb1zMoxm2JwYAQFo6ZvoxU759BqvvJmGZcky87gf7obQYsdtbCScDpVGI4hI3greW8jsMg92LH6McUSb6DUrtpUusFDrYJw8FX6agyzPOw6vhYgaWDru8Rm71rVVgeYLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1yDOYJp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1yDOYJp"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so4980021a91.3
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2026 14:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780955256; x=1781560056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNWgux0XZGrYmGXRTAW1HdM7Fq4xDAdijXCv4nyh8y0=;
        b=L1yDOYJpYG2jl23KJu4avl87wwfrle2Mr6VS2anIRRzuzR3I3DQWFjUcsNo3fnWshu
         c6jK2ePuSi5HorAEpsavXd8sGky+tITeJD6aFdPvb4arzGBGZdjX4kFPgBBQFtHBijmc
         xYV4pl7k6ldN4sp9LnvwnXwzrP0p5lkpgPbOrQu0kQR8rYHVR6WXWQM7N38Y2IPwYd0B
         +zOoBsjV5HDnkLQEfE8a/+Op4RRCFeJZPUO+NucCmI9TSAAjotXrlSOzN2Z3KOqeRpt9
         F5jcnhrMmnFmgo7meTMSNUPlnmpSOu71BZILD+81NsqrWB+G7bTPk4FvSfvKsIQb4rw7
         KYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780955256; x=1781560056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNWgux0XZGrYmGXRTAW1HdM7Fq4xDAdijXCv4nyh8y0=;
        b=d8tWYfsp1vjRikqS6wX+wWa0SpfDGsKwclqQ+ZZ4VXuPt9Mj2RKuHEo6B7xH6UdKYf
         GtYJYeFZduSe6BzEbD4RCTWgqKEkNFkIeJF6mnR86NtAbL8kx5A29/mdipdqSEgkIFh0
         jl7fzVo20QFORTzH1Ub3Q3/BR+ks+w5+XPTjc8caGNMV47CzHXJP8BVf1iMNM7N4Fsmg
         WojYzA8em25UFvKXwf+DJeCW09hAFZcSW1I7v7V3RWOIwFwAGwvIegEzdc5jWqHC4QqM
         pARTzUXFRvVBUAHRzWaj9H6Qf9CV6iP9AU2L0cQnoILTkKxrVm7md0BL3TKkIKZVoVxH
         CUnQ==
X-Gm-Message-State: AOJu0YxAubTUa9Xi1M/WIJlaed8pLC1beMt1Y3MbIkt7ax82N4yKbrnQ
	c9730tYZF8JVQDHQE6JxoIOzVbY0bOiuoTF1xRy681saeWeDC++LbjN0QlzAtz2n
X-Gm-Gg: Acq92OHOY8S/xcV2shojpqed55UyBpM9USqKFFX7QCo7D363wrwj/ZmkMKYnXIG5HAs
	2cIVK2wJe1Gw4eBHGIFnEmadqvR1LyETpSLI4LI65O9cNJzBByfXs6h4dSH3BVOjFYyEi+c/NXv
	G+6XiMy0t7rZWCLeLvcEQqvf39nm4z7p2jNOZ4ABeKZry/2v4JOiOxVsZFVGvdCDQd0kRneDZCX
	ie55X22KepqhhKXwNibiJs9633pk2clMPZ9sCv0z0bHtPNOuPL4gEgXssOEvXoJRquPTGTHbUXb
	2nXvhn8IgoqSbZozTD6AtGeDyUbqDZlcpo/tVW73dDjPKfHGOOStKAqv1N+m8RIWPab4GWUgFXv
	55h2xGbMlOCaS+8RmnPNdau3atcguWvEzQ+jwNx42IvS2SMItvSZdmTqTBhiEurogbuNZmVsER0
	oIUHA2GOZpbPlkvKwKxAGSusf/0mOkInyBHVwldh3b0z7QFeVxWxzu3OtGCYBoGBOLty5snX11l
	+5fueq8Q6KuE7FScYs71o3CLKhp56PdhYMw41VZZYbHLw==
X-Received: by 2002:a17:90b:554c:b0:36b:9512:871b with SMTP id 98e67ed59e1d1-370eed0b682mr18481983a91.11.1780955256253;
        Mon, 08 Jun 2026 14:47:36 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b2ddbsm16016505a12.24.2026.06.08.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:47:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] ata: pata_mpc52xx: fix cleanup ordering and modernize
Date: Mon,  8 Jun 2026 14:47:14 -0700
Message-ID: <20260608214718.49503-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several lifecycle bugs in the MPC52xx ATA driver:

 - The BestComm task IRQ was managed by devm, creating a use-after-free
   and teardown inversion.  Switch to non-devm request_irq/free_irq so
   the interrupt is unregistered before the task is freed.

 - The error and remove paths called irq_dispose_mapping() explicitly,
   duplicating the one in bcom_task_free().  Remove the redundant calls.

 - Replace irq_of_parse_and_map() with platform_get_irq() for proper
   error handling and integration with the platform device model.

 - Replace the open-coded of_address_to_resource()/devm_request_mem_region()
   /devm_ioremap() sequence with the standard helper.

Rosen Penev (4):
  ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering
  ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
  ata: pata_mpc52xx: convert to platform_get_irq()
  ata: pata_mpc52xx: use devm_platform_get_and_ioremap_resource

 drivers/ata/pata_mpc52xx.c | 67 ++++++++++++--------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

-- 
2.54.0
