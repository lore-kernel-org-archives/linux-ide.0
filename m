Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD013E5A27
	for <linux-ide@vger.kernel.org>; Mon,  6 Jul 2026 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379426; cv=pass; b=WqX+22tC1TdOfhe3Ynqy07gYgSJQe7lQ6QyBOb34upNVLtc0wmoD7mfUl2yI28WdwDX3gPdMup1Y4xjahpVAiRnhTgYosHgS8n8j3AbpF3u3Txs6T3Ux/NshqqIXLZBP3SGu6nOXqpYX39JWZ+ROk8StsVNuR7sc2aYEUs7dI3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379426; c=relaxed/simple;
	bh=lNvgSjfZjJGpuhuqBhYjAFjqSg+H+3SKT0HJ4hRUmZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw3G5weYp1dVGlMLfqRx0ym31W/8MP9dcUj9RatZAqU7zrGYa1aw4+7M0XfmzmT7pUyX8wv6f3VP41gjSmimN2h25noBSmL/a8dfjQX4g33oMN3rqMRBEH1d4WiuXvlFgGOO8ZlnZIpP74Hyn0tgtjuN3a8eVe4toj8Ws5y2mt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fl2wUqCa; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl2wUqCa"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so44861cf.0
        for <linux-ide@vger.kernel.org>; Mon, 06 Jul 2026 16:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783379424; cv=none;
        d=google.com; s=arc-20260327;
        b=F9Y6InZvBXipKK1XqKWORZiGxCNp892764Rcr0BnbUK+GBGA49vXkfYXlKIxYxaZlh
         cDtU9XKlXqr6zTmhFJgPIgDU5TH5crzr3S1uGlzm1yNxpsQJoIKx43ZpFocFMN8313Jk
         ZQUK82RCSdFFZFRRBRCaMDLxDsHLWHZ5PmJJSZMTmeAYIz0LflZzB2qGZLMgB5w9Rc2X
         YKcEnE7vwc/zSyLM5a6s1prZHx0EIkLHvQslWeiZd7oppWCB7VgpDmvOtyM82lAizG1f
         D8rnuABLbZaS5+ckEeDGJULMmR9UTSU4nzwB84o5p1YcDiEkqL5BQvtmacqcC/G1ZhBA
         GcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lNvgSjfZjJGpuhuqBhYjAFjqSg+H+3SKT0HJ4hRUmZI=;
        fh=AjoSq0vcLIoA9Qfo6hvpQpy4OHCe+uQvxjhef7M41ys=;
        b=gC8paKSFh3HZzOntI4g7XTaU92uzxG6otvZm54+rEfh01UdxHG0rzGyCQA5WudZdMd
         XK9vp5OsPKbEPmBTSieYhV1D19cmPpZEaum0ig8LQBQG9XFAc3cDLzqfpGJ12gR4DdAf
         5mk0DFqhwpVQ/WlQvt76SkBVfTLgmyF3LvsDL0sXuJtS4GxQ0lnYUVuZlDPmAX9gm8id
         mGHO8raS37laOrwpE2SNj3XVYpTkX48FswQlpyAf1YKIug5h8ogaUhAdZdciyxTDSu4+
         0KNAcYcJ2GyCWRv0+JYvZcxfIe3Dk9OM65LztNm0zZruwirklSmQ6/TSzTrY1oSjfPUa
         mumQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783379424; x=1783984224; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lNvgSjfZjJGpuhuqBhYjAFjqSg+H+3SKT0HJ4hRUmZI=;
        b=Fl2wUqCaYMbe6BgV6mdRZ+3UtLBPoq/96kNHbvH2k8VGdDmJqrAQtuy6ul0vEOv3+p
         Li6kXMxzTXcrEFBdE35F1rc1rOZftNTiiLR+KdVUIpSNQrLVe5LLceelflqHu1DlLXrA
         eNz47U+ltrM6PSJ8ZYpn82Xy48XFOAiexDQM72nZn5UT5trYhF5ZPqMdHA6SuVodK1Q5
         8/Lur0pXJFdzWfTpf4/xS9CUtoVPMlp0jfyX3J4DGGF0nSn+tNDHFOh4k7LLvDXC13IK
         rDHIV5Q0J2ADz6IQNuRIZeA5RsMPaN9/WwsTqgyIs/CJyXIc5aNj+MAHg/nNykFyL78g
         68fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783379424; x=1783984224;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lNvgSjfZjJGpuhuqBhYjAFjqSg+H+3SKT0HJ4hRUmZI=;
        b=kR+CD4mJOtOeL0j3EU6N0EFxLbthtNWwryKEQM/Y3EHOWzCk/nttiELnFkv+k/MgkD
         Lbz1R8ADBoVF5DjmFt6QVlVmKE4vENAJbenCe11yo5dk6HBuvn+s4wKtEuKfIXFc7+dt
         qkSPB//9kFmnBhB00zSS6Dnw2/eRNsZpsmtzMMp7wvzwhoHQH+gAvZE+BBjsJzWjlaJv
         XapIbSbL7Ov0ZMcBSJqBg+WXpmvP1mf22IiHwDFuRYV+3GPUu8AXxVzsK1idGLe9Y30a
         0nCBw2ZSPVZ+Gh3x0kmO0TeO1RTvoout5loTDfm9NYyRzJjxnB8R9u/AO6ufdTpK4DcE
         qrCw==
