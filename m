Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63015A48E
	for <linux-ide@vger.kernel.org>; Tue,  2 Apr 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081718; cv=none; b=tOdwdYiB8V8eKsmPJJ95OP3z8F2CrklhES/3U9Qd9u1GySmWPo2ruQ3tV9SO9ZK3TmXP5ZeXc8uOAlYjOsGfLHsxaRrxqgLk03XiVTsMvrM+SyHYgeZrogtFQlCQsChauovaKIzvzhbiKeVXe75JYHNawRZOctvcfM6sqKNHki8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081718; c=relaxed/simple;
	bh=YtZLuhxtkoD11sD68OKOYk/ssnpR77f7VcZZNdscLLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDb+SYrv/ZA2qxnZQ68fJm8FF1rB7fLDMM4TBC5XuTWlHEsTh8H4Zr2+Yhumg3ANUNVQUrgWm/qCK7PX+Y2rtBXPVKK0BxX2eg75pWFgY9sADZM/qIpguFjnjkShPYMq02Xb5/ryPHg0VBNZjqTWoC3kFx2Boy+otgAkeS9BWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkLAFe8r; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkLAFe8r"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29f749b6667so3828739a91.0
        for <linux-ide@vger.kernel.org>; Tue, 02 Apr 2024 11:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712081717; x=1712686517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YtZLuhxtkoD11sD68OKOYk/ssnpR77f7VcZZNdscLLw=;
        b=dkLAFe8ryZepL/UW263DG/Df6bTUNm6Z9r1+3x+kC+gWhl7LZgHXxIErOC64fpbsZQ
         6jHhSkO0Eqh/FLCDDFZhPVTBE8WogbgCUBtHnihlyMXoZsAF1IiIqfxR5hSW+40zL63u
         GleT8kqmYBv1WdNeE1BOEB9BaluZozomSjV4XwB6qAc/IU9MYFo4x0mH3G9j39pPEQ/6
         HoXv1+ofkrQAz7K8Z8thXo04Xs98+c3E0RvDLycyINzZJhJ2TQDbh8EkPXj97CxwtglV
         wIJlnztBG7Srb+KB4gFU1oyoUAMsEttCjYiSZbBK1K+5tOB41F/I52z+7YZ5e64Lgayp
         POJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712081717; x=1712686517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtZLuhxtkoD11sD68OKOYk/ssnpR77f7VcZZNdscLLw=;
        b=GI2fPTS92REYXd0rSaM1iRrf73qHniIwf6e6jXWjxObMrn4rgqCTOlszHEgit3+ZuA
         XNSXIObglaNdaTiQ28NRus1DkeT5E+hUhBpF84E8fegSDorDw3LcrhZGcrHJxw+WyImP
         NkXbvrHn6GSGjhcug+73Xuqhr37ZIOVnELVFdKChXtQWBGjJjpK6IjSPRJVd8bZBJ1EJ
         RtSVwe+EJbAMJ+czShpRu0OOVcGsUVrgu4njW/peMNXhhL1xdVOunryui6x5fqV3WxGV
         0IsX0fxDrTuI3KA0oCZ9ficq0K2ivBm+0dIMPHQsgx15P/m4/98qOHpvbYlqjrmYC6IO
         2fYw==
X-Forwarded-Encrypted: i=1; AJvYcCVjDEH6AJP3SjZiG5fZjYtS0oKG4H6s32ddYa85bMQitjlPS+bZbjvtu3xM1DShxm0XB4uLUClsBtdStzOUh32J2PqCmgheuZPD
X-Gm-Message-State: AOJu0Yx19u2292j28ZMaVXt1vwqlGaInQ5PZgK7/NJtvc3YpxNbNGXNm
	oAiB/osjIrvzisiC7fze40FEeguegCI+YlqepgyUrx0wdX0zipXZkiU4SPZZsbW046XPUkoqxvw
	rqJ9ykqODq1TXS36liGfQZdZc4ns=
X-Google-Smtp-Source: AGHT+IH9H/yuR1KPJWldGNHX8552GROqyePrYb9xupR85yERQ1HprNY7tP6EMh2+oCTk7AsySFnDgwVk7rYYmFkk6CU=
X-Received: by 2002:a17:90a:4216:b0:2a0:33c2:997e with SMTP id
 o22-20020a17090a421600b002a033c2997emr11300659pjg.41.1712081716885; Tue, 02
 Apr 2024 11:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALc40c8rRV-mYyXj=a_+j92WKKmdib6Dbw+11i_Y9OYXWBCmwg@mail.gmail.com>
 <Zdz3f4KgAaPKp7m_@fedora>
In-Reply-To: <Zdz3f4KgAaPKp7m_@fedora>
From: Ruben Van Boxem <vanboxem.ruben@gmail.com>
Date: Tue, 2 Apr 2024 20:15:05 +0200
Message-ID: <CALc40c9+ZFnimQ_KP7YpCGgP=iQBeDSS-xPAwwiraeX42yK30g@mail.gmail.com>
Subject: Re: ahci module throws "Internal error: synchronous external abort:
 0000000096000210 [#1] SMP"
To: Niklas Cassel <cassel@kernel.org>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Niklas and others,

Op ma 26 feb 2024 om 21:41 schreef Niklas Cassel <cassel@kernel.org>:
>
> Hello Ruben,
>
> I would recommend you to test with the latest kernel, v6.8-rc6.
>
> I don't know which device tree you are using, but very often custom
> add on cards/HATs require specific device tree overlays to enable
> certain regulators etc.
>
> I suspect that this is something not related to AHCI, but rather
> some regulator or similar that is not enabled.
>
> How does your kernel command line look on both kernels?
>
> Perhaps try to supply:
> " clk_ignore_unused pd_ignore_unused regulator_ignore_unused"
> on the kernel command line.
>
> (regulator_ignore_unused requires v6.8-rc1 or newer.)

I tried v6.8-rc6 and it wouldn't boot at the time.

It seems I ran into an old issue which may have started in version 6.5:
https://patchwork.kernel.org/project/linux-rockchip/patch/20230509153912.515218-1-vincenzopalazzodev@gmail.com/

This describes pretty much what I see.
I understand the solution presented there isn't ideal, but as some
major ARM distributions are using it, I assume it will do for me for
now.
I'll try to use the variant that goes through the device tree flag and
see if I can get a recent kernel working.
I'm also unsure if this mailing list is still the relevant place for
this, as I can't readily find where I found the e-mail address
anymore.
Guess I was born in a different age :).

If you have any more pointers given the above or an alternative
solution that has more merit, I'm all ears.

Ruben
