Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048818;
	b=iERvQPf7I4Xhi1NQdKcpfCDP3byti0kh03hzkTVt4SU6BfXSd7ZNN7K9rV8c8weVDpkk
	 3S/rYXw8dEsgpIPV4p87+yyE6NxcpaUMs0VxUihLpm0zkp20hppwnc7Rd7hZBEwkP4nRX
	 mP+An1L7fgprvrd8DRpzKs5juTarJYBmSGmEuC9aydrX+meR4k4U2kjfCruwMZhBCs4Kt
	 TX4Ymvi7f30OaLIuY/31TWrObq6iYefUuWe6+mqX6Fs6UrpwQb9zpO9eNRRiOx3m0M9U4
	 M/sBdraL8R23nvkc1yoEtVPSvexBZSZ1LZgS2derOqTnjGonmNOQs1tSsvEzchAW/Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
	b=rvEM8iTwyw610bn+NJspnpmHfAkyHhFUHG+LxhdPxr89gqH8/rDcbdplMk+n+ppAYDtC
	 pxrAPGjscR9wpx8IHPF3ZfAFSONfg9ibaUwI3QnmUhQJcTQh6mVpq6HL0nsZiASMiNR5I
	 1GWJr41MYRgpb3Ve1h7GjUVPQLjPCZzzSAYO/LrmKx8zHMjWi7NyGop4rx3VlNBfuTra2
	 t4VgzdG9L2v3fIDMTRBgIGKhrrg5xUQ6sx55KeUzcxBZ/t1idfaSjs+djvKpOsiFse0L/
	 9X379jQkOx+nzaysdOpP7d8OfymtVI1Cpi0Q8VU+PT+wZztF+hs8zg2acW5Ii73Ihpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBQznKcF;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25454606D807
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 10:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25454606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBQznKcF
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso14014375e9.3
        for <linux-ide@vger.kernel.org>; Sat, 07 Nov 2026 02:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794048816; x=1794653616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
        b=yBQznKcFH1qW2p5hPPNyh8Ph+Y1MExnF4KNZYxHzWNa9DWZlgo7aWr9EktqX59K3Zk
         m8eagAnh96qTyut5zTrfKX9PtxagT3C/xz4nGUdTBt1SsV+RtL3WiQNQ3OVAwtSzB7p8
         ZoVA0zkmzDzNzqMNJTGZIwO/fNW7cwo/jfNXagnToyZt3dyBH5fQ3fMqekGPJZaM1ZSV
         DwbB8HQozKv5+HeSwbRsoAVi6lwh6MS7n1psEHAn/tqCmGM+TKE1k1J6l9/uZHFCCZ28
         wICCkzqAh1rGQogdAjy3kqcyoVOVJkt6rtxruUrvFwoFMcyx6AJzXhYl0SgohnNCjnzh
         kHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794048816; x=1794653616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k93Uquzi2gmvL8btLkqz1m+7uDv12qNerGrKi9jXuw8=;
        b=O5/HhJsMSqa1miUYOAV0fnW5pHIdjUUPW2GpHtb6VLObcLvkQ00isTyPcbzJu1L2aV
         GKeorAl57DjMsT2PCcdadOZyPIj5lwKXglqNMG8umiFxDhmVpWJpEfL1I7fUuucrPjry
         FWxziFyjN6bNqP1OvrfpHl3EbThjoGlV5loRp4f8rDAZW8mWuBFIO6KRoBOFTA+DnjiE
         J3k2vfNQUpPB4KWCKg6dpT9J/tXTcHsXJjNPU9zVpSf7+YfTGEsrRw3kVTXxvIp3cGJN
         lN0Hn5fiXGWm7KEhexPMhNscW/sNp4V8cqbgG3x4uJvAYEC/JcSr4CM52bn1Yw1nDoQj
         RhkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzH5rxPO7zg5vktmj0ZwSuhYGNL1yf2fYn4b2USxPWm6NwoRwVk0e7l3/fUlANzWgfkl/0zTnRlFOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/3CbpnrWz7B1JF0sxCPev3qO2NabsYPcM5FLK6SU7QWOZ8JJMK
	5SeWwGszBsDJm4TJey4LYBiWQroA5lydis/gIEc9Jqu8wr06o6fUyQxO
X-Gm-Gg: AYBFou1RYHICU28hBLtav1OqHafXQI85YrjJD0NugWhwP0LGIEHXX1+bY+2kgSFWk93
	oRKGm4aDNp8Vx1JLS8kVsdb7YSoshKARL6zos3FUXCe+Z3BR3cSrmUi1gWkRAYf5LnajmUPxToo
	p15mjh4ygF3mIXnAUMGVBO3amQfnkT8UeptRSzWmvhn0TcnLxAjmcc4n2iMFycfDTTyHfklnJCJ
	vrKc9YFWaqgCfi2ISKZABTbN/UlZPS/ttnYDGSeSWAE6t6vp1VscUKALq8lNDU5Dv2D1P8ESoSV
	wDJHan1tptRDNAiH8h7auXRRxKBuX2LZ2r6LilmWfUszIsN5gle/ZxfJZTeGsnmPQsAkSVEAVUd
	C/wqW0QCAWxR0t2e8AOI8CIlMjmZGE43kobZxZYuN7CnZDbORfUqzzu3N5lwpbt1/izTky1Q9uM
	R7z84rs10QF7uTkiRHOMf+ikTTILtqYNon+I6+PoVyPtecBlGjMQm2ejTgyz0H/KotuXeZd3oYl
	+ALemFIXYBTKiX4wCGYfGBo0UQWrVyClQKQhJKTE2EtEZpaKfe8Am/ES52bqSpa1h6Zrh6gPvhI
	6MTX6td9H8FJHzBhPP5o6ggyPx34fOqlz02GxPVRmdbj8S9OJxddMG0tfowijRuEY/ossYuPTRv
	jg4It32+pX6eOKRe7ZgEfwQNdJXbw36BkgCCIZ6DQLnVmj6ClZrHd+4W0yIJ08DfzQPv2D3MAcB
	71Vn/NhdQycA==
X-Received: by 2002:a05:600c:1914:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4b6de788f5bmr87694475e9.11.1794048816330;
        Sat, 07 Nov 2026 02:53:36 -0800 (PST)
Received: from PC-Marco.lan ([151.59.49.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b8af10dd35sm42291335e9.4.2026.11.07.02.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:53:35 -0800 (PST)
From: Marco Ziliani <rylos78@gmail.com>
To: Kyrylo Biryuk <illofspeed@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Sat,  7 Nov 2026 11:53:33 +0100
Message-ID: <20261107105333.19934-1-rylos78@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107081335.3360920-1-illofspeed@gmail.com>
References: <20261107081335.3360920-1-illofspeed@gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kyrylo,

On Sat, Nov 07, 2026 at 09:13:35AM +0100, Kyrylo Biryuk wrote:
>                                     softreset  reset failed,  last disk
>                                     failed     giving up      attached
>   7.4-rc1, no libata.force          60         12             197 s
>   7.4-rc1, libata.force=N.05:norst   0          0              70 s
>   7.4-rc1 + this patch, no force     0          0              11 s

Thanks a lot for testing, and on a second unit with a different setup.

The norst row shows that the commit message is too strong where it
says libata.force cannot work around the problem: norst on port 5
removes the retry loop, but the last disk still comes up about a
minute later than with the patch. Niklas, Damien, I can send a v2
that says so, or you can reword that sentence when applying, as you
prefer.

Marco
