Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCE3AF670
	for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133382; cv=none; b=NoUZrd8FQzUTfZnvGpu3d2ZuxM9gAAssQurihSMsCQRDSEjCio3hJVuG0Xqd7PD1tCANNGQ6bNqPzzYLlR6lupvbjdzBAYq175cefzvp9UD58Lc+QtDtVlosynOPy9U9OsfrRLnkksZ9xtN/TP+AXUJyYgHJnyQSsJ3j+9VYHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133382; c=relaxed/simple;
	bh=/S/QI1XHdHqF+2r+ChB1gCQA2E/qjUSnr5ewJwFi7QY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jxZzCM9fSQRW8aQUQTHjK523E0IXt74e89nMgZgUwjB2BZkhL36D9a8SIoa7yZfgWB185oer8Vg/qkFRcryZj9GcldSLFWUVR65A1o+ltG5C20gI5Gr52dS5D0mJuUV8Y68hHAaAZRmcQIK0sTjlGJ9kAdYyobc3EXcyVIEnFlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huYgY/n3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huYgY/n3"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso30080295e9.2
        for <linux-ide@vger.kernel.org>; Mon, 22 Jun 2026 06:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133379; x=1782738179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY8jUB8cUIc6YSwipFGKRU7e5xXhrfeJ0x4AmQghXf4=;
        b=huYgY/n3njTr8njT/6TZ2ll8HxSmvZ1ZnjACCLLI7imrWuNzYYjdR0iw6u6I+kPRIe
         IaoOUH71YWCUY6eRoTtnXQf6zBmNaxQ+1Ww6UM2FcKvHgWZDOlSKE1NAvs2JUHl8nFtL
         2+nFgODIvP53g5w5RC5O5Cp3bMU9XGM4hqHqNN6lFnnV3lhXJD3YRaAHVURXgiW/cyDz
         5eZU8FcSBu7uJsC+CtL+wusfayJPn9TvcrWROsB8yyh9PB7TjDJNv46phnR3tiQIpwAX
         kYh4GiQH4ifNhKEv0z0dHWmKKrTHNKIklNq8tB/kgKbRZMcq24qv7eTbXCL5ySzaAsaM
         UcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133379; x=1782738179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MY8jUB8cUIc6YSwipFGKRU7e5xXhrfeJ0x4AmQghXf4=;
        b=DfMH1B4vEraBG0k8IYDoMNs0pi5lsJzeR/f2beO7DjYCqwUf4yIFSftXYj2ERrEpXN
         suC5h4hfNoDbDf9ieeg56KAAgciuA89RbwtogdynXiFjHYCm9mSyzBFBE1TkTOlhI2VN
         ha+R+tZAw0RGVD+xPSjtGPg6a4HRSr2/VtChUbcuELZ/WHBd4vLNQ8w0L0TAgNW1IUem
         tieZHWrhKKvAeWXd/i/w83mMs1aTWS0Hn5+Nio+Skk3R+JjJqEHSzYGkQp+cW+ZCkmjO
         6V0zqR7E/ThaQDVqK55/nB5vUbwzAJZxDNiKvKfkbv4k+wIDU0FI2M3TDvoC74lj+yHG
         oPiA==
X-Forwarded-Encrypted: i=1; AFNElJ++yX8r/OUrgu0oF3fhjzgDSlg1K5YKqQ7J7Bbd9qfSwCS9VK2VyJK/bW4US7+N0si6/cnePut8OEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSMBrEO+5AVvtW+h3Whyg8UwSQH2Ra2LtraMSADhtht3+pza4L
	wqCGKk3+b76pZSBYPlcj0DYsTBDBycg/OE08bXkAHjCohzDbCHkAlUZLNeaRtSP8
X-Gm-Gg: AfdE7cn/l32oMRHR1rkRxY/R+v+2P3yh9uZ8DFul0vQ7Vl1B0JlaoYS0Fz87Kud72XV
	TbQHotp7vD+scNEcpxanCE91kAzet1zgBYvbrejyJLrlnwi2NxJua4CEyhu4K7NatMrnT9+0Umq
	IyT4bKsuo9UZqsAO5KscK+/KddYCDgw9dcpOCWpa+MODr9D7EBs/NI/7KrOTi+9Y5XznCv6Vp1G
	u0LErQH93T9pvbOf9pY1+k9zhm67C1CEtngYtSbxoHgShJmTTuPw215tSMYen08pFIpy5Biu9w2
	+uvMx8riNOXdxUyuqD6MzO9Tszj9MEr0XsOyLrFlAttNoae5oTeB5wnvD1qY6uv/s8GTPfNrH81
	qWm1982mv2z5e/9Oy23rok56b4e9SVQ5kVsZWgTXyDdvnCAF4tvmAnui77sLvpg8rpgeMNhtt/9
	bBWraY6FvlSk6Zc0/gOpwVLefqC/f1eP3auZeCXzHQAmzxY0pbdQ==
X-Received: by 2002:a05:600c:48a2:b0:490:bd1d:472a with SMTP id 5b1f17b1804b1-49240e4473dmr152945135e9.15.1782133378887;
        Mon, 22 Jun 2026 06:02:58 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fc47720sm497063795e9.0.2026.06.22.06.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:02:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:02:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Alvin Lim <alvinwylim@gmail.com>, linux-ide@vger.kernel.org, Niklas
 Cassel <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] ata: ahci: force 32-bit DMA for ASMedia ASM1166
Message-ID: <20260622140257.113f2275@pumpkin>
In-Reply-To: <8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
References: <20260621100844.1224301-1-alvinwylim@gmail.com>
	<8c681e59-30aa-4a66-a5cd-9cccf8e338ff@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 20:31:54 +0900
Damien Le Moal <dlemoal@kernel.org> wrote:

> On 6/21/26 19:08, Alvin Lim wrote:
> > The ASMedia ASM1166 SATA controller (1b21:1166) advertises 64-bit DMA
> > support (AHCI CAP.S64A), but on systems with the IOMMU enabled - where it
> > can be handed DMA addresses above 4 GB - it silently corrupts data in
> > transit. Reads return different, wrong data on each access. SMART is clean,
> > there are no SATA link resets and no MCE is raised, so the corruption is
> > invisible until it surfaces as filesystem metadata errors (XFS EUCLEAN)
> > or, on Ceph, mass scrub errors across multiple independent filesystems at
> > once - i.e. host-level, not filesystem-level.
> > 
> > This is the same failure mode already quirked for other controllers that
> > falsely claim working 64-bit DMA. See commit 105c42566a55 ("ata: ahci:
> > force 32-bit DMA for JMicron JMB582/JMB585") and commit 20730e9b2778
> > ("ahci: add 43-bit DMA address quirk for ASMedia ASM1061 controllers").
> > The ASM1166 currently maps to plain board_ahci with no DMA limit.  
> 
> Have you tried the same quirk, limiting DMA to 43-bits ? It is very likely that
> this adapter bug is the same as the 1061.
> 

It would also be worth checking that you get the read fails with a 44-bit mask.

I'd guess it also requires that you keep the controller busy for (about) 8TB
of reads - which is where sequential address allocation would exceed 43-bits.
But that is just conjecture since I've not looked at the iommu code.

	David
