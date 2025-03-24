Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43CB25D8E6
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808255; cv=none; b=qJ8q9s96G0vPbtNyqw7SK3LnPkYBu+21BnDSv9XDBIBhhxm0BOcq8XvtZ9NsvPk8iBohSDpPi0OZhV6OeNcncWF3mnE0LMb4egkGtmkDv/ikeOwURDtRnGm30CM85vubIUjoTQPP5W+n176y430EAude8dA1YCff62l/HvW9zgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808255; c=relaxed/simple;
	bh=kuvEtbfkl6Ezkk+GzK431w6+dJv4gwMnjWAsjS7JUro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vBnxQrCdozabVEq6ggbcahq1Nob8Cduk2t8VogtOUsrawujCpWA5eMQCTkUFFu9VsEkIJXpkpx2OAStau7R//ZMwtApevhg10A8khdp/ZqN1rJ7HSqVdMb34l9xcvuG0NC7KWPgER3Y/Tin2Lh1fIptjAP6PKtRxTgWkxI221cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGWx6ZCO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGWx6ZCO"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2322469f8f.3
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742808252; x=1743413052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=YGWx6ZCO6e/fL/hZM+zlcnI5gHWgGX4cIkU+W59WG3yxDpxNFuOiqh7AIOXguPYftp
         AYMhdvqM6v26pLgo88Y4JC9kwvjbJYUN9/LtC/4woLVES++hlNDXkwJYsS/21w3w3Ph5
         iMjLRZ8NmUx2WBjc05af9InL0MZjbps/pd0qPM77DM8WEVcgrd9KyP6CrUgJB7nYALQ/
         xrcQ7irnVsfpu8CrzldjF9qrnSEMhEjWoSjmFOeLZ/urKAlKL7uNYI8b73OCd+XvFHTX
         xlaMCjBu1SBr6Fy5szTXUys1BLIT/s0wsmGQiZkackz2MS9kwqO9+kkU0McIpUwK6nBd
         LdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742808252; x=1743413052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6YiPFHtVVCD1GlwrwHfTYc90+3I8KRnjgLcn6s+bxU=;
        b=pY+wtCSsZbFyVqcbJSiMFeUfSp3bN4NB7rkKHtV7M/tetfcPvMi8Um4FELMpnQnyp4
         sjIUc+1Q4I7qLPX2yR3AQ6RN3C7p9/VMWAb+coOX8YyfB5Edl7a0mW5im9nL0OVlF+5N
         aLUZNEhVq7ji/DJqmo/mU6rKaMYGSOH/kkzw5pXgQlcnNanzmP7CFr7TFy1ypOXCXQw5
         WOeue2XOVIjlBHKtvCD12S+AsrPcWG2DfNXMrKEqtjBtWXdV0SyDfLPkWYajfkNaXggg
         GBoBjWzqZwJ0STHPW0CBQp6iNm1jrD8tLGJ1firBFKC8GSTQixUEUh5nJ6uAkWVtjccU
         O5ug==
X-Gm-Message-State: AOJu0YzL/yJDye2Rx4877+BwaCnV2f0Vd1RN372QCYDkgSqGUSKlaVW+
	mf3rlj1VXiEXGy3YB56fJAr71Nm3ZDX2EhF4RKfIuBVDbIpc70Lbu4TAm4rx
X-Gm-Gg: ASbGncs66KmupYy3No+6opJGQLegBo3DoEd8Y1f5/FAiQ7Ytywj1TMTGVkS4mAV1f/S
	NoAJJuFr7NFby4n3yoW7AequrtPgAOs5J2b1PhHLndkhNaCqDjZ7ACZTJmm7mjLLo869s95nzJo
	mk7OYya3TCIinyAgrDC1+fhONPRtrpPIoxgQlgwDjgY99aZnzUCsv6nstpZaqAjzJHWLDiaq/bN
	m86pAaJf5brCdwjh33Dndev+0EuKGCYTE4aqBKHrWteTQNOLgxz4VvXdjxQSP8dUMVVy7hyx1p4
	vDw1GpoyHPLRbIUlWiHzpBqrD+OJSo0j1WOCrIw5wDI=
X-Google-Smtp-Source: AGHT+IEnHnLjtpk2tQptGx4Bn/5FhBHZ279C1361FsPtyRYL/JZ15vvFhHIo2x7sMTzraMgbSgXPyA==
X-Received: by 2002:a05:6000:1aca:b0:391:47a7:299c with SMTP id ffacd0b85a97d-3997f94de39mr11214561f8f.40.1742808251797;
        Mon, 24 Mar 2025 02:24:11 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c7fsm10537250f8f.34.2025.03.24.02.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 02:24:11 -0700 (PDT)
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org
Subject: [PATCH v2 1/2] m68k: amiga_defconfig: enable PATA_CSWARP
Date: Mon, 24 Mar 2025 10:24:08 +0100
Message-Id: <20250324092409.99430-2-p.pisati@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324092409.99430-1-p.pisati@gmail.com>
References: <20250324092409.99430-1-p.pisati@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paolo Pisati <p.pisati@gmail.com>
---
 arch/m68k/configs/amiga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index c705247e7b5b..feed92c95394 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -334,6 +334,7 @@ CONFIG_ATA=y
 # CONFIG_ATA_VERBOSE_ERROR is not set
 # CONFIG_ATA_BMDMA is not set
 CONFIG_PATA_GAYLE=y
+CONFIG_PATA_CSWARP=y
 CONFIG_PATA_BUDDHA=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=m
-- 
2.34.1

