Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794039221;
	b=1i4P8pujvMZU1ACyz9b0JQv1CWR8LUxqtYyOcWaUOQ79BiwbsPc8hg6oIkuv1hNjMMxA
	 c1PbkGbDA6AvDEq77tr8l0rxWAXdwcE8I1rGu4u8uSE9VDkRQ0YLjGhavDQrdhbUwSs24
	 8T55BlIR/DSIRQ62eou6haJTCgqZg8rNsyFfSzBpVs84NgnXhN12s/JdufaC/RUGc33A9
	 5WobyjEZAEiQTEb9pmyorD2OZEo2cOsykZfJ6xCqhzvvoPH6453qXkvBIqjUG+lL3i2tS
	 zBICXPp1738lbOgxsEMnIahEOWGzFuRnelzMAFsbYcHBsFm805alG65pRTmPyi5GbvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794039221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
	b=eiersLRZ2g55PO9koEEB/3E0Rc+qZ4Ph/jpJuEhFbbH+z2K29Z4SuOuTPBJTaNqfsTb9
	 b++5qRqnNvR+ZgZWxmOuKusGjYUe5UhUJWiC+9UmECf1asO20EzFS+A+B8PSSP8gHYwav
	 4AxnBaahPI+447INy1MKckXT+z/RzAcy98JzOB5opi6yD66c/wuaC4r2EbJuTwlCw9elS
	 +AfQo7bII0LulDv3CJUSL0nYTpr6qcmuzfNyQmKQ1Gg3mwifpuQ25ftHMXVipuGAStbdI
	 FpCKI4CcbEPTzr8KQwnOmSsjl4Os4Y01OWep48e7PK+7DgbGHbAbf09Igewg91EHEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZvVjFvY;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC73606A32E
	for <linux-ide@vger.kernel.org>; Sat,  7 Nov 2026 08:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC73606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZvVjFvY
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso1681923a12.2
        for <linux-ide@vger.kernel.org>; Sat, 07 Nov 2026 00:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794039220; x=1794644020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
        b=bZvVjFvYYsdSzfWwQT9YkMoTP8JqeZm4/UzCAp81sLLhJzxMtyORcr2aeCuQYaE0yN
         YMguZpntuDTDP4YvBUkVr73+CnKn3upZ8VOxyXz9OZX8v5pXNMUpjWSGRQiStPu6y6LT
         buUjSwLh4C8SG0Q90s4kYfgivk/FS5Icm/8zhEfN30QKHh1Uedv9t5IZN7euR9Zh6h3s
         mEGBaFfe6+6QAhdmq1zecfl2fYrBFQ5nVlOpWk/E4cd+AAoPId8GoRLEoPcOvpFp1PR/
         tio5yKKhX+mAxTfnvUy7t5/IM0VC4XzhVc+sX+Q44IZGGFAWkrX6ZOMDEt+DhSv5JnrX
         0ebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794039220; x=1794644020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=drqqMV56464i4tsg6wHrzxaF+Ciezd2Nv4lHeIMrI/0=;
        b=zl3xFeV+E1/No5DWaEo4ZdUmyEPAl5r2akP2dQUyVci9p79ExJIvgh4iR210s3cVMM
         grrulq+2Xd0g3uTA4nNfqm/crYy9WFZdXMbaPXR5AZTuerchL+MK+yAILyr1fy06c/ln
         e38CRAhsMbMkIT9ZglEvp3ZRxnr/nnKFJyNKYGzaufiyLCFkCrK+vsuC49aAsnbOlYPD
         S0dfZaarALHxR3O1Myn6jkAbdW3sQBFv9iAVEB0hkpNsJllg26zvr3cmrk0TRnXx5MGI
         k3Y0fJfINXHP0Bu9wxdd3NjD3vt0GbM1Lf7CzWj2ADhiZQ+QdrpW17Neu9Rw26eyjLe7
         jDRw==
X-Forwarded-Encrypted: i=1; AL+hErH6CbvAEFUVKf3avVZ/2iX+naG3euz2FqKbwTGUnPuU40WltbzSA4nGe2TKLeHqDKUj8QKlSCWo0Mg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZpSn8IEcgJnanCACKLNawJaSbjDOSgjCTy3INpxV6aPqe/jFq
	qRl0Tv6ecfeCEHdVtcZwMO6wU/MLnXI02O4JOYTrlAinoJf++i+gryX3
X-Gm-Gg: AYBFou1vOvCaYD/c1W4sVx5ZVWSn4Ca58LDJ/J5jW0VMH/XEqLOjZn4blnlOcuZSh8j
	of7YH111ink6NCGl/kXGPCXosHUXBh3QBIsuNIrcJO0VeHRhHK1jLLwGkJgMEkbqH5W+78UBlxg
	0Vy+vQMTDo3Egicr3tLwkBbE0AyxAHRvL4E8I5ZhyXjNBBs2lCh6Sb5KN6uIzqTsvk0RuHTg63x
	QubVrBpG9qQvqR+IIktODe7tj3TsOE6vKgeqhO632fAUtQNfzmUTru5GANlbkW6ibyoIDmnzXgY
	CpFA681ADJ1a/sFfRXpKjm837Yd4ERqtIMqoFjMOuxwwvNzdGEJorhf4ZX60mbO9D45zKKPMJUV
	bmdkR2zwHxcroeEsTt40tb1631W81yQSbh5wNJ+y5YAfxzlDQbdQQ0fkMmNUJqPx3bR2qw8taQr
	3FNwxq+lWKeEXYXAPjQ69MajgwahJu7KvYeRScbKJWgDLqRgn8QBbyZHXt0SV1LyRfhMS2ZDqgu
	OxRzFTsAbkMFC7ZB6FTEKCzqKrr07vtL7wV3dT356gqbqAhaXHJ0RfSmn1WwKm7zlTeyj3YlWSS
	s/IJPKd6lybEAb7ujD+XrjXzrC50V9d6afpYa8Mt+dvN9mA=
X-Received: by 2002:a05:6402:4503:b0:6b6:e857:19d4 with SMTP id 4fb4d7f45d1cf-6b6e8572a11mr2906303a12.11.1794039219559;
        Sat, 07 Nov 2026 00:13:39 -0800 (PST)
Received: from localhost.localdomain (luna.k.pl. [193.239.59.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae576asm1527357a12.19.2026.11.07.00.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 00:13:38 -0800 (PST)
From: Kyrylo Biryuk <illofspeed@gmail.com>
To: rylos78@gmail.com
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell 88SM9705
Date: Sat,  7 Nov 2026 09:13:35 +0100
Message-ID: <20261107081335.3360920-1-illofspeed@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103215706.508495-1-illofspeed@gmail.com>
References: <20261103215706.508495-1-illofspeed@gmail.com>
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

Tested on a Synology DX1222: four 88SM9705 (0x1b4b:0x9705 r160,
6 ports) behind an 88SE9235 that is passed through to a KVM guest,
6 disks. The same 7.4-rc1 tree built with and without the patch,
one boot each:

                                    softreset  reset failed,  last disk
                                    failed     giving up      attached
  7.4-rc1, no libata.force          60         12             197 s
  7.4-rc1, libata.force=N.05:norst   0          0              70 s
  7.4-rc1 + this patch, no force     0          0              11 s

With the patch, each PMP logs one "ataN.05: failed to resume link
(SControl 0)" and port 5 is then left alone. The same disks attach
in all three boots.

Tested-by: Kyrylo Biryuk <illofspeed@gmail.com>

The test boots were scripted and run by an AI coding assistant on
my hardware; I checked the logs.

Kyrylo Biryuk
