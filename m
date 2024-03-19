Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7C51C28
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840672; cv=none; b=jSE04H7oYHmJrGH3g3vSp8/JEcBkMeofrmJJjb1pozFenrQjLQtPIWwfJkLJDPf52tHgVestEBAHWYOJsUbSAO2zftui/SWXwUg87o99Sb981M5I1Abt0vC2uGGI7NJbqmIzUhI+7hLql0DM5vc4iVuleen1SfIAnbMqHdYLQ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840672; c=relaxed/simple;
	bh=TLXx0nQNa/Rp2Km6zWi3UKcI70bXyhB1ZGBgHF3rOFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r/VAQjVrYjuU8aTRrY1MGQRKTka4/BTYyUZeSiBbxSBI7yYP8TFuL71jAjiCw4hH28pM4e2BrnLlwfo2+RLEkKbjlyvIxGRbGaO6Gplc16CHPG693hxqkC9guE0RcEzNQeq32lKL/BxTZ62ZuVVmgsjjJFW3NI7zcP3yIOVBfWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCLTg3qF; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCLTg3qF"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c3775ce48fso2743523b6e.2
        for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710840669; x=1711445469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=eCLTg3qFpC2kVWnIgUV1T/16eBHqTZTageAlnErhfsKeQdpwg1+pVjH2GqdmUx4/nB
         +NiPx2g1SEkGMlKCpigxLsth0x1U9lIU6VfrKFR7+giIzUadAsYKvD+TsLK3Qxo9ZVpK
         iMoyrQXqAFlknHBZ9KgFA76JGbIFyhnTAZYHEdWLnbYN54rj/2X+vSqSBRDnLq0cZn7d
         eNzFsmFnPaD6s/U3vX8vJtrYkbbXwV194F/axVzqcJRIqZzJJBC77w9dXecDcPcVV08J
         opIXJJ1txjpjGWCDrm5mTXeou64+N4MvxZFBEHmk+1CCMvjlc5MyEC326eDC1zZ8PCjr
         j+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710840669; x=1711445469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=kWIDdMGiSxB+1KSXkY81+LVigaxtZEvayy5eSatKAb9p3vQAS/ZTK4awrSv8xUd8eG
         0RmN03WxihWyFvyhZ2Ph39X0eqrvprzaY2cyj+8gU8tsFCkgxe0OiqvZ7f0fvsCeEGne
         E2lrn2jhApbNZxnx7545A4G1Kwj3+aNSpzhTTKGlWw18WptwXV12ZUnwaaBWFt+nuklG
         A3iGecw5WROuvqa7Mm2zqNlnlK2MBkMBMAz4+W7HhsYcCHou/RfXIiRUKuZXhHKXsABx
         eLo2KjmL+oQaWN+ksAWq0gNzAypwolZ6YvEqw/5JVCBiv7oOeFCsennNhSF1IdqpbWD6
         jXPw==
X-Forwarded-Encrypted: i=1; AJvYcCUidcl4rUDee/87BJCauxa9nKNKtBeVlYw+mXgZ6VIV+1tit34sSFho883Wtw9DNj8VX6ivDmSI4MME7AOKn3n0MxhbG5i1lzt4
X-Gm-Message-State: AOJu0Yxc+tBnuZR9nSwnkeIENoo1U0OSmd64nCjT8VJsZVJ9xJNLyINm
	4aF01eGhhKmXUlt4+MT9tcX+PpLQEN3HKQ8sOVQWZ+cOkactSh0W
X-Google-Smtp-Source: AGHT+IFevDI3xzPaKtoLyaBQ7m0ZH/xaAVzHj8H8YYp/SeBoMipL2uYKrRHz8muYIwcz2QEUhSPkDQ==
X-Received: by 2002:a05:6808:1145:b0:3c3:83dc:d711 with SMTP id u5-20020a056808114500b003c383dcd711mr8994775oiu.57.1710840669446;
        Tue, 19 Mar 2024 02:31:09 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e5a915a9e7sm9655462pfn.10.2024.03.19.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:31:09 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: cassel@kernel.org
Cc: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	Jesse1_Chang@asmedia.com.tw,
	Richard_Hsu@asmedia.com.tw,
	Chloe_Chen@asmedia.com.tw,
	conikost@gentoo.org,
	cryptearth@googlemail.com,
	temnota.am@gmail.com,
	hdegoede@redhat.com,
	jnyb.de@gmail.com
Subject: Re: ASMedia PMP inquiry
Date: Tue, 19 Mar 2024 17:28:48 +0800
Message-Id: <20240319092848.11479-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---

On 3/18/24 19:32, Niklas Cassel wrote:
> A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
> We need to be able to read the PMP device and vendor ID, in order to apply
> the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
> that is connected is bad, not only because it violates the specs, but also
> because it stops us from providing the proper quirks for the connected PMP.
> 
> Could you please tell us how we can communicate with the PMPs directly?
> (Regardless if they are external PMPs or PMPs embedded on the PCIe card.)
> 
Hello Niklas,

Unfortunately, our design does not provide interface to communicate with
the PMPs directly.
When ASM1064 plugging in an external PMP, we will hide the PMP and map to 
the virtual port to run.

Thanks.
Chloe

> 
> Kind regards,
> Niklas
