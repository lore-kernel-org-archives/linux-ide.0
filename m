Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F22628A41A;
	Wed, 23 Apr 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428916; cv=none; b=Sa5N0jORnF7Pyjc0osZqbEqgdW14jOQrvzI6JC7kIezX/dvS8klqFZtJACuArku7XwzXFyfMhrdPNOvjKweHHusapHBOJ+312nYsJDHKQzyJdFmZBJgM7Z/o4A05mAx5vbladKDMh0hc0j+QvgStpJyMJaC3UOfsXLAKvRsyk0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428916; c=relaxed/simple;
	bh=l5lmUxZlXKeEMvSSY7QOBtWKjRhEbQz7PwzMfpBMypg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=DllRCMZXQ2uySgcZq95OO+anzBffALgu7WzYvaIGXWW3sSkKfmuH9iJTNkVYTvURbuKZbKixv1JLnh0FBb31IcL5LaN7Q1yTewiznd93BBHnzie76ZL7U9pGJqackg+d2IuUG6++y9CPoJSE+5OjDtXvJa3SyG9V7dXZpewFxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHp+x/CW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHp+x/CW"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fece18b3c8so1752537b3.3;
        Wed, 23 Apr 2025 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745428913; x=1746033713; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iXmo9vqVmeQa+sOqnfl+nEXQq3jE+5ZxEp0WETjKE8k=;
        b=MHp+x/CWyodAKIHNd4AFtB/4SZQH5m5gj8T70jhyjhk9k7YBthLQ84MIQqu1Z86rl9
         5/iKwtVLWvKtrBN4Srwf28pSrDBDeAjs/8trgPpTT3oI/6ucv+oZ6MqPfgf2WTXa0WbK
         txKsZF4YBTRBsbuu70RNhGsR0oOE2MbciLovas+20K+q0nKXuI/LE1AABkeGxBGxr9Z1
         QxI0oOB2b0SvzIaXfJ3Z/o7xVDm6cXUTbjlHEli0peNzl0atHzyMcbYp+yzc/4lOu4nP
         GpSw44zbM1apdSrXoNYz8TflgPcCt9Z+ES152c18gh3XGgq9rjwSI7W3O2b+9wQsX41J
         OIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428913; x=1746033713;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXmo9vqVmeQa+sOqnfl+nEXQq3jE+5ZxEp0WETjKE8k=;
        b=uQL/NIoPqgIkTz6FRvlX09Wb1XUJouG3o6oE2X5mKIe3mGj3mAmhXIm2YA7xuj8PBb
         NuA0wkuPfsSu3ycz/sv1Ikug4LltPy3iDYihC8vxzJ0pkGnuZF7xm0a3lKXvVMZtUnXz
         MIVV+t+r8h6EHM+LAPJxQn0AKogafOzluw0w2www5QLUXsAkgGGCuyNmMf+UftdTfih+
         mDBNpaMxFydzlAOehsU1W+pCAiLdTtys7hpSeSy68bR33/z0tnO097nnGPTwTQqBNO0z
         2awNWRtVAhO0IZrsHa5p8vxYwHDUGE2VX8n0fidrN3yLfawcx+EsnGUMBer4HQXGaqAP
         T+ig==
X-Forwarded-Encrypted: i=1; AJvYcCV2t8WVWjUELVI47HdN9OtZkrFwl9Sx9COyI/pHxngZcvlXYwbbUji67DD5Nxc0EmOD/FxiHVGah3w=@vger.kernel.org, AJvYcCXaZZUu0mb+2pJJoV+gGb78xks8kUD6gB/qszVYXo0zln5ZEUJtP0Dgs4vVakZHHiSNa2RFD8v+hybQVXh0@vger.kernel.org
X-Gm-Message-State: AOJu0YzF7bNJ7F3do1l7rQp/+KRex0UZcf7QKFQbZ/qylIkPtx6TJXgu
	X+e6Hchrh/Kz1iDBzQjZpQhRtkHRcBJda4RkDXfvsn7aJZz4+GuwqtCFBuhZa3J6Za39v1wSoSY
	ETFI8cX1+FlJaz+dnwN+u/IOA6WcL+48Y
X-Gm-Gg: ASbGncuwBi/ekePql16tugupV3EX9rol+C1aG6HNA6lynt07idD9IFlVKfm0qJrk320
	6nFJmnabQh1ZXdaOR2VL9ube28GNnXgf3TySt8HqNsdZsfHtBMFXgdusKFXo7hUt/X2sSZi+MHv
	ZIGBvtrAaWNHkDxebJjUzT1NGyhxg7G1yflA==
X-Google-Smtp-Source: AGHT+IHkg5bg/cDpn+6i3xpfjJEeqIIA2ijyuofxJlhHpzBtnGsqNOzfP1dSpIO8F4YZ+GpZrc0RI14s+zA4z8hyjag=
X-Received: by 2002:a05:690c:6ac7:b0:706:cc6b:8547 with SMTP id
 00721157ae682-706ccda139fmr309054537b3.25.1745428913412; Wed, 23 Apr 2025
 10:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Wed, 23 Apr 2025 20:21:17 +0300
X-Gm-Features: ATxdqUEGtPpMXAUqNASrwXMaNWzw-7OEkZtV2XSi-wR5Sb0YmnYuePFOVKgt7h8
Message-ID: <CAAZ0mTfQ+feHUeRjC3aH9z=sM92XmXASY+3ELzwXJLfk30h_6A@mail.gmail.com>
Subject: [PATCH] libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drive
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make WDC WD20EFAX-68FB5N0 hard drive work again
after regression in 6.9.0 when LPM was enabled,
so disable it for this model.

Signed-off-by: Mikko Korhonen <mjkorhon@gmail.com>

diff -u linux-6.14.3/drivers/ata/libata-core.c
linux-6.14.3-mk/drivers/ata/libata-core.c
--- linux-6.14.3/drivers/ata/libata-core.c      2025-04-20
11:23:22.000000000 +0300
+++ linux-6.14.3-mk/drivers/ata/libata-core.c   2025-04-22
16:53:52.341934384 +0300
@@ -4238,6 +4238,11 @@
       { "WDC WD2500JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
       { "WDC WD3000JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
       { "WDC WD3200JD-*",             NULL,   ATA_QUIRK_WD_BROKEN_LPM },
+
+       /*
+        * This specific WD SATA-3 model has problems with LPM.
+        */
+       { "WDC WD20EFAX-68FB5N0",       NULL,   ATA_QUIRK_NOLPM },

       /*
        * This sata dom device goes on a walkabout when the ATA_LOG_DIRECTORY
