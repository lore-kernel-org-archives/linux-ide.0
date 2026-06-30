Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0966F156661
	for <linux-ide@vger.kernel.org>; Tue, 30 Jun 2026 00:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778776; cv=pass; b=Ck9zvNXpJf7rJhRrwOHfZjhBAjKwcR8t3Vy7I0EnlNVJ53gYmmCdx6hMhg64gb2HLoo5bItU3ivNoB7nora90UHyiGuEfMlIPyU7WWtABQGv3jR6VG6tcS4L0lu2+j7C8iPj/I+L+Ksn4tilGh39T/KOdc2TpVU829o/q+BlBDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778776; c=relaxed/simple;
	bh=HGvYwU9V3dD/CzkUN6zFSpWRlS7Dsk4z2AJwme3bvqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uag+bJJLdvTtN85GcmGaxil59ynExLhoHU1ZPxuX8WToOgdCWjb+mGvrvPBcwpQx1CDIC2R2tHG5bKe8VKymaLcdKdG3RaBvBoX376Quy9965EZ7loTGA8cigyb2QmSfh7fAnsN5WyvMVhdDxQhEerRGisOHBNF3rJS0bgpMzj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pL2UcIZe; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pL2UcIZe"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c01c79467so109161cf.0
        for <linux-ide@vger.kernel.org>; Mon, 29 Jun 2026 17:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782778774; cv=none;
        d=google.com; s=arc-20260327;
        b=oVObS2mrPL8TrvdDOlkqOF9k6g+YVgO5Zx+xtQhlyFoyfXouI1ZoyBBnuqAOsw+29l
         85xdfWT/87KXBpA5cF7OqbskMCxGunPTCeeE6B9IbO6A9tkEKL0KqW7+st9LWhEpM2On
         stBz5cdaS6qelcVQFa5Sz9b0ZYTPJ8JEi+B62W+irA4TTwXv2RXJEeSpXPup3cYnbZEk
         tZFR5WWkvPQ4RJCFL3tO9QpAKLUzEaaImI0yythU6MozeqvrGbt3VeV8x3nd8fWwZWG3
         4FSaILC224SCSUc3wiiMimsjQ1PtzxijrVZApGuPaVE6J3WSakdayhgmpTFqTRESmbtk
         VADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZMcIIqezzVGNpxljy76mLVFVBYL2F1MV5LGm0BXeNY0=;
        fh=SpKm+QNyQiWH+NRVQZFIPRiYZxSwyFH+6I45t4v5DHc=;
        b=ACpDSnhPPMvyGWuGFVs1RpissWzzVnwLQvaE0Pt4VqKunJ6MnMHdu9acUMnh7Ka+Ai
         ETpBJO0EuNbj8s0mH993/X2+OJOyLz5aT+lPedO/Y6mQNyYibg/henpHjsdtQ8YIy4qY
         kiqgr/ivQsP5Mz4MCRh9upFzC0xweU+JRIBtE/0fyT2wGWEV62C+k+8KjRuugG1qs9BM
         Vpw3thcVGr19bqB+Hhs5kt0CfLiS28mnJXZ+LskI4aBbhYfZZhFyQWxUsfHEAkhmvAJV
         SnR/nJW/HrxJ9zRK/M3vCdL3zQcGtqLKrweWFxBI4RO/799HRy4kZn96K/bPGKFmhuL1
         IVrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782778774; x=1783383574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZMcIIqezzVGNpxljy76mLVFVBYL2F1MV5LGm0BXeNY0=;
        b=pL2UcIZeZImZJ7JECzMb5ApnzqV66o3Hhdsxsct9SAXla/ZqUkxthub9Z3+bZiBudb
         r2+mSZy4qqZ0maCar4h5g1RXTpvbTuJB0Uy3+4S5i9C115wtTKjZgAWu5pRxK1djgP8t
         XXtdeM34M73UbQEQbinyJ4J+JjP4FS9x159OKMs7k1aocjWXm5nJlVqHFL4tj/lEfvRu
         AeeKut0C2oWWxJJCofowcJeN6X45mTkkjRAiOFhluWRwpzhzeQJHcF2ZkvlaJ1I+JEeP
         lYnwslqYBkD9dcwaGpeGxm13aEA0srjh9hDocHetSLEbGUtARn7bT3ccSbvgLp2KhX58
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778774; x=1783383574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMcIIqezzVGNpxljy76mLVFVBYL2F1MV5LGm0BXeNY0=;
        b=kpJSR9neBhpNwN9AvPSFppsI6yOzijpluSp7QjeLsdDMbmdMw5WEOv9TIASaPS306N
         1bIdHfOsxfJwzVKUU/XnjVEpmMnU/z9eZOLkYWyWc112/PCeYXVD+4xd1VgQNHt3p/sP
         WRhONOgwpukrcDH/JY6QGU470UElQ4YYMymjKtDf0nq/3u3CQGc/14x4UDOGYNps5l9w
         mWclSmvvGMQmhkuJP+f3ZbMjyjDQQRxdZEoKma2akw0lMOxkFNjBqtKbS8cLAdw6MSDQ
         Bo0RJXfI8Kl9HMleNfAy1lvuIHtLI63SUv5llDOW75r1F+JEy0VvBAr3O5pZNtwOgbcr
         iMrw==
