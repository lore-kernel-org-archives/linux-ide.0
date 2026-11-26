Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795720884;
	b=qvsx1ZjCXq+xw3ZM8o8SSMmP7K9bekP1Kz7JC3i+OeKBl8rsemUKDvvFh4NgFYMLg1Z4
	 Z+rA4KtxM2MIQjSOxRYIiYVtGvkv57pe55rEkw7LRNeD8DGCm0QPtNZ/J37oZsE8Uo+5x
	 aoh+GmE5zVDASWyVYpLWwNJU98PDECupE49ZgQ4qD4LgW/YKwt2eNJhbVU2OCC6AhYq11
	 MZ15cj2C5LMkS47L5IelsRjy/YBsyPQ17WFoL0EoU8mjB+IKL7N9B4W/+1nvqIyffElMi
	 6XxddPoMnipz3xvnQ8OusCGmW0K11rRsVCfMrZMCcL+1D5Jbfj6M47+GWFJmSg5kJHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
	b=zI2Wo7BwF9Qagyc0T3yHHG7qKZ44eOhJeocNebXdZBChL/28gxclKdVdVeEGoELnfDDP
	 9xXMZ3rkSMn76v3O5gd6098qtBKPyoRd4CKF+CHxUvBVsVJkq1B458iQ3UPjIteIh+GeU
	 s7FiyXULmIsiZ9/yuhgvWvQuz72Bd4CP6RnTlFAfqfw2IoTapaEtgSm8tlwLPOwucZJiZ
	 JeDPVo/enaS0D6/FNcrsO2c5ZX7N58V+1FtLVkgMpF+PAh9J//Hgw8xqGbLj9t+EpqbXs
	 8ZP+MqwEsSXkEgGJvvCIFoPBjfmLS0nZJMvXZbU+0bSAzvvrcF1FEXeu/KZ/ewEgzmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Xn/ubnZr";
	arc=fail smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA467606A31E
	for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 19:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA467606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xn/ubnZr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so67051965e9.1
        for <linux-ide@vger.kernel.org>; Thu, 26 Nov 2026 11:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795720882; cv=none;
        d=google.com; s=arc-20260327;
        b=VCJ6ifPmZhYdld7HUqt2gx7Oh57TonWUk+CC4KMGkmk1gWJyvG0MiLzXtubfkKYcWp
         KjgTX3mX47WalZLfPlr1lGB0aoUH1DsmGrL9lDhbyIEDzwzw1S25rY6hX2FKRsepn4ZY
         MoHbQhiQi0wKGzHXIVftqPNggA5XTT2dJwx1sF6E5LnMYH1vooD1gjssZrcJV4AESDoc
         tMtawWUenowKpYk22U7e/hwd/bKp2BnICIJFSxlQbmOar2WhDBmZJSRe7aVzN0pxFxJ+
         aaoljabk+bgT+P6ebsusJly8ggfZ/g5Kenxn2WkZSi8AedR6+PVErZdqKAf73EZsUUoC
         j79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        fh=/fFI/bsdoPlZUu6kZoNZctf8dceqmK3dsrdyjNhD1Qg=;
        b=V1l0tRfjS3GNgriFmD6c8vV4f7bdIQCu57uwZ+hyDMmWxJd1EYcDBhPA/dfkK1QQ0H
         4dqlHXjsmWWfkfsvrlS3b6Gt1/ubhIwdHFYIu8I6qjUKpcq/WorDCDL5TCrLUFjzBWSW
         uT8yHR6weQPUB7b3SMGDw2gqL1jo6D4I4J3ShL/9pZQ57oFGZ7WRv6zUH1j56dvEjLJf
         0ZgTsPdaJpz7RbwuLT9kSHCQRpkKzolnXC55YnBSMS+Ff2+n3aoK6Ee6/ngXKDePqbfh
         IdV3V4LnNJTRdzjvZxLEzcE8yMS+I2lxL+X/s7tL9k/mBvZa0cnErf49QcHyUp/G/iUH
         FzXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795720882; x=1796325682; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        b=Xn/ubnZrxwED+WHf0P0xqhy2VqpnM1a1PrjpZ86uTk/Avb35f8+NyzOkNgRiNmvEOo
         iOJQ52SN/ZBKXB7iK3Mo6CYGXJ9MURyfpHOkawkyh9hRXtl2DadGMMbuIkULPR/yV8nx
         LF8H2ZLNs9mlVwWtUSeUFfEiwNcU+1eXJ4YAR+X+ySR+jceuef3w3vt3DhjEbpXgKSda
         +LncFbusVPJngzdIAxFEeUqETzlmXYeYMrZ28WeCUTrrIKii92Y/s4DoPaZKhQFpH2GA
         Mlu/A4TaLWgMSHNZo/SlUhIjo10Nb8RisV3/PEzvTI/668iHo3o3tlr8aYLcjolnj6Zi
         EHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795720882; x=1796325682;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oxIk9FvIh0u2YzbWxdwjMI8skmCOeZZ6dGUk74RsIms=;
        b=P9ACXNddG0+XkC9uC6qv/N7mz/yDj0OTDLewE3vwKhb7omI6xSw8zcDz7vwopbglrv
         i6ziSE8gpb2mA3L+/gEwjkgQJnvGJ7dQkysP6D7djzMb725pUkyOihPrYqb7Z+4xmPk1
         /B6KXwiEzalS2NIpTeen5n9+X9UMwm2y2kdAw/f+4+f5ozpuPBUIfSpoBQZERQwGrUH5
         Bk5OfBOihqxQ3VJXeUKzUHc3elWsCFjiFIXodr5TDQEjlkcJicXUSY+kd/Ec2Fksnouc
         HtMtkZ7LNXKdNyMBGUKKOzpYl/08wiZdfqJXEEc015ht/7C6FsrhjGttXoHVyJBNyAIP
         TIZg==
