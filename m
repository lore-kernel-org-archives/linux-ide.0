Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17035DA42
	for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2026 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791743491; cv=none; b=k/HwwwP0OSxs+13dTV53OX6i9qnUP1/9SIbzQIHWZwcE+Dg7+qDaz460rWw70Bxtu/7PX3D6GS9L6pTJyOJRSnAbNE33hyX7GozJTtKQLXKfiy1M+3GV3UmO/oGi5Q7UCXfUKYL8lqsnQUHkmVDHbGqMRKTTAGhWdBwgoTsgn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791743491; c=relaxed/simple;
	bh=qhTz5OXbSUDAJ4e9N0LFC8LqDDii9uCxNuOIii6UFuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQf0R5TmruokuCqCG3kMvWqfvPU0Qxi/pwcrB+kjWbKfuwOQ2tdZGwWVlSb1vFTsH9+xFZ272jpPSlcMrfAY/1i3i+g2/d4HtaT4+8lVd3Iiyl278J6J/4AkUuHUBRq8DCKzTwkVe8jDq4bm3zH9bxXyr4OB93wiSqp4gEOdwWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLRENY6a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLRENY6a"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso7757935e9.0
        for <linux-ide@vger.kernel.org>; Sun, 11 Oct 2026 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791743488; x=1792348288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qhTz5OXbSUDAJ4e9N0LFC8LqDDii9uCxNuOIii6UFuA=;
        b=cLRENY6aPKuaK/kV5pOd5qEkaSMve7bOy/8ptyU0+ZG0kiCXwB47jip4lOpFnK/RPb
         72g3FDUrRvezABOgBzXPSsiBWp/JhG2yjLaIdfp6b4fKBtbv74jcvpBMAXyOuiuPcNDu
         v9vZXTkumaqOsvx2cll73qbT6U7xMlhEbdqDYxYDMl8zyja8qkVAZKfPTdpZm/q1AB6e
         lwA+XhyLDYD31ItiDV2WNeA4a8UZzrzURirYWOQGqXhUR6EW90y6w3NlV9s9sQ8FiGAK
         5zo/TdeHe3dR4gWJBTBWD1hCbX9VgRdEo00OnkKKKyEcKTbERgKIcVfd/CoDh0pEUjuZ
         U45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791743488; x=1792348288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qhTz5OXbSUDAJ4e9N0LFC8LqDDii9uCxNuOIii6UFuA=;
        b=gTtRobPCQgwplc0s5Ee8xdMGFMQc2HeYLkAohOFLcXkdcGdq2z/nYEdsH2PmgRaMwG
         dzAEPkgYxrjKDXMrW5x0uGAY9R+DnskCQIL/v1rteSATEzo0xAHJ4MxyMJze2Y7ALQkY
         6hh0N2O/KsePs4HJZkjeWIEGE43VvjnLnEYEpS4/ry+XGXfHuImMPs02cdqgmo938fDC
         sOKORjUJVOVOPim1ciOIu/AXt8QSAep3t97fBanTmv9gEGrcAtv4Z6IrLOzNSX+ryq5O
         q2X0DqPps1tHrNp8/0MWDEpj4lLDQpk1WkoIwAo8gDtSORgKFMa+dHSUrHG/CFbSFq6G
         7yhw==
X-Gm-Message-State: AFq9FYJbn0ZzMu8YIkVffwQ82Uhr/Ba5PC6Bl1lHch5QrpfmT4ySMqnG
	a4/L7NOOwX4Ip5iGCzCXjPvLdVYUjj8Pyoo9IgbY+t+mfiI1VRZKaRrJPd9uOHRJkaI=
X-Gm-Gg: AYBFou0C2CyW3b8aEShvXXIa9ONt44qsB2qFoMrz01MehSuWrVnMODCLhk2LWlDENzZ
	zqpW7K6o4xl7yZNpYsOJd+5HiGYYiEIxEP852r5VnX/9/tXJTny3+0t7PucfWGQ0frLoyrDhB+X
	6Mvtv6flQko/lm1Q8oy27C8ljsShnJSsZI8QAEN3Rjj3uCLs2qrKZkeX+mNN6HkImQ6PRqY9vyY
	wqYD8alskjsICWgp9QaFWS0/YZ6h8UfzTrpVzSW2TZ2CW66/cDcCTmc0+xcLOPPWTv0Nqr36EyG
	vfR7Tj/Z08ccpGL1/z840/7w/8bsPkDxO1axz+6Lal0bDL/npY89risQsqFciJ/fEivF02JxRQg
	HPsRy/GQllKKVZN3SuN09CGDt0MWmUoVnmSy1wexCuDoPPP0lknGIt6NPmFVK9S6t0zVe+xDus9
	16MR4+YYXWpOxGuovK1ylLFah8bBQ/3RwSIWdATj5+nZ7T4cwdsHYOoAtu7z8ZtnZA8yTpCuHfk
	X1bEA4XTsSBxCWG8P3CDrzjhlgnUE/v32CvLgQQM9fonKU=
X-Received: by 2002:a05:600c:4fc1:b0:49d:2536:402e with SMTP id 5b1f17b1804b1-4a19a9cf1e6mr31519075e9.30.1791743487757;
        Sun, 11 Oct 2026 11:31:27 -0700 (PDT)
Received: from localhost.localdomain (87-205-122-125.dynamic.inetia.pl. [87.205.122.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db98c2800sm15253614f8f.26.2026.10.11.11.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 11:31:27 -0700 (PDT)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: linux-ide@vger.kernel.org
Cc: dlemoal@kernel.org,
	cassel@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libahci: re-enable FBS after error handling on a port multiplier
Date: Sun, 11 Oct 2026 20:31:26 +0200
Message-ID: <20261011183126.389-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011180236.735-1-illofspeed@gmail.com>
References: <20261011180236.735-1-illofspeed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An automated review (Sashiko) of this patch pointed out that
ahci_enable_fbs() writes PxFBS.EN after hpriv->stop_engine(), which
clears PxCMD.ST but leaves PxCMD.FRE set, and asked whether that could
upset strict controllers.

For the record: this patch only adds a third caller of the existing
helper. ahci_pmp_attach() (every boot with a port multiplier, after
ahci_start_port() has enabled FIS reception) and ahci_do_softreset()
(after a successful fan-out softreset) already call ahci_enable_fbs()
with the port in the same state, so the patch does not change when or
how PxFBS.EN is written. If the helper should also stop FIS reception
around the write, that would be a separate change to ahci_enable_fbs()
and ahci_disable_fbs(); I am happy to look into it if the maintainers
think it is worth doing.

Tested on the 88SE9235 + 88SM9705 setup from the commit message: the
hot-plug now ends with "re-enabling FBS after error handling" and
"FBS is enabled", and parallel reads behind the multiplier scale again.
