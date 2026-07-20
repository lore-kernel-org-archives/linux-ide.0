Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8643D0918
	for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581787; cv=pass; b=Ntj123uZltiK5zbcsg3IEJv+9TD0CzIV5znZRWdq1EmnPOooQlD10npuIrdK5O138S2sVWjpg3e0MxNHHW/nkcXIOz5iJqriEGhz/xpSKCkqdt/N0sdciCnhDmXr6oVbhkfUYTtCtBJM8PiNuK1spvTwdx1Zxd1Xt75E/4MZ1JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581787; c=relaxed/simple;
	bh=vew5FcyjGcWDOS+kdi73hd/JCwozk3dxZ/5kzmZ6TiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nCYwtwzNlTzGhwMwFuaDLhv6Kot0W5I4Uzpz6GLujW+Odhg/l7ZvofnV8kpqFHSLP7uoNOyEDoCL/GOFl4SnIL78++MnmLSeZAiuV+hgsm+VL5qZBewyKk9hou99PHjxHYUqJRILyIJaLEwQtM9KCiqdmuTNtbj+vncLb8MyP6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky47r91T; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky47r91T"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aea0fff535so8153950e87.3
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2026 14:09:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784581784; cv=none;
        d=google.com; s=arc-20260327;
        b=ap0ZzGm98Ru1zxTbYf4CZCzbSUaUeoGHYYoFxYiXistbFS/FYx2l80BiAH8tuSSxe7
         HUrzLCsTKndvEunvYOTRlx3+0RFRPhcujHtHyK/FA00Pu6rYXzFqceK7yAiWqldBnr0f
         CrOvpU5GM2Aip26ELqsU3MNgo21IIkq6dPIKCtbN0/Hpe9kDHyPUHxysEpNk5Hsnwq8P
         LrL3uo5Kjmg9PzGzuv7v2PPtWUxDvbe0i100hBLmAAO1ie3CTpsj5los9omYff4Q+x/R
         G8tQRzGFGB0DUPkj2OMCV1qlDf5OMBMlQZmDW0U2MGIzXGMO05vHVT1lFIDei0rNfrwQ
         y+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WR8dfrG5Qm4fCCe0c64T+vcjUCz+poh0sjKVwJbpx4=;
        fh=tBk7xIkad8qrTML7xs720NZ7qApWYIvtmmcQwDzN1Xo=;
        b=cuGmIaEnFQSNEhGXhBQyqGbOgELvuQCEoE5KGV0ynEo9HQH1FtZy13x5ZnsAD1+ThH
         1fAOFMJdRTwZu1W+8HXvU3ztmesHAD9ofxyhOvX6Qg/9aThYoh6t5uBNxuGTZwDbmlA+
         I5oamrbwOwOcV/kM0FtrIieU/8VMZ5X2HPfFvjJb5usMp1ucfbR1u0ZHuea1v/ooynhq
         TaJCeRpFWIMEcJjE+tjjnbn4Ox9bmzwlmkeemLJTKB2PPBUB2cE6GLmOMZni8d3x4nVT
         XuJ8hJWPdq4S4vgAAM1XyXsh5rq6kwsbCpMhwdmZaAr/qfSm4B/Njz2jbLsjXf/oHnL0
         oOQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581784; x=1785186584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WR8dfrG5Qm4fCCe0c64T+vcjUCz+poh0sjKVwJbpx4=;
        b=ky47r91TbSTbRf19l6iHjog73pelnTFVYjjW6AHeO4j0GSfaPtkwgXNiPQVyAQ0mAQ
         oqUnZWNYiz6CjIvZc6Oo6qwUbFkZ7kxRnniboFxgklEb8KbY7OGHph6rsMSeRthIEDEJ
         BZTg3OvvbQP0PszdDcIWSt0NiuE4ftQhJcZS0Wi3o0Wk3kQ6U1yMxQhB3lXcr8oNxq3K
         O6DX434rw5kQSqBdxlXZhXN4GRYwreB8P8Qy4aGvGmzWK/mOf5gy+YGOfPQiU7tuflFY
         rhYJKjMU0dtEc6uX0ZvyUVC2Mn/Z9M7NRVwClpk/Li2ELqNCQ5Y/QC7WV60ZfvcnjJLd
         tkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581784; x=1785186584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WR8dfrG5Qm4fCCe0c64T+vcjUCz+poh0sjKVwJbpx4=;
        b=n+n+8+G6mmQAhXJZBy2KKoMmJOGxJWxAE6DfHjcm3aIP5WMSh8KY6hy0nx+xtNyowk
         Q7x28imnR3j8+JoNyCEYfdyTPCcOA8AUnYgfElLFYzGZyYcGxoerWeBmL2dMMS8Vqpfn
         XdDbjkj9NZ3+duYS1cTSPYlMD3eMzpiupvdCJXfaCeYkIVyCxmtaP31jR7r2+8uXQ92G
         ujZ/Ix4r2IynKwtfMWa/F0J5L1gt+uAskrQ+htpyuF+cC+4wqWoPuJMhutjiAVx3sB4s
         bsWWs5RgFsYjfw0pIrIT2dhY7CqR7AIZSYcUxjy7A7Mq0brRpJ8eOkkpcx7P8V1Go4Bu
         CQ0Q==