X-Forwarded-Encrypted: i=1; AL+hErFhlpdAaDB91BhE5LUBt3Sz7hxxcNRcBha+0QPe2kgdBnD97VA8S6dZziPkYc3hHlHGA/9GtqnxugU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GFNKBnvA5klbqDOx3ZIp6GszfEx29b4llYrJcXk3g+cENNm5d
	cY8Ed/385pxbxEgNi1CnL947Vkd77CbYP0Ok+zFHdD4k2Yh9Y2FotYOsRi4PC/uIDlppQJTV/hV
	Hz1Cf8XXDAkSY88uWe6L0ApCf9lvcubw=
X-Gm-Gg: AZFdTZdQaPZo58w1z3nYg2xyDk3E/RZJ7bcCqBiMPrSOtKxV2UUyxoCvz3z2vnrKEe9
	8iSBo1gdnfx1ZTlNHRnt+h17VFGUKtUxbviZE1YBngdOgwTRJBAILCxgwfnY8Ya3rL4JXIRzXG+
	yNhgwDridwb4FT6U5zj9gAWRxlheb3nRpJA+Dhdf6IXwD3fH3bNUMVmarrd9wWSvRoGSWiO3bJE
	61CsMgW/LMmdUPjJH5yrQkNkFuFLlchVuf719KV/f2stybiaVB/Cv8uruSbTkGoL3w9bHeQM+I9
	APlh6yaGdJSgfZ3vi42bz/6XvO88Z82HQx0hQqwFjVKk+6kAJMf783VVFfutzP+7+6we8NAVNZf
	5Y1mJCJYwt0Uc+JdSUSdwFfvNNjK7oPCRiAIj53PuVnKBjullEbTpCXDIW5s=
X-Received: by 2002:a05:600c:5395:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb8880e599mr444641385e9.8.1795720881927; Thu, 26 Nov 2026
 11:21:21 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126142406.2753290-2-cassel@kernel.org>
In-Reply-To: <20261126142406.2753290-2-cassel@kernel.org>
From: Mohammad Harsij Sani <mohammadsaniac@gmail.com>
Date: Thu, 26 Nov 2026 22:51:08 +0330
X-Gm-Features: Aa3M54qUdrB17xA1QvQrKJC2B5IlobRrnk9BLGrLk2G4VHKEAcD9kuZ0QWWJnmQ
Message-ID: <CACeOiPgQQvrhyqYUJRnR6dxKVuNzoWQWT1CDUUp+Z3+naCuf+Q@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Disable LPM on ADATA SU650 with
 firmware XD0R3C0F
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas,

I compiled mainline Linux with your patch applied and booted it without
`libata.force=1.00:nolpm` on the kernel command line. The quirk matched
automatically and the SSD stayed completely stable with zero timeouts or
errors:

[Thu Nov 26 22:30:15 2026] ata1: SATA max UDMA/133 abar
m2048@0xb132d000 port 0xb132d100 irq 123 lpm-pol 3
[Thu Nov 26 22:30:15 2026] ata1: SATA link up 6.0 Gbps (SStatus 133
SControl 300)
[Thu Nov 26 22:30:15 2026] ata1.00: Model 'ADATA SU650', rev
'XD0R3C0F', applying quirks: nolpm
[Thu Nov 26 22:30:15 2026] ata1.00: ATA-10: ADATA SU650, XD0R3C0F, max UDMA/133
[Thu Nov 26 22:30:15 2026] ata1.00: 468862128 sectors, multi 1: LBA48
NCQ (depth 32), AA
[Thu Nov 26 22:30:15 2026] ata1.00: LPM support broken, forcing max_power
[Thu Nov 26 22:30:15 2026] ata1.00: Features: DIPM
[Thu Nov 26 22:30:15 2026] ata1.00: configured for UDMA/133

Tested-by: Mohammad Harsij Sani <mohammadsaniac@gmail.com>

Thank you!
