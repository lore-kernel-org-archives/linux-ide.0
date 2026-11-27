Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795803529;
	b=NIMmXG7h06SA1bp1ZV3P/zTVo9eERkvm21mxczqH7+348bKfGbpeBpyfacJRSBVaf6Gb
	 HItfYZuxLsxqiJSXuiqGcgAT8BwrCCc2dvHJ2ndVOCGaCfyEiELJEfSB6tmVK1R//mKjO
	 g5M9hNpa9mH5zdacSt/UJwiRKAV2PE9MPn8mw0JsiIpHiEx78mMSU+EhtoWHA+k2hxslq
	 EVaX+KZPKxq2zsMj8EgrDMPzD53unBvTs62lN8legZAwcWnaIwV+KGURsfC+VNR/TGEKH
	 atv9+LZNn3mrtW2e4VyNn1RwyFmdSDMJzz9nxlekWOEVV/7Tqwrj2IOHtDQKMhGIAuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CnX7HINTr588U0bg9W4nQOssNhFb49IVZppErEdXcp8=;
	b=hnG/iSLd80a4rSmD5yYJjebL4nr86cP46PyHlRu7uE7uaXfuE844A9KX/qjG4WPQpc8n
	 oZuPvDHwKku2BKx6gclC0KdAZ6bIf2WqwPhY8aqELyIGsL5qU/LHcMXzca0zeDQSc/bsA
	 SqTq9g9rYs8noPloURsTrAW+OsA59eSeA198ypJzIvHj0uNLJzk0OyH6ctt5IGFzmxGWP
	 pKjKbm7HJuStKtH5X7nF1R3ghYHA4bHmLinpOw8InV8Ve1EE58QVy3H5lQdKIefA3yP7J
	 1Ix0f6yuJwYrsqL85L62jA9dura7H1Wi+1HyUF1uBNaujcKiKjmQqTcpjSPFsUMwgEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftII0uZv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C447E606A321
	for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 18:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C447E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ftII0uZv
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ebf4cd218so71049556d6.3
        for <linux-ide@vger.kernel.org>; Fri, 27 Nov 2026 10:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795803528; cv=none;
        d=google.com; s=arc-20260327;
        b=pkkoICZRED5jVnq23gGZ6OKfUrFSiS2ku8XNKzGz3QoFMZpPyxF14vh9L77qyA4RE1
         3vyRzQdmzQSfiIwBKlZEJXf2Cofbgt/klc7n2A90h8+mf/5e6wsfBwmG7x99ofyax/VK
         lZWJDGE2CZcYSodah0AEIkKAxQ5n3XYar8Drsloq4w13ymkdOX4YKxJonsF1fOKl7pfB
         7NrAv2x4tmeyhR3sLn0m0VE3Ywf8YXzkHhO1/ou/dnAIOF+yRfVZuj+pW1jFSSj43GSQ
         JLXflcMEQmGwKE9XW+TyYPMC+v0kFgqNTLgC/T5F5KA3mF0V1K4Ph3Divs4sydKY/Dab
         ZrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnX7HINTr588U0bg9W4nQOssNhFb49IVZppErEdXcp8=;
        fh=DehueyOrWjQXdr6hoYwi+c+gDaMi8EjtWft+wpgMzEA=;
        b=GKym7TRwNJFyevDG8Azj12YgEIaFDqZzI+mQ18kmBhTY2BzOXawzCAPzpzp/tToAAs
         DOJBl0v5r/9dezxhCHFo/mida6e4d/ZBNLOnjAIZ0Gw9YlbUFDjXrhKCwTs2/vvHl1Us
         pyLpICMNrzwCbuNdTx7WDuXAnkI3EF9V/f8DwN7XJX989254DPn6fHXu+ozWNV9Bwl5M
         gzGl1QXZ2n+bL2H5UhWu/YQFd00j4BKtewTUeKcfsIIOSv5zQeaeZXIR/5s8nhRSXLVh
         YU58gm8RwooTilNo/YmfWAL7x2leJ3QVDJ2fBTIIT3WUgoezo47Rpka+Az4/kKtv1Ba9
         EKSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795803528; x=1796408328; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CnX7HINTr588U0bg9W4nQOssNhFb49IVZppErEdXcp8=;
        b=ftII0uZvL4qz8CEV4FYd3uFfw7yYEmkDAmIILC3TzCPzP+i5Cc9V+9BUYy5xYOipNI
         14txHmg0ix4e+Jp2iJtCgue2/t8a/NkQkqvZVOaVZG6daSfKypA94/Z7JgU5UsXfON3G
         nQGn6NR5qgxeqmIus5/uRt1vJj1caPeMfX7HRwnt/K1wAbUNblRivOsDyg4uTQcO/BWq
         eN8gLVONRHG7hjosv7QuESlg0Y1CDXoM8Js7cHuVcYJPUpNmcWr1AmGOl3klrbvvSkDN
         brjnQ4f9hxaMuIqf+4QSAaARLORg1L+CKN46Z+aDPqX9DaJBY9E2vLIIYUAaTRkFpSh+
         /nQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795803528; x=1796408328;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnX7HINTr588U0bg9W4nQOssNhFb49IVZppErEdXcp8=;
        b=t/m633/EP2ZgWzP6j6X1tbRQ7Vl4IihkRx162O/f7ay2qb0NRMja9u2tsm3+zRheHa
         5qRbhvMJ6EmI7OycdQhIOMgoZiSnoJR3pohnhCc40/G4hbpvwSx4TpG0y+nlmqTspxHp
         nm+PRMH2+B5hS+tDudSuUoMum2kMq2oCUwmZuvR4xUKx6WAynJZqrHf80+Okh2t25Le8
         OKirCxqnHNvo4jiHPa3BqLOCZZD8sBvdRmfgbpCIiRRzN2hgxL2JzjNUUHTOHGzY1NTc
         m6H31TLAv8VMEfpcc9ahZRDZhVwi+s4oB0jOfePONQhQacTeFGFx4ZlYvpZPB95jyb0p
         5f1g==
X-Forwarded-Encrypted: i=1; AL+hErFo7W4PwfHfcMkz4Vqitt2ZS1PY2HT+Xnf0tLsCE8E67ELjvaLg1lGaqzyIdYSEKRTFBgZ9DwsOj2Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YRrtcP89hGI/QOvuS3QoRcawcTsVDyYUNBxWluSFWLzruwvAD
	dKIphXs6UPHo/ErOhuwBnfXsc3/yfYD3q5VLFtw4CgGztivKh4FFd/7LjoRJh7leNh5vI7h/ucG
	xqWwDCpXBlQG0/tlzARFlLbIgoXyy1NM=
X-Gm-Gg: AZFdTZfZufdbqOcMVFOsk33a2rZ/um0Ym6vAe0a7r0iD/pG8rWfnxMyxNktY7fJmI+R
	eaY1V1/BIp3rdFOryB2Y9c3+WNxxmAq7LK+og8onLIkn0IOD9pRUuRKKQxW4komCK5gozgWqBaZ
	tyBMbaWzZku5IBZkobZqEWFuU7Bn88Glls+PeKjMTWIv8XeVciTyxq3o/oSnK8UMWqfhdIl2GsX
	JQqcJ9bqzTFrxo9U7VhKwJF2WOQR2fmIq2Q/OEdJebtYhQ2WZry5jHpdyJWhcTZAMHN8AO6ItMY
	3hKQBoAl3v46SKDAXlheCupqZRzirmNvzL4SS2ZGxdBrB2UAAmLbqJRhtUrZnFz0md+yTw3erjy
	CCCazZWRZEhBAlZXNUNSZuCk32jAfOSXf/IIx
X-Received: by 2002:a05:6214:8605:b0:91f:808:3ca3 with SMTP id
 6a1803df08f44-9213497c81fmr482391956d6.1.1795803527693; Fri, 27 Nov 2026
 10:18:47 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126214756.39027-1-artem122novak@gmail.com> <awk74XffmMjYTJ2j@ryzen>
In-Reply-To: <awk74XffmMjYTJ2j@ryzen>
From: Artem Novak <artem122novak@gmail.com>
Date: Fri, 27 Nov 2026 12:18:36 -0600
X-Gm-Features: Aa3M54oZ8HUGbd8-fH22ZUEZRMgFxjOe_Amsq0wahO5RnRYzQOIFu-_S1bcSZv8
Message-ID: <CAPufuhYk8dZP6JOgmhqDOa1JXpY5w-GCLnPkeLe_+brxNb9utA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ata: add missing newlines to error messages
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linus.walleij@linaro.org, viresh.kumar@linaro.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Niklas,

On Fri, Nov 27, 2026 at 2:14=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> This series does not apply.
>
> Please base it on:
> https://git.kernel.org/pub/scm/linux/kernel/git/libata/linux.git/log/?h=
=3Dfor-next
>
> or linux-next.
>

I've rebased the series onto libata for-next for v4.
Thanks.

Artem

>
> Hello Artem,
>
> On Thu, Nov 26, 2026 at 03:47:52PM -0600, Artem Novak wrote:
> > This series adds missing trailing newlines to error and warning message=
s
> > in four ATA drivers.
> >
> > The changes are formatting-only and do not alter driver behaviour.
> >
> > Changes in v3:
> > - Carry Damien's Reviewed-by tag on all four patches; it was
> >   inadvertently included only on the sata_dwc_460ex patch in v2.
> >
> > Changes in v2:
> > - Fix an additional missing newline in sata_dwc_error_intr(), as pointe=
d
> >   out by Damien Le Moal.
> > - Add Damien's Reviewed-by tag to the sata_dwc_460ex patch.
> >
> > Artem Novak (4):
> >   ata: pata_arasan_cf: add missing newline to warning
> >   ata: pata_pxa: add missing newline to DMA warning
> >   ata: sata_dwc_460ex: add missing newlines to error messages
> >   ata: sata_gemini: add missing newlines to error messages
> >
> >  drivers/ata/pata_arasan_cf.c |  2 +-
> >  drivers/ata/pata_pxa.c       |  2 +-
> >  drivers/ata/sata_dwc_460ex.c | 10 +++++-----
> >  drivers/ata/sata_gemini.c    |  4 ++--
> >  4 files changed, 9 insertions(+), 9 deletions(-)

>
> Kind regards,
> Niklas
