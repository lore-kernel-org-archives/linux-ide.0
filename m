Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792544716;
	b=TCaAmRJ1CwgFcQIckW7ODIOpt+wYxHHRCHhEICorwvHMKY4XOXCKOhDjsB7yWBbg9zId
	 FrC3RPVxzwypXgfH/Q9xnUjis6ptb48I3SPW6b7m/iy7NH6ffmmrD+gY954nLj63riWcF
	 rSRLcz6uLg6i12VmSt+cdwcI/KJ7k51Ff7gmWSn8yyJpuPhXPk4W7nQDWzvzu4Cimis6A
	 46uUbZM9TQFbmLx8LuEaAXRzdc35NVfcSexX+BNSEuxJThxaMAp1T61gx5MvTq/bKf5bK
	 3nTqhfNlK6l1NQx5939tI6Bo3PejUTC1I9hE2GQsoPcKM6ZMdVGbGKk2/a0cmURfJgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
	b=MdVMFvkIt5DT/OfAKcab1ze89853p5GDwSegKH3iPj+57KLiH9v4ghtht2IMKf4sd3+I
	 89QovsJqX7QwHhpn7yVQGL/JOIavZT3v3oXcS3d9nv/S/g6htXJyDl3+JWH2RhM8LSnOe
	 yZeqElSyVOk2S4wEqMqR57pclwoUn2UWTX/Oj07ZyRt4vVzoP+6iIpRYY3nOnGCN8wDJz
	 nSXgMjrOq28Gqf1l1Yuku6AMhvAyfxkxFmv6VQE+DCBbPF89YgRLyBnhYPLcOb6CvSEVl
	 Vjh/n8QpG42ZAghTE2lVTCRU614P+gkT/oyjdsZT1LugNp899AyGJnD2oAZYFgnU28g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpITqnsF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.175
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93066606A31A
	for <linux-ide@vger.kernel.org>; Wed, 21 Oct 2026 01:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93066606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XpITqnsF
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4b28d7c729fso117674b6e.0
        for <linux-ide@vger.kernel.org>; Tue, 20 Oct 2026 18:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792544714; cv=none;
        d=google.com; s=arc-20260327;
        b=F6Sdjjxj3n9/wC3ci555ZZ6l7n/HIpgwaYWtT5IUkIjh7aVmDKSo6jzRrELQad52ED
         TZh8/VBCW4n/YCLJJcKmOg9XmUX/aS67NiqIRfhfeWWlk9zKj2T18pDRKwF/HAxy3l7f
         la3ZSF3dC/fG4d2zb4xw1MKwn27OJqtyCPqmJh9oFFdSRftAkYyxq6RK/+h2fAnoQwLa
         nrpEYO+2myKKbAC//ZDKWefW6PUlaxN4TU/Rk324OnL5BEz4+rj7MuWynX0Qnk/QJW2+
         EyjOBQID159jbspenACijeiqM8X138u4J1ZDVek7CRYaOoQSKrBr6TytEfzkeu6CNPNe
         vZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        fh=yCwG4Sxq0nXLGXsU19N28PWgn48EuMNrrgd/Ab/KKhA=;
        b=HRoXnUcmv3k+zLdoNjt+Wr9dRUPBct8NWbwiqlZH62DFr8f3/Pfjo6JeZN8KMERczx
         LW4eJrolg0RenfZQY9OtG/NAq5eVMNesuh2fp6Zs7kDjBS3/McdOGjcZrj9NjLAr6vEA
         JAHeAjOTy5GWhWB8ByV7WaWP/6lZrwxLhIJhY+0qladvAndivJMCT3Sm/cX5GzGXGBvu
         48taqqaLD0JhrDQ+DT7roTG5YqzeNE+RKyFD4N4In3RgH17BCM/uyST47hQxx9KUh8bD
         0r9KHw0FYwt5HJlLlyYezEE0af4mdwoCfuNrMClWdFCya8ETaofGeem9TLql1MiMwXnA
         jqfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792544714; x=1793149514; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        b=XpITqnsFVbmsA65tYcRzfHxyxSBcJK65LXclrQMybNFaokMcv/OBBeyqo0kpkyI1Oz
         UIwPty9tmb3wXk1P3KAZiHvh/Xf8iZOvIWLgxX7ooqdP2YzZOpqRHht9VGAwaKDkipFP
         QKaRzRXaULK+cDuLvOlEAAZ2+hDTdtRyNZMk9+/ln2FT1v6kDPKEsszkJrTCW+zQbp1l
         HlR3EsL8jhTsxuuY38fVH+N16er2bjK6ZsuV2Ik/3Tw3EqsaFHIbQtWgvuCH40rwgS4h
         vgRacjtbDhOpfw07WskUG3JwQBdRTbkI4rRyEj6tkHY3ia90cF7+rhFPiZd2E7idWXUv
         Z3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544714; x=1793149514;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z0hLEERCsjy4axc50ookcdk/sfqny83SF+wLsC++daU=;
        b=DRQ0VVptR6i53p860fyk+qrS0pL0HD7GhbC0/vDIo/eMJw+NPesahkXrb4fifbiikF
         U+3oqHuOHQOOEvCgyyUaZSjNaxFIu0odClPab+J3yxGVmaZPHFhP89hRUJcyzb5rW2Gy
         kaYx43bVxWQT0tzqHaS4K3HLhQ2A4CgX3Nzn3vvy4eDKmK8GhB5RRvolwCiCNp85irMS
         /iz6SBrpzUXN3h2smnmCfaR/vqnOXHUgAk2+x2a0IUI8635fWcYcwvIOla4/z5raMbj2
         P/TuHVz19uMc2m1JffTH5zz2zGPH3e9lBYdC6KDBG7F4CKYdj8l+A4dRWY1wBHTGkVT4
         VZPw==
