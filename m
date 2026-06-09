Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210713043B2
	for <linux-ide@vger.kernel.org>; Tue,  9 Jun 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034211; cv=none; b=b8prdp0tkB4OcBQdDZCrv7r9KI6uhqM0GSZWrwn8huhKkiO9QNBiTXl/Ocz2o0zVxuO0Oae6NfNMqKm2AihHk6qLQK5IbcM9i4kisod2qgcTpKA9STHIJ9xWBrdP2jRTyq3sqJd2BMzHz3RGVKeMcNBFQ1p+5UjA7Fgp9OeZN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034211; c=relaxed/simple;
	bh=l1ykvUUpEJo6EqEuoK+oqDet2hWtHxKreBVHfSGY8F4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYFjhZ52Pj2Is9WYlBSk+U5MUv2VRZ5k3h6Pbck3zqtqz2SyKHuedXiYrnw0PZwZeoyzZYE+Yq7Rg80x4ZartlkJfyeCzvD6GyjWljEfx3rbYcRP/KQC2mgr78PfAeF1LZWHlyjfFTfTmFq4TQVY3V/+gKwKISq00mf1weOz8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/tjfsJy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/tjfsJy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c858961a8efso2248375a12.2
        for <linux-ide@vger.kernel.org>; Tue, 09 Jun 2026 12:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781034209; x=1781639009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MKaybrpTNEWH0SVVMDdhd24L2LW5a4rMsS7LvjsoFKk=;
        b=V/tjfsJydJDysj2O+IMh5NbEaaU7ynW98WBtkzcomxJdQWqS3fg065diK2XCF5z0fw
         mIEmmg6T86NJGoCTy3OR1KfSwvplDGMuFI8evjeLdG6OXbEV2a0IAIZTTYNMHF/Iq1pK
         6g3Fkvwn+z6erB4T3IHTQKp+R68Y60Np2yRiIlj60CHlUJr0MJtGwx9L3gO/Wmj6kHIa
         L2iPOxacZjti41wf3kUVZkDvAX80uo8esBICILiaxwvaXKvbDSkEvb24AclKsM0c9rRW
         xdYHMdU4/y4jnj2DmEnGQe8F+dG/IR1psXtvw2GXaUY95aCde/e7G9DHDGgJwG2QeHVj
         3IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781034209; x=1781639009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKaybrpTNEWH0SVVMDdhd24L2LW5a4rMsS7LvjsoFKk=;
        b=lfCqVgWANMkbiw3eEFVYrZoW2K4Bmh67/pexO+XyoOSNKSDu6VmJVanccK3496UtfG
         qodVWlJ2PCH6/yphtB6Z7ynyWD7aVnfbC18tpa2c7lxsX4elACokX3o3NC16HuR42wkT
         j+5k+X05bHovAIqamtk1KSHDkJiFC2Jku6NiaWC8JqCU3Ottz7eQupcL3rnRMfN1J0Bb
         p5T87QryFTShsraXyIUPMCOGxxxQAJ9kUjMFHOkDm27UkoD/Iqx0N4njfE00DNloR6CK
         brdIy9fe89qhJ0wLrk8wHXcc55J7sGDtFBconReZKF+J9vjV5eyEe/CDUCCKeFiVeyi2
         w3xQ==
X-Gm-Message-State: AOJu0Yz4bgH+jn4SGv0C2OozxcwyrW3MT7Da+uqsqMmlxKKVnYqwIbge
	eBa0nIWfZ7QP3wFYrbcO77pc04keUY5/0FnuM19LgWXTysgdccH7T93OncWr2uzg
X-Gm-Gg: Acq92OFh0k31yx+sLnqk9pILFkPFsF1ryk5U+if+sGAdtAxrH0Vck9G9Ff9bFPfbK6m
	Xc211bdLBg+VUwj8VlmjH+X9h/ic5RdeyAxsoDcn/5rpZiCf6hufS2Aez8cyrfUnVwbXZJ9wFJe
	a7cVOWyI0aV4DHeeThYPdoNnJPnhBeh5idRJnXYCQ5nwJDIy4YSxf4S2zSoE/Vhh5Mo8e07PIHY
	gitBQ3XAdvJp3qaNTpRf3Eku+i4g3JvtF6ijQgzJSUuHTi8/4rLAQ4pip0DaZcOa4eRmgDPTutD
	MFr/xI33R50H74zwiDnMREeMvjlm4y6bc9nZhv5om+BHcoweFrHG98UgzFJXtwErn37XnUXm8OE
	wztxLkfLG3jo+a7cUoC2A7l1h2MlZ8LsbJYgO5TswADurlIF5kf7ZMyl7VXkoyAbe0tl3DJ0PeV
	xHcZnGZX7mOrM6avTdBwEFBP0in1DYh5HyYNsYmCP92sK8P0xQ3YU0Gffae6cdYfCyNTWi60nGi
	x9AEl3Z1Kg+RTmUu6nvmZuhVwxSkavBuVT0+9LVHnWCXZE4k3O7Zhvs
X-Received: by 2002:a05:6a00:4407:b0:82c:e692:1f91 with SMTP id d2e1a72fcca58-842b0fba9abmr23673035b3a.39.1781034209352;
        Tue, 09 Jun 2026 12:43:29 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828daf76sm22715683b3a.42.2026.06.09.12.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:43:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tim Yamin <plasm@roo.me.uk>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jeff Garzik <jgarzik@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 0/5] ata: pata_mpc52xx: fix cleanup ordering and modernize
Date: Tue,  9 Jun 2026 12:43:06 -0700
Message-ID: <20260609194311.6217-1-rosenp@gmail.com>
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

v2: add extra patch from sashiko review.

Rosen Penev (5):
  ata: pata_mpc52xx: fix NULL pointer dereference in IRQ handler
  ata: pata_mpc52xx: switch to non-devm request_irq for proper ordering
  ata: pata_mpc52xx: remove redundant irq_dispose_mapping calls
  ata: pata_mpc52xx: convert to platform_get_irq()
  ata: pata_mpc52xx: use devm_platform_get_and_ioremap_resource

 drivers/ata/pata_mpc52xx.c | 70 +++++++++++++-------------------------
 1 file changed, 23 insertions(+), 47 deletions(-)

--
2.54.0

