Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F270A7D096
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841321; cv=none; b=jNfpl9XEIy9RC+WgPkWctu3fk6eZj68hB2dS+yJGmeiEw/W944gzaktDkKk+Ze9iROanDLexEVHoPoKkUCZG7pKOV8oiCdcDk7AQ822WTP9otQ35EEahRaxb5RAdBIU2qvXRRfjf4QLi56N6hor0aO9MdCeTFBNVrM+Nh8G99rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841321; c=relaxed/simple;
	bh=TLXx0nQNa/Rp2Km6zWi3UKcI70bXyhB1ZGBgHF3rOFc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dUJpOO+nUeWaUPZCuZjwwdhAdi69ctERc1HfqmfcQ3fWF4fdq0A+XsJEE4iOUu2KtuBtzfWV11OGto1DedPVfY0nF7nLEsNNwgUgzH5qOQG3JdHXaOqWO9uERt9eQnxvRI2e2cVpBJN0zFZl+TC0iS44KwUYl1z5jAtoOXcmXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVo6wfqB; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVo6wfqB"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3c36f882372so3176880b6e.2
        for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 02:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841319; x=1711446119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=DVo6wfqBBIQIMm+vRH4EDP1d6qaxWkk4tVOCQocQFU+l6s+8mHBOQ8KBXVycwNvH3S
         H/ok5lGLe8YKaSiCCV8hSgcZ3TqdmCKB+FdDbKcYyzIx4TtN+Cv3QAC6O0aBiq9uo0Gf
         BAMtY4ospkPMYorLLDCSGvythxX5X6TvxMHTMLV8MNxfcmUzcH9El5g0y171tPyl/iu4
         O9spNogfqmxCT4iRzYmGMhGd3wnHqvmOnlt0LXGrRcXxizd575riHrGT9TChGFd16UAA
         0Tw9A1r50RA0+br6daDLDH0N9uzd8xGUeQs0bwC9wO+r9C23WgRcJGs3YMBA288M89M+
         8GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841319; x=1711446119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3z3iI93qBagbVpFS+nQVWFhk8lqhYuUQU2GvQfQzsY=;
        b=krBSUqUqpql7uwi0u9FqugqQe15hQ75Fts0OQWvBMlVdBaVo7PRRdCqb9aLxfNItmG
         C/te3TG1TPL9Xfhs1YLQLAMi6MGiEgoGlH3z5NeUT51a0MTaOo1uARGLB3a+5IZ94uT2
         IjcX5EyZIjFE/dQ8IoPZKj5Ck/FCRc7DQD9TaJRBAlR1PxP03jVS8Zp42AWjZg84JNFk
         RkrISh1gK3v4hS4dRLVtFdorB3ZQlC3P3LWco5xgcOvidCPD+MpG5qc7pcjfC+wsL4i7
         ewZKfDWTFhdVQyApdqtctFZDX2iP76ScZU0oco3T2KKzc70fCZAEUCTgfvqoSPcvHhwK
         yVkw==
X-Forwarded-Encrypted: i=1; AJvYcCWTWUL2eU8nYmgBaVa9pRg7HELuU/OQcMeiRSM2fHcS+zAzXHJnc05fXsydBZdznm8FsnETo+JzTh8aYqxQtqpHcqR6B5fVtNuA
X-Gm-Message-State: AOJu0YxZyoqDgUEkJHO9vp49HDA5QxlTkBIfi9CLTBY3znhn1UNZV95G
	AMKvVZK6zJlzep7tueIQXHUD4QlOOzXzy+MPYZj7ybKMi65rGjA1
X-Google-Smtp-Source: AGHT+IGWUezXfZC5xB+shMaV6PxZgtghAAZgWcPwOCKFHMlskUYF+D0LsAz/vrh6BZ083ZgC9pyzsA==
X-Received: by 2002:a05:6808:280d:b0:3c2:2f9a:5aab with SMTP id et13-20020a056808280d00b003c22f9a5aabmr1842922oib.56.1710841319141;
        Tue, 19 Mar 2024 02:41:59 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id u18-20020a63ef12000000b005e83f3040fasm4336033pgh.24.2024.03.19.02.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:41:58 -0700 (PDT)
From: Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To: cassel@kernel.org,
	dlemoal@kernel.org,
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
Date: Tue, 19 Mar 2024 17:41:44 +0800
Message-Id: <20240319094144.11946-1-Chloe_Chen@asmedia.com.tw>
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
