Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1C32DA755
	for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2026 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403354; cv=pass; b=MEIVCEK6I/3My1Oq27V/I35GXzGxsSxi2LAB6EXZRyVPFvDB9raDAaDOEYmKcZUj9GuFzDYH3R0f3N9Xx2q9kls1u14JSK4GAJfcTRsM6hE7JGy8C2fcargmxeGZCoZkWECvk0o5xLU9CNJGv7n7AknWGtkj5bvxvSjEYCEn9lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403354; c=relaxed/simple;
	bh=fos8rSHuPSoa3c8ljjsqSAWDZNVwiAvDBXMVzbrHA8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nxwbl7Rp1ps6clEN1y9r+S/2xAlRIg2U8C5PRQ2WTiWzEjKRYwwOys6sZ6OG4qqK1S5X/Gayy4QBS3m2SdVZG9tMFDwiKKqAtWC3JNCIEIMWYhrObsdsgUy8jZdUtipqwa11kIE5nliUT2wyUu9nvbpvwFgBVB30o/ejyzRkvV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKUaq23t; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKUaq23t"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd7ecedf2cso216198385a.3
        for <linux-ide@vger.kernel.org>; Fri, 13 Mar 2026 05:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773403352; cv=none;
        d=google.com; s=arc-20240605;
        b=M0kqISkYdQDp90I3hHwTRHatXssDHOM1ICHP24bWDfo52YxgNmnVIh9JKzAHP1vXCO
         SQkE7oBxESlHOG/FRoZ5xP5bBmlpX3ScLNgWnVGRgHzMQjbzNfDcSYyzjl3PmsGi27ur
         XK6/kfbkA34rHDVzQre+3qTpOiYdeIMwzepJTHP/pBsJpJ0Y2QxzFmBQFIFXosQZef/U
         D5YzSwqn0ARRUJVYUEAoh5LlAHpBfBa2g5C3t8462UE9uTDpaCFIaRwh+nOxCKgnBok9
         J1zzeRWkn1hn1+3S1zJPoQVm3GABm3aMiyicr/mf2IBvauLEXfUCszEPB0xmqpjzN/oa
         6klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PO/I7BFe7HyROtUvgSkGsqre7+xQUxSEkTnUctzw3oM=;
        fh=xwbopahXrHvZHA0C/4BG1IIz1hyQ2x5swPUXWsXNVZg=;
        b=PXuGJ05nhjmXiecpjzo4rmkhNxnAeqCyCDwjgXzdw7wzriWe8Ju9iIzmqILl4ZbRxl
         gpjN9KyrknQyw5FCXI7J0KICQR9aC+ke+3GSM6yRS+Qz6Drua/vbYMNUg11po0PYdqBY
         b0Al2d9zOvDrQ6V3sdQ6oI1tQWtlq/4uBDPTuTEamjvCWiIZ61lDo3+2OjSTk2nxWZdy
         u3jV3IZQMhZDiZVWTKWOWRNKGAaewP5TS5Vhuryv2UNtzjeMeJeBp2ll94XmrR6OHOgW
         2FcovvqApxuV5niXlVZ/0XyLT+6ixyAdtEgC/WFCHJc2y69efdX2FA0fwy4FXvA1pUOw
         c8Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773403352; x=1774008152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PO/I7BFe7HyROtUvgSkGsqre7+xQUxSEkTnUctzw3oM=;
        b=ZKUaq23tDe3SlgZ9nlNuEFSOS8pMERieFPeXhCNHrgRey71WAdcXYHAmJsUeD3yLN1
         EUXhyxAsGre0hcll+Bgq1/cb04mtxFVhWj3czEMILYANoPXm879s/YwYrQsl31fzq4Cg
         EZiI1h5H/Vb0mncjwjVRWpPha9FJ7xqe724VY1eCOUuk9HujDcaMxiHmmi6GD8a/S3Tv
         ENKeLsfY9WLTXzkMomtItoOzUBkD9tPsDiZ6j/7gVp9weyfdSmUS5W8lIYFoZrXIViZD
         +3sCA7UqQRrYK/n4qfKCT5Y6BFV5tWzJ8k+gleKh+KQTS15vxWuU2894bkBp0OXKCoNw
         p+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773403352; x=1774008152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO/I7BFe7HyROtUvgSkGsqre7+xQUxSEkTnUctzw3oM=;
        b=DJ/TNjZXJZy0JEDxKXZnzRiWpzV24N/FNpT5+BSJXVkC+hQ3J7XGIG+Shij2whNNLd
         OHeDyJVCfU6X64iEpr4BIM4ofP0Qmtl9zFtkDVNHmFTwdzYdTdXTXAHj9mLupt/TjI2V
         0Cq7AjIRLC/6Mazxw6ZYqzhqRyzfN/1MbcZV+KK6l13USNOmUYxuwwKZDBm4u8OrBHsi
         D9yy+j4zKLq9k4XFC/LEI85On/hGVxUEwSqo8iXwSf0TYPUZVLyMlgqD+HgeufkAAKVN
         b2HkAX12NWAmuyyAf40j4cg99ddGSaSodL+IhkhjnrDa/8A0k3OHErms1usKqsMiT1J6
         rqIA==