X-Gm-Message-State: AOJu0YxeuFMBAnFZFX18B5oRzFncjWSRbZFKZNE9wDrqy743CvMcQclA
	QaabND0Epj7tGx5eOE7px47eWpZA0gIkTnZ14XefMO6whZFC6baqS/tL0j9Jz7jFyS5xg5EXB8S
	ueUDL+gaxYJzGjyem0vU4AS0CcjHkoWXxOw==
X-Gm-Gg: AfdE7ckJCVQwc4L74NoA09OGfhTgB+r/NEK7ItLXaCgucwdPoKZmlHKjhNDtLDkEsLO
	G0nLMMvSeIYg+qPgQW5Mgh3kGfnAVhnL6Uaj8qIAtvsh0/5Hn9pdxrjAaAq6RueWNpVaHfMtuzR
	zESSCRjgak5dGVgiktQ9fjMji3wpeX2TO73DQu93r5/aBrEKIcazwi5q6DamJUl2uoiD/0LK0Hi
	iwxvzvEVMdgBJJmZjknwknhvtpOt/RDiV1UVBhaA5Pa36adJz+VF3qEPVeKtB9jnd4bttQ1pJ0K
	nK+o0t3eoQW9IB2ONNZ0NqLGKFtY4/QdZhWt67SstS0eH14clFIuIlNO4NVmkSjwzPgMlFQK2Ue
	1YI037qn8Ph0eBUQuHj7cXD6M9hy9wLERrrixt5XL1P7PE11jkum5eBVlcacQcWxudsd/LaW9
X-Received: by 2002:a05:6512:1502:10b0:5b0:eda:de1b with SMTP id
 2adb3069b0e04-5b28f868714mr2234317e87.16.1784581783846; Mon, 20 Jul 2026
 14:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601183458.11448-1-rosenp@gmail.com>
In-Reply-To: <20260601183458.11448-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 20 Jul 2026 14:09:32 -0700
X-Gm-Features: AUfX_mw2d7HBo9s7tipImAnqmv5zYgz-hCyuHoihuvxeUymjds2FDIBe8vooy0w
Message-ID: <CAKxU2N_Jwq4jqS7ckqBaXpAskeKtu4Giou7ssNvhhV8j7ROxBg@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_ep93xx: add missing "cc" clobber to inline asm
To: linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:35=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> The inline assembly in ep93xx_pata_delay() uses a "subs" instruction
> which modifies the ARM condition code flags. Add a "cc" clobber so
> the compiler knows the flags are altered. Without it, the compiler may
> reorder flag-dependent instructions across the asm block when the
> function is inlined, potentially causing incorrect control flow.
>
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
should I resend?
> ---
>  drivers/ata/pata_ep93xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/pata_ep93xx.c b/drivers/ata/pata_ep93xx.c
> index aa6f8172925d..838cab54d58a 100644
> --- a/drivers/ata/pata_ep93xx.c
> +++ b/drivers/ata/pata_ep93xx.c
> @@ -211,6 +211,7 @@ static void ep93xx_pata_delay(unsigned long count)
>                 "bge 0b\n"
>                 : "=3Dr" (count)
>                 : "0" (count)
> +               : "cc"
>         );
>  }
>
> --
> 2.54.0
>
