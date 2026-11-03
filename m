Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743030;
	b=Y0ZSahKqpt9Pj/3LctaGMMNMAxkBpE4I9b181UIG1tPOXLavhfIjmbw0+PyzPpmkPHy1
	 Ef45BNNiA27A49IK2jghBtR3DyXQ59c4mHqOMyjbx1hh4Ym2w6q128kD/EcxLWzCtcEW+
	 pptl3ekdfR7KCtSlDqgKud2WdgCbzXLvwC8E9zh7UHJx/Dbgk3Fxh4ruNG79JVm1JzrPI
	 QuEvITMu3MlabYCiz0tANVB5rWVo7Henk7epSbObjknee3SDH6wWXPIvlMRXnigP4a/mx
	 9siHj+SJHF/E/nf4Xt81V/s4JorWyumfqNyW7Hkoxs3nfzbnd6PTUqI5l37L32BnRmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
	b=a1CG5GNwNtAQY2Wty/Xy+TRqwgpcQ/hozpNXTQvgDef+sorXm4Ld/664aknNvIVu/KxF
	 2UuSPBmauc5Mu2rpu60SxU5ivki2+GfgZlVrTcWpN1J9PH9YCB8E/DCUxDjJqs0wzhE0a
	 bPPNEK/xUNA5mY566tgkp+1tvXaf+p3ugdL/mFDPj+r/FBK+k6rfHJOVj96B3SkSmlARC
	 54tqpWy4euu9oz8cY14SVbd6Bna74cAj5vZ2ELyDbrKPr4Wlf3/8nrEDroX5lnFiYzXEX
	 HBGTvPjm23qoTSY6/xA9NV6TFpPv3AAhROpSsSoOD/C+o9bVuZeZ6skzhMNPtS/XklA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tubLW7bn;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E817606A31B
	for <linux-ide@vger.kernel.org>; Tue,  3 Nov 2026 21:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E817606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tubLW7bn
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c46bd7a7345so258839066b.0
        for <linux-ide@vger.kernel.org>; Tue, 03 Nov 2026 13:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793743028; x=1794347828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
        b=tubLW7bnYjfWqdPm2oGDw5PfxnGrX3czHSKi31HUXnFOcrxrOa6+OLs95+7frtrRyq
         GhtrNCDB/x8RvE+XHeqfkuxc4V2DejccpHCwOIrR65Bwf1Hy1URQ3Th/iEPrrcDS8M55
         iuUYRl5p0RoSaJ0W77WD6zp6+wYSAlO/NrTRlOpVjHhZUMBpfTzcgaQM/mn32v3R4EJP
         k7IBLQs1uXMTjduHml1DmTXVrptlDT6F3vYg3hdWTTgrjUqYnaafou2TRwUM8DdxUnkd
         5P7/Mw9VGFSDvM8FTs0dEpf4e79B0LF5V8yvbxNUa2DeLyXc7HFNXH/TwxDaQ6CU0NU4
         oSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793743028; x=1794347828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPYR7zTfRsNXlDBSGzOY2duMQ2hzSOH+insezsayCR4=;
        b=OkfzwwjOBA1yhvGmjyuc7Iff5PpynJyP8xAcggUMvmxvkrgI3nZRvI1xcuFdxY44sg
         qealrJpdLvQoMBGws52gNibkgtnENWS6YB4CMxhsqSEXwhvqaXmSe42Cw/evzWCRzDe4
         BtrwMM+KzJEIt8E1vxr5fFE893Qs4N8CY1vTG29aq5rVyDjfvpxtSapEXItw3BsI74mC
         HkYFC2trTfDloAwimHEQQRejLomukbBmUI0dwzCQitFeHmUZuwSKJaxjdESrXQakVXik
         WcBTmrVnjTB9FbBoOdfqhQVhQ0XBMJsrBu1Jv8ddnn+iNc1y9UdsuybfcagxL18vET/d
         lqBg==
X-Forwarded-Encrypted: i=1; AKwUvBxvvkFiMTwh1ETBe/XbccZrb2AKmFdwuKWRVHoJw6CLnar3hSfV6QCPefxPIFLzrJTUv8jw2AzJy4U=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+ViBAEjIfyrfEy8RqSAKWrj0Ue8HN8JqD4SvPIvCsrbm8KbYX
	X39g/S7X7ldCp6S0wabgAJyV4mAGfstViyPZJmHuoqmZ09kXpMb0dyDB
X-Gm-Gg: AYBFou3Wk19Whh/rPTaMofoXpTiPCIPDYn+xkRVZkQFA+FTeyZVcC/OldXQT5ZlfJ57
	RQMb7khW+kanhfZDL+E7Q3n+ndEBmxBtYAb42lNBjZBDTq/G0z4mwALSQ+WDClJ9P+Z4QDZ0O70
	BI8BRWKBWBhzizaXWf8fRvYgni6a4FnUIQ0/uoWjGulN/uK2rwnXWcaMTSjbZikCXITjmzqUx4O
	IPPHjll9xlXBjYNAI3Mw2Kr1g2+tWK6cJPj/J69hq6aDwUv+ARQWKCfE9ytBVi0luX7CFTRHOLL
	KEWggBS/1Jf1RbzN2OjH5qNwOQIsfBTO3/2+NYtg3evYTvLfIJYlQeDPEm0UnztWxHJ6A0D+/1t
	tvGuT2QJT76OnYrAqieLs1wanICMWEBeTpqh5uxX72hVrR+IkXA5dbc7ngY/VMbyvEQfU9IGLGA
	wejOSSJFLhhWZDHCFvcIyaRqB6YTJx9t0lU/jaSUmu2/iwpUUIpfDbCPhHK3pcHs4G6zPsCPGK9
	BTVBoFTAyU2ZBXa86z6tGGP0Zk80/lOASyh2W3o98hDU2QntrG5OlscuVjkOSm57Jp++N2d/9mW
	UWiacbB/B3gysf+FbgvZpiQZl0/9DfLpUzskrW40vC4CbVCGzA14AYQsQGMPUaXtzXfaSYTFV5t
	XtTFa3lTY6+eDaqWam5A8MP0=
X-Received: by 2002:a17:907:7247:b0:c46:7de7:e41d with SMTP id a640c23a62f3a-c49d13b3532mr1528577666b.18.1793743028344;
        Tue, 03 Nov 2026 13:57:08 -0800 (PST)
Received: from localhost.localdomain (87-205-122-125.dynamic.inetia.pl. [87.205.122.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e495f70sm3697866b.76.2026.11.03.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:57:07 -0800 (PST)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: cassel@kernel.org
Cc: rylos78@gmail.com,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Tue,  3 Nov 2026 22:57:06 +0100
Message-ID: <20261103215706.508495-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aui0uB-EkF7MKOGb@ryzen>
References: <aui0uB-EkF7MKOGb@ryzen>
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

Niklas Cassel wrote:
> A Tested-by would be nice here :)

Happy to test, I just need to prepare the hardware first. I will send
a Tested-by once that is done. Please do not wait for me if the patch
is otherwise ready.

Kyrylo Biryuk