X-Forwarded-Encrypted: i=1; AKwUvBydgfNoqvtoJas+2oo5vLwLZELynIUsnFL/U/7jzX/FCuCgCPk4Uu9jPzqlBhNpd0tAf2AGwLr+14A=@vger.kernel.org
X-Gm-Message-State: AFq9FYI9ltUwx5OpmBKoccFhAQTHsG003DHsg81AYIvAXaSvx6JTub4/
	ws9e5uJMnEzbHR9g2u2lUb/L7C7uN7vR6Xo2PpfswNDCl/tqPZg/V6iWDjbXV6NSQojrR5Rl2rL
	Q2mi/TLeDYk8rdI7C79g/w162rblbqsk=
X-Gm-Gg: AYBFou0P+jFVh3HagzDFnBMqwKDh3ju982zI1zBL8E4cnV8+bR1Fom+6t07qMleRQT9
	aLzhH/hTUX5Ptnc2nY9kxhJPGvK60Cl6YuoD5BbU7ok38gwDZb9QtWbr9ktlNgVdKkaduFj6nIg
	1m7C/EhYIF1V5HVp2j3GKevHtDDXAbnxw2HCITAd48WE+PtrxS8Vpy0Ub3MjjErTzi0wF8yOWcg
	9hTLU+jvoy2PC/ZMBoFNxAPmVNaAyATfK0Q/ZM9OrImsBGIbTVa+4lJ7HA7g6yJRvEvGV8aEC2Z
	1pJ+aB9LREQlw5IglhIgR/PbN8tn5QWK7kz75Lg4/cG2lwAepI+AP60wN4tuaaMxJ6MqHp5e2z/
	fwXBe+d34DA3SrDnG6BFtaKw0xmtDQpDwiE9LIx1cEuY5qHUUjfo8eqI0Da9d6ad5DZRU3iEH
X-Received: by 2002:a05:6808:5147:b0:4d6:9153:295c with SMTP id
 5614622812f47-553596fe6afmr356471b6e.45.1792544714494; Tue, 20 Oct 2026
 18:05:14 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com>
In-Reply-To: <20261017041419.311921-1-daniel@0x0f.com>
From: Colton Pawielski <colton.pawielski@gmail.com>
Date: Tue, 20 Oct 2026 20:05:03 -0500
X-Gm-Features: AclHuK_WbBRvyFNBUBGOV4aGPihFuEs2qYf6-xkzjASYHC6uPBnvRp4v0utSWw4
Message-ID: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

This is my first message to the mailing list so please correct me if I've
done anything improper or non-standard.

I tested this series on three I-O DATA LANDISK HDL-U boards (v7.3 +
this series, landisk_defconfig + DEVTMPFS as mentioned by Geert).
All three boot from disk, and the ATP865 is detected as
"PATA max UDMA/100".

I have different drives in each of my LANDISK devices:
- Maxtor 7Y250P0 (native PATA): UDMA/100
- SATA SSD behind a PATA-SATA adapter: UDMA/66 (my adapter
  gives ICRC errors at UDMA/100)
- CF card in a CF-IDE adapter: UDMA/33

lspci from two of them:

00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 20)
00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 07)
00:02.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)

The third is identical except for the ATP865 revision:

00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 06)

In testing I could often lock up the board when transferring data over
SSH. I don't believe it's related to this series and am fairly sure it's
in the 8139cp driver. I have a candidate fix that I plan to send in
a couple of days once I've tested it further and there's no more
lockups on my hardware.

Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
HDL-U, ATP865 rev 06/07

Thanks,
Colton