X-Forwarded-Encrypted: i=1; AFNElJ+Z9lnHmnTDwkkL7BaMn3Z38yfQuPDu+75zLAA8dhTYeQRcE+NWOyy5J/Dda6hc/xMTtau5krQ4x9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KzQRLnHKU2yBBaTfJQKJYTft6EZbKhtj0MAj+aHJqH3ayhkf
	PsbfR5XyxKR3fm094Z0F00oI9oMRStzVGLPnjog6h3PfC/TwYJL9OCkC5WBDTojiTQPdJfMjst1
	hnGwiFjg9z6gpGEAQFQqppBcpsyeGuyA0hTAX4Q8e
X-Gm-Gg: AfdE7cmjKJ+4UNbxdUGIIE5WM0i49AGkEbT6TEn0pVq0GCp44o16sGiPOmFNenGUXu/
	jcOigmF9K9G6PrxTDvtSsXchFE9KHWDOR/szZsr0zceYVYxotcudqysl3D1qPengNQX+ksRv2g4
	Gvh5z4gIB2qDUEfWZmnd7d+lF2Nps/CivjzChinXttcZGBCwO+ELBVuoec2ESIr3tZfr5GouhHm
	JmjShQ55DPsBEpBujXv2X6gAfEZ/ipG/svMO8YP54nXB05s1aeqwJbEfKVFOo8jcDIS/iI3rpoq
	z/Uxkc4VjEN3Pp+7xUeQY4pDG12xOw==
X-Received: by 2002:ac8:5908:0:b0:51b:fd21:c077 with SMTP id
 d75a77b69052e-51c15c609bbmr354961cf.21.1782778773301; Mon, 29 Jun 2026
 17:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629175024.2187500-1-rkaruna@google.com> <7bef0564-e263-41de-857a-03ecbacc789d@kernel.org>
In-Reply-To: <7bef0564-e263-41de-857a-03ecbacc789d@kernel.org>
From: Karuna Ramkumar <rkaruna@google.com>
Date: Mon, 29 Jun 2026 17:19:22 -0700
X-Gm-Features: AVVi8CdaEV0Xdl79h2YnUt6zZX6C9Qo3bv0esN2xzuql445gxOd9f5Ldrtw1rfc
Message-ID: <CAD50Xqr9YKCT8Su55D4qWq4cy+sVtLRJhS8z+vYQkhsZH-oacg@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-scsi: limit simulated SCSI command copy to
 response length
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ipylypiv@google.com, tadamsjr@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback! I'll push a new patch failing the command
instead of the warning.

Thanks,
Karuna Ramkumar

On Mon, Jun 29, 2026 at 5:05=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 6/30/26 02:50, Karuna Ramkumar wrote:
> > The function ata_scsi_rbuf_fill() is used to copy the response of
> > emulated SCSI commands from ata_scsi_rbuf to the SCSI command's
> > scatterlist.
> >
> > Currently, sg_copy_from_buffer() is called with the size argument
> > set to ATA_SCSI_RBUF_SIZE (2048 bytes). Since ata_scsi_rbuf is
> > zeroed out before the simulation actor is invoked, copying the
> > full buffer size causes the remainder of the SCSI command's
> > transfer buffer (beyond the actual response length 'len') to be
> > overwritten with zeroes. This clobbers any pre-existing sentinel
> > values or data in the caller's buffer tail, even though the
> > correct residual count is reported via scsi_set_resid().
> >
> > Fix this by passing the actual response length 'len' as the copy
> > size to sg_copy_from_buffer(), ensuring that the tail of the
> > caller's buffer remains untouched. Also, add a defensive
> > WARN_ON() check to ensure that the actor does not return a
> > length exceeding the static buffer capacity.
> >
> > The fix was tested by invoking an SCSI SG_IO INQUIRY on
> > an ATA disk on vanilla build, and build with the fix. Confirmed
> > that the input buffer's tail end remains unmodified with the fix.
> >
> > Fixes: 5251ae224d8d ("ata: libata-scsi: Return residual for emulated SC=
SI commands")
> > Assisted-by: Antigravity:gemini-3.5-flash
> > Signed-off-by: Karuna Ramkumar <rkaruna@google.com>
> > ---
> >  drivers/ata/libata-scsi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> > index d54ec1631e9a..0ddec111a78c 100644
> > --- a/drivers/ata/libata-scsi.c
> > +++ b/drivers/ata/libata-scsi.c
> > @@ -1933,8 +1933,10 @@ static void ata_scsi_rbuf_fill(struct ata_device=
 *dev, struct scsi_cmnd *cmd,
> >       memset(ata_scsi_rbuf, 0, ATA_SCSI_RBUF_SIZE);
> >       len =3D actor(dev, cmd, ata_scsi_rbuf);
> >       if (len) {
> > +             if (WARN_ON(len > ATA_SCSI_RBUF_SIZE))
> > +                     len =3D ATA_SCSI_RBUF_SIZE;
>
> Yes, it is good to add a warning, but if this ever happen, then it is a s=
erious
> bug in libata-scsi and we should fail the command rather than return data=
 from
> something buggy. So let's do that rather than just warn.
> The other change below looks good.
>
> >               sg_copy_from_buffer(scsi_sglist(cmd), scsi_sg_count(cmd),
> > -                                 ata_scsi_rbuf, ATA_SCSI_RBUF_SIZE);
> > +                                 ata_scsi_rbuf, len);
> >               cmd->result =3D SAM_STAT_GOOD;
> >               if (scsi_bufflen(cmd) > len)
> >                       scsi_set_resid(cmd, scsi_bufflen(cmd) - len);
>
>
> --
> Damien Le Moal
> Western Digital Research
