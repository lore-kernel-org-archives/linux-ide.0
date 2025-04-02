Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3DB2356A2
	for <linux-ide@vger.kernel.org>; Wed,  2 Apr 2025 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582110; cv=none; b=sOkDRPt14rnzQlPyoR/qae3PwZ4pholYfZbnB1waBgYyoYyrsPOu1tlDvtUiHPjd28Si8h7S+ILNhUNuUU7lEtAzKjfkZkT4GI0WjfbtRqeN3oUP9wO76XL9UkaTf4MsuYAjVY2xj7CLWoMUrpyjKA2cAenybbMH89mpt5wodiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582110; c=relaxed/simple;
	bh=Bmk4lS854vq50m45wJoCQbmJv8fCW313JUTEO4lLx/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5FEOfBbh+VizBRnY5BbexaaVZ4pTMm8azNfOei46I4ymCM2T2F64A5efg/8/fplKr7jWesKxIKmRnOTgGPI88RoOL6PDz1toNhWFMxk8LSRClaR1690D82ZlLe3hjsLICcHujJ2GzoOlk0uDVbK0yTZAfFTDv9TKn2jfDDnbGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyjdIjko; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjdIjko"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307c13298eeso6747271fa.0
        for <linux-ide@vger.kernel.org>; Wed, 02 Apr 2025 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743582106; x=1744186906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bmk4lS854vq50m45wJoCQbmJv8fCW313JUTEO4lLx/0=;
        b=hyjdIjko+rRs9+HV+nUDbrPqbsr2yKlyg1g9aW4RL6IdQhnxiMg5+51Yg1aN6He9ty
         BalHgRljFN+CLaFICdriEs5Fm6IXMM161hRCMTpXNAxQhZVfut0x3hC1IyfU40I8sBIb
         Jk9s0U35yvN/Nhk9pYjiz3zkmPGGww2Cg2RGj2+zGbtx7tMbb1VA25qDeRheEqAjkqmJ
         eCurx1JX/qx5jAtE2q4x06UavSOXkyeQAYel15ZivAkiM0HSwaJdWQpyirSMuJQc8ABp
         AdYD45tpDBYS6Ykr6ehp6ZHMUf5gD/BDYSctrWgTvK9ExqT32ho/PZrTFdVQb73AjNqU
         e1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743582106; x=1744186906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bmk4lS854vq50m45wJoCQbmJv8fCW313JUTEO4lLx/0=;
        b=g5Zf0IKgPwcnptGjyoGqveKhUoZShleh9eS6Q0Cri45BmrTM1u83MqGwVdptaAytjP
         7mTKoq88qvf0dtM3L6EFhaRnJ52zbT5HheXOLcnH80s3VKG7A95F+RxcM7L6SCEL7Clv
         IIXvDBlc8cLf8NgdOGbbzGSh0d77HuQJ6LnQXOwZPyfxgU3N7P9El0Kvd6D3eIOaSU7o
         0CJCVvci93WVgZLTPlD80pBXKsExbTsk+JzPQpGXTzPlYNuZDRIVnMFC7qwxwWTJx3+h
         EKKlKFmaFgQzKHn0z03gR2+hWaTicef8pGxebCzPxeSnqSuCKeCIyToHXhQB/2cwqYfU
         76Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWiU/YPWzNQfa7bRd28SdVfj6bLm3mWHJXVYNPYWYyRNs5Tlr/J3ZZrpakL2auUZjnaS6S8FOXzypM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9zGkp7GP0hv7KLgT2a5bSqq77V+73M5nN3n1GtsFbkAkGWzu7
	13FJ4wzbgGY5b1dhzX4AjrByyExbF7Ph4/Xq8g9gVb2AyWayUsiTmxzbTzO87vyAuibHwAoz2rG
	PgDGpFH0LFCuQmdIY5DOPih/wJs728j5+Vg==
X-Gm-Gg: ASbGncsVEgIS8q8PhI6kTy9GsxyCH8+1oQVQK8Q3BRgTqvJxED4aIotMmzwoL5pXjg3
	/MoH5PcFPM/XqZE4GSV0LQdOhE8zUQqsLZsoJePSYE0wa2m9C7LlL3B9xXH8tmqYdr9/z9GMPJV
	z/gitgYWgbrspQg0SFrZM8Opi0Zw==
X-Google-Smtp-Source: AGHT+IEE4kdbqtWhu1/eyW140J2bWFp1YJ3/CQydYvj0ECi7/1q5OIgTMo2Ciyz2biEkauzI7FQs1Dij30N9dPjcFIg=
X-Received: by 2002:a2e:ab19:0:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-30efa6fb163mr4458651fa.7.1743582106246; Wed, 02 Apr 2025
 01:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVX_wQNM9NQeOsvC=OwcqFhfa3=eBoNZ_TX1YVqbxBNMpQ@mail.gmail.com>
 <a9b1ae13-7ecd-41bd-b549-35185b7e701e@kernel.org>
In-Reply-To: <a9b1ae13-7ecd-41bd-b549-35185b7e701e@kernel.org>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Wed, 2 Apr 2025 13:51:34 +0530
X-Gm-Features: AQ5f1Jq6BFJf_vU7d_KkRCrTi0fAJzEGhunVffht23M2xb4p1xndJcaYdCIKA6c
Message-ID: <CAMciSVVw_mQpZ-PVUM8NmVqacK8E_EioHUC-ZzWWgcTX3hCO0A@mail.gmail.com>
Subject: Re: ATA WRITE DMA Timeouts and Link Reset Issues
To: Damien Le Moal <dlemoal@kernel.org>
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 1:29=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 4/2/25 15:40, Naveen Kumar P wrote:
> > Questions:
> > 1. What could cause periodic WRITE DMA timeouts followed by link resets=
?
>
> The drive not responding (drive failing for whatever reasons)
>
> > 2. Could this be a hardware-related issue (e.g., cabling, drive aging)
> > or a kernel bug?
>
> It always can be a bug, but it looks like this is with a kernel version 4=
.4,
> which is really old. Please try with the latest kernel. We do not debug o=
lder
> kernels.
>
> Hardware (SSD) failing is more likely though. Your SSD is being operated =
with
> NCQ turned off:
Thank you for your response. Would re-enabling NCQ (if possible) help
improve performance, or would it likely introduce instability?

I observed that when the system is in this state (frequent WRITE DMA
timeouts and link resets), running aplay from alsa-utils debian
package results in the following error:
aplay: pcm_write:2086: write error: Input/output error

Could these storage timeouts be affecting aplay? Is there a known
relationship between these two failures?

>
> ata2.00: FORCE: horkage modified (noncq)
>
> which indicates that it is somewhat buggy to start with...
>
> > 3. What additional debugging steps or kernel parameters would you
> > recommend to further diagnose this issue?
>
> Try latest stable kernel (6.14). But I suspect you will see the same issu=
e.
>
> >
> > Complete dmesg log is attached to this email.
> > I appreciate any guidance you can provide. Please let me know if
> > further logs or details are required.
>
> The errors you see are timeouts. So it seems that your SSD is simply not
> responding. This could thus be a hardware problem with your drive.
> If you can, try testing with another (newer) SSD ?
>
>
> --
> Damien Le Moal
> Western Digital Research
