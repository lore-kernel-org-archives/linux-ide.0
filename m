Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091841AE014
	for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711643; cv=none; b=h8cFEcAyX4JeYbL+LEN55kbMKrjLCRO5vZ0xvqM03ZenqxGPhx8PF30hXDGLmXOtY3XkmDGfdxHpVz+xOiSTh+xRB73DbuWfX0uGSex5yqP6/KTK+bwbFUElCbtBUVUuYngd6Q04CqsSp9nnCHbm2w2H2Fkci8XYzPbK9jpaaI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711643; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGM0CqDE4BXFFaxhl7pD2+5KgcHCrQBQpMoYPkhUXwJ79DwQ1XIx/o/JFyIGVkHAmOaemGrG2wY/26hwMdrXr9XF9ZBPlf3nbf5JcEzSAePcoTZaH3LAQT5IrvJ2h06sJgTKuJOsG0I9eO2LXej0x5wQu44frIERgZhf7hIWbTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PwtiQQIp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PwtiQQIp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9aa8895facso11238166b.2
        for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 12:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711640; x=1730316440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=PwtiQQIpyv4RO9Ol/BZmZXbFRh5JZQ+ndaIprUguIv9vZVGpt8hG7j/AqgTPSZCl06
         CMTticDFikUz13UQ6158m5ANtHtyhhYSZIYa1muVd3FrLjt/6TCqBN6YYm23GXE04pZf
         CqTBOf4kOexJGvlap8XhcHusf/Mse4MaR23LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711640; x=1730316440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=mzbwgG4gu7bWE37eOLtLooVxGGHMnzb8FU09iL3IKIEti6b67PenVluFT17cYH7Kzq
         3VK9oTUr/dEOgzBnKqRosZNzlOFDl8ng8zj4qPTxzoOE97rMRJVPIYq3ejuyo87fTQGh
         y7Bk54nfG/jE9K05FSDXvZIU5jHRVuPkmyxOnyufk4YQOsMjf6/RtbqBYQ2P7Kd0uif2
         ttX0IzMa7xzvanm1a5m9RBdYubwCsO4NrLjhZcGEmnMtIOHPGneEYfDP9oFtoOOZsFOd
         hzU0HyTrwP4+qDJfcQgE7IR9k3OVpBS0Cjf0gQbbLDLGKJCbncWjFrGut8gRmBK5yK6+
         r0Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVZTqLu1g5TyMc5ess8aJskLA99uuUEwvOIYQ2bRCJQM6JGD+OS0e186yshvdcInamKK7bylMoXD+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1LfiPfZPQ2AufZ7L8k41cQXzsUfr+m6j/+6Xb+hSza+XlkCy
	UkGFzGILeCFCZ9DNZ3KOpiU17KfuGEUkLkMGKdrjuf4riBPORM7TF5dPdueXodPNm8Hu0BDxw9F
	jSe1RWA==
X-Google-Smtp-Source: AGHT+IEe43BZfXHmF5DPh33KSP/79XnQToVb1NM6Imj7eHJnARxcJCxGJAbiWVhljefQ44Sx8sRqCQ==
X-Received: by 2002:a17:907:940b:b0:a9a:1739:91e9 with SMTP id a640c23a62f3a-a9abf86af8emr343580166b.24.1729711640179;
        Wed, 23 Oct 2024 12:27:20 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9acc92fed5sm38219166b.199.2024.10.23.12.27.19
        for <linux-ide@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:27:19 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso197318a12.0
        for <linux-ide@vger.kernel.org>; Wed, 23 Oct 2024 12:27:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJNyP5+g6ckKQSN54MI+W0bwPSyV34/dZFmd5SWwwZPuX1OuHJBHMvKU0bH4l58OysD+xOhokawik=@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus
