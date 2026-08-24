Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215D0446852
	for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585626; cv=none; b=UttOIdD9/Vo+tt+w4autyyl2CoE3IASCJhPAdj0eaukZfVdXcx6BB/qrkrtyHq1sheOFbL0q43LrK9NjFXmXVBe5BuwfU3FqSCAOm5uDn4UvLdnB+uaO0FNzXGZljRppkg09BVwKdAHXSbzD+16sScUnBznMuEn8QWdyh+E80tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585626; c=relaxed/simple;
	bh=irdB/N47x9nup4ZMgndI4EluVE6a9FeuoSZgv14k2Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgXrwkIIhcYSf2rBCIu/UMIhWuIa2+ZSg2yeRo9MI8fpy0o9Mvpajhk3o2UFGGi8vWJNdDPYNpShvhlOjhk2a/5uLAD0qnwcmyMzFEzTYtmLS3vMLX1VWc4c3oQvMHE7277XZ48I5Oh9aqbVAqa/HOE/KHFbWUSyCYP1Wm+JDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKJDDrFo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKJDDrFo"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a3e145e1bfso4819354a12.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Aug 2026 08:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787585623; x=1788190423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mgiwGq3XgC9ihO7TtDGqqTNElH50GlN8o3qDtfDCcug=;
        b=FKJDDrFoqpOa/cbixdPkzKy+jfK3qkhfTmiikqbxbxF8y6068E9ajH6ynJgMXtQMjk
         gZyfnax5uzWgeMqsq0tA3c3mXzmpYP7ka/91uPKaQraxvA79DYrg+/U8jdtcO/85PMM3
         Ibu+XGi2L2cbsZoGPS9vP3VA0dXtrsUWuLGaSsqGtItP4+Uy6n/twk1zMKF+fHqBbeue
         qGLfsMp9kT5gWQ/ftZKDt9TR/YqjKAyyFKWJZ2Cr6EUlJBySE9eOXQKqFJMZx9kBale4
         emPjJ5g412hqsr+YXRnULbvDTaFnJCYk0k7ZW3mPHMoBiPA64Va4ZtpRSw4pgnGpLnqn
         Vnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787585623; x=1788190423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mgiwGq3XgC9ihO7TtDGqqTNElH50GlN8o3qDtfDCcug=;
        b=ig5hvhdHu83bRmBJIcXjMA3H5K3/VFyYfxkFelSZymLB+pOD/3hC2/p0+JfjS1IbyN
         aS7xCnhXRwTER5s/hi4TmZcOTsIy/SgexnwYs8Cp/QRRS/dNjLWIzbKwG/S5qRzSsacb
         UfKmNIt1YcZrlxMVnu2s588W8UJSlQZKk9LJRDRlYdQQAMk6SceVeBjFaLiRRKZZnMjw
         kok3sBSDvvtr2zL2SuQ52EM6YUVDsl3fiYyK3in3G8+pEKlhtpx78Iyz6xHpZIxhkzI/
         QtRuHdFbP4/pf1Rws7trbuQHcaFMpB/C0I/5YpiGrnya3CuTfs9vZn8tzSPpUIw3YhaQ
         l3ug==
X-Gm-Message-State: AFuF++mMvf6TL3R/S/6CV747FLMr2uI/bKtXVD6AFMQNSG0qcF2tKyS8
	XLowJR6eaKG7ikdUeLyniXrqufqxE7e9u3qzNQPSSO7HwnYBHbbtHicV
X-Gm-Gg: AR+sD10dWMTaFpOs+RaMYaglyPScaiHgDYT6rFSLpQh9kCcxLqoo2iEc9PKTycxXidv
	4p5U21J+eFjLHZdE/aGcAud/Dy64awQS9f+dpHcN8M9VCJbKY4SNEkEabz9y38I/jiKyhCxPtXA
	7QFU5/Xrh2Dk+ziWj2tGAQIWqU1KVPEcSxIIvIPopUMoIJXzQLaTkN7yDztFD15jMdPifyYdWJB
	OLz0aIweXCFFGsMuPJ/ELQIVjSmlKyWTFm3N9NqZEyhRWDNJdNvUviXKaceUXARNpKe3TweBI0G
	K7RWktTmIpBQnOKc9Ux8XxkNR0TCNMoRYFd7r9UOYWkn51R8AiLqcnEmMpNMnClwKpTh0AwKOm8
	VMvFW0AXsbzOvlX1NV7cGCk9yUiWsclp7G3hmjyYMBtiM81N1NI5itw+Xne9ZY7M/H0VmmEblIJ
	wdoLdZ04yXH7Gr0VtAb2yu8eUFrnLoeAY8DNIJzeq7Va8lqcMIObj2MmCEUVMeqm6C+5INPows/
	fF4YN33E/6GCgakmRqx+TG21diT3Tl/xd+yUcIsMfW4j7BGdIkuKCUeKQ==
X-Received: by 2002:a05:6402:27d0:b0:6a1:2efd:8687 with SMTP id 4fb4d7f45d1cf-6a42f20afd9mr28438487a12.14.1787585623059;
        Mon, 24 Aug 2026 08:33:43 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:5fe:e162:f6c3:e4f5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5b93f3acdsm2791355a12.19.2026.08.24.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:33:42 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] m68k: defconfig: enable PATA_CSWARP
Date: Mon, 24 Aug 2026 17:33:39 +0200
Message-ID: <20260824153339.512487-3-p.pisati@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824153339.512487-1-p.pisati@gmail.com>
References: <20260824153339.512487-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the new CS-Lab Warp PATA driver in the Amiga and multi defconfigs.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Assisted-by: Claude_Code:claude-opus-5
Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 arch/m68k/configs/multi_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 5ed08e0fdf88..b769be5a0cbb 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -284,6 +284,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_MD_LINEAR=m
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index 615e2dcad3d3..078d71e9b7cb 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -310,6 +310,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_FALCON=y
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_MD=y
-- 
2.43.0