X-Forwarded-Encrypted: i=1; AHgh+RqLMazUcpAEMYAMwBjP1T6FJ/kMwhIUp6vr7h+rXHV4tNtD9xTddx9h45cpxXR6Usu9fONgUQD+oCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/yuP4xYoih9BzWxtmDc46hW688a5qLGvAJfNZFmgaaZ1jwyV
	QM+XNLZCiPELkiLUzkXUj7xvba95GTErw8He99zZVHLHejoKCjzSiOuppVjCczE/KDIpdkC7UF3
	L79t1k/8SZhnNif8wOLO96FFhEPdMJJm46zW9wMGO
X-Gm-Gg: AfdE7clnWUdNVHNLTWYCiBbgmAarpPJ8E/x2jT7x2N9t5jFZCRKJJLWLndphUbBXJK/
	8Sfy7vUIBdUiiOGdpvxWxpl1Fw96dwRdlFYsKHoB92EU7/+ZCbf/NMVG6TFVpv4LfBu7lTty5zI
	N0en8IK1t2KaE6dnirI0Id1V8gqdQc26tcboTyzweVqDH5KFoijDhIYR0BJk8ANk08B00PYJbOO
	Af1AB4Z2zMANb0NT+JQwMWft/pkE/IrySW7XymrpU8qyNCvZa6LveFbZz1EOWhCyP/8TuLYUFgj
	UDj4CZg4bcGqo11VTjJk6UUQWFM=
X-Received: by 2002:a05:622a:589:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-51c7b37d17amr402251cf.10.1783379422890; Mon, 06 Jul 2026
 16:10:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702020142.3399851-1-rkaruna@google.com> <20260702021411.B01331F000E9@smtp.kernel.org>
 <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org>
In-Reply-To: <16780c1b-418a-4555-b4bd-d442cedd620e@kernel.org>
From: Karuna Ramkumar <rkaruna@google.com>
Date: Mon, 6 Jul 2026 16:10:11 -0700
X-Gm-Features: AVVi8Ce6jMKCO-Hs7jSWQQ3CmCYH6YuDY7YIAtG2vGLEVIqUCNjwm_dOCW27Wyo
Message-ID: <CAD50Xqp_LBvRqhn0q93s3aVxtfFWGhf42jBePKsUonfE6V=WNw@mail.gmail.com>
Subject: Re: [PATCH v2] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, cassel@kernel.org, 
	linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	TJ Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 7:30=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 7/2/26 11:14, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [Critical] The defensive bounds check `WARN_ON(len > ATA_SCSI_RBUF_SI=
ZE)` is ineffective because it evaluates after the `actor` callback has alr=
eady performed an out-of-bounds write.
>
> Karuna,
>
> Sashiko has a good point here. Let's work on fixing this with an incremen=
tal patch.
>
>
> --
> Damien Le Moal
> Western Digital Research

Hi Damien,

Thanks for reviewing and applying the fix patch!

I reviewed the actor functions to evaluate how to structure this
incremental patch fix.
Since the actors write to the static buffer `ata_scsi_rbuf` defined in
`libata-scsi.c` via the `rbuf` input pointer, the most robust way to
enforce bounds would be to update the actor callback signature to
accept `size_t rbuf_len` along with the `u8 *rbuf` pointer.

All the simulation actor functions (like `ata_scsiop_inq_std`,
`ata_scsiop_inq_b9`, etc) are declared static inside `libata-scsi.c`
so this change would be entirely self-contained. Each actor could
then perform bounds checks at the point of writing and return 0
(eventually failing with ABORTED_COMMAND) before an overflow
occurs.

However this refactoring will touch ~15 functions starting from the
actor callback, until all the helper functions, and result in a
~100-200 line patch.

Before I start working on this, I would love to hear your feedback on:
1. Whether you think this API update (passing `rbuf_len` down to all
actors and helper functions) is the right approach, or if you prefer
simpler, and more localized checks elsewhere.
2. What would be the best way to test all these simulated command
paths to ensure the fix is verified appropriately?

Thank you,
Karuna