X-Gm-Message-State: AOJu0Yxj/qHD6Mjhb/FpC+judMt+LemsJohYlxYPA8AznCGVKsPz8UwZ
	8y4FbqqBtoWf0siLoJ0NfgKFHDPerZSU76y4jDM7XHcAaQ2orKSLanrfYsODk6yZfZaObz/HLcK
	kQPw4XfkBMNaCPmETS8KnrRaCq6PagT1s5u24HNAtTw==
X-Gm-Gg: ATEYQzyiFvQUwEYCOPzocFCiSoBm7mnrXOEH/QgWoox0weQaFfhC6+QgJQelbKwTfi8
	hU4obsbETiYWJyOJyp7zld9NGF3Cpl6A+qvnqS4zPtEfTaziY2v4FYvq75bImdP8vzPZsH03Svi
	XOxpP5NKTh4RbxETcK3jogbG8kU2q/MPxz65PvGvjKFX4rj+V7cRnmDtNKy4ef3WVp2DTzbTQAP
	I8zEvc3U8t1Ey82eQe2q1TYhq6VNVpRR9bNgmlR5OUWm9FMLgLqhPeDA2Qxya+4OTuGCse9+MAi
	Ja/po2wjAcw1OXd23/+1ARnkGMmfhr2TkjUoIIivXMPsxrnEB/+cPwcdCDQfg5t94kc8h+NwrdR
	tHx9anWNvebfJCSHH3UsKoPWa+A==
X-Received: by 2002:a05:620a:471f:b0:8cd:8f18:d1d7 with SMTP id
 af79cd13be357-8cdb5a837bdmr396260985a.20.1773403352071; Fri, 13 Mar 2026
 05:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABn6530JJUe5vYA9f-TBY9fgi-wacqNriVPeiKD0EfYQ+ZPi0A@mail.gmail.com>
 <d3ab269c-697d-4768-b7c7-61d0beed3879@kernel.org>
In-Reply-To: <d3ab269c-697d-4768-b7c7-61d0beed3879@kernel.org>
From: Mohammad Khaled Bayan <mhd.khaled.bayan@gmail.com>
Date: Fri, 13 Mar 2026 14:02:20 +0200
X-Gm-Features: AaiRm53KCylPEDeRGYyPiI2ChCWXjLxrq6TlZfepE8vYEqvhsAUCEyw9DhXoYy8
Message-ID: <CABn6531ukajHmBNvq5z-UKN8nX8Uf2a86+caMcpGk4kGDFEbsQ@mail.gmail.com>
Subject: Re: [BUG] libata/AHCI: ADATA SU680 on Dell Vostro 15 3510 shows
 repeated FPDMA timeouts, ATA bus errors, hard link resets, GPT/metadata
 instability, and SMART reset-counter inflation unless link power management
 is forced to max_performance
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On 3/13/26 09:37, Damien Le Moal wrote:
> Please send the exact model string reported by "hdparm -I".
> We need to quirk this device with ATA_QUIRK_NOLPM.

The exact IDENTIFY model string from hdparm -I is:

    Model Number:    ADATA SU680

I would be happy to test an ATA_QUIRK_NOLPM patch as well.

Regards,
Mohammad Khaled Bayan
