Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5982765C4
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116136; cv=pass; b=uHTKOXA0pOMWiB3Q3XTackp+OmmzK/XUCNa68QRpDMoq8FWClvgq/i8PIFspzK3a4naBojwvnI9As0qqoWsW8eBuCdh8idbAnSI/dKkQDagKlUUMo0ZRJI92NarPTE+B5THoKhMUTkP0Z8sZv9ulFG5XQSEWyc66oRf+GhdlXpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116136; c=relaxed/simple;
	bh=0784O/tpAtS5zJvTkZPdbexq01OWWdC2HXhdenu/YvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUKrAAkw+8fxytXwJmc0EYJe69vZ+isX4Iy4Nk0EAVBLqkxNYudVUDSSDa5tlNpf6FVHnJFIO+mQjREg4/fHfHZCUS55dlHV9zDOhrgXz6rGRx4PwX8iHGpgwcBuUMm/LnwmxNVoGd1tKiHsiAXEDpZUlFqJeidiAc5O4zWp3tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJj8l1AN; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJj8l1AN"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927261a3acso4937097b3.0
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2026 00:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116134; cv=none;
        d=google.com; s=arc-20240605;
        b=cePzjwfwJYrRwjObodxN4ychPQhabA/RjXvH/M/CXfeZ9eSoELo8woSHuScWPI5DrR
         5O+NwG4UXxOTrAlKvOjrrDrrZnWpY7AK8hYbprMMQO6ny9E9OzP3wES9+UcUHmdcunVQ
         7qwTK5t6aI1kk2+FEkd9nljTEbPcC05HOsTQhSf9K3FFv0GaN+vBUbXsbmaT5XgQIfl4
         aAuVyswuaJBNmAsqnbfviSMA4qQVsDLSmPu04jUvatjUISDxYmZzwDPRs2AQIXicpwe/
         iea86FoGXGZGq+DDS47nrU7blvkC5zhFPNH5LCajJ8eM2P/ujEPVewocKhkgK/I0CVVI
         1QMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKmzkaRVL4jDP35LShrfmHuRvdjSaSfXuDszsWfq66g=;
        fh=/uhC6SKd6uum8vvK3jjqKiuWhsAoyVI4HLueLgkYaf0=;
        b=GDoHbpgUjgp84wvf8Wjhjp/wV/ySgIxINMLvjYw5nXEHQLVP/vWEB2vNtepD7ThyQi
         X9n+uv5bfKH01jQBW0wn3br+L5ofh6Ce8GTZJmh3R55baSXNNKSjhsvovcUMjCVAjg+r
         9S+WKSeRTbjZ0H5Z1bifOiAjs9zeETsxnJ5zeoKyM9OwKCXOBnL8zCPDZIWjNitejldA
         VPcGESLm/oiH4XTsMGaBWt7oaqF3BbZxvEQ2i3DIsWWMYeCOvT1hOQX6Jt0FmIZxwzYM
         2wHRlfMF6Z/8LPFgzoZg3BOkMJidQLrPKfGM0baEhyNbfm3caYpDM8FvTXY/+eKVj45+
         hxcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775116134; x=1775720934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKmzkaRVL4jDP35LShrfmHuRvdjSaSfXuDszsWfq66g=;
        b=kJj8l1ANl0KzZJ3I6hEhkPbPkknJhHFlvNCOnt+rAe21et7hfmrVKz4l+CgXF9giYw
         k6YVw5eN8b2xiJyNZGevYrZ7fED/h9HZuyQU9XiAmQ/cB2Q2pFp4okIMMph5Me2jzVJl
         QjR6cjhQ5AQSTo+JqYU+0np2bFOfmLWl/LkibxLrppooLpe4UIWNAac7ZrCuXsBSYoTx
         Xm8wLGFKrbU0KfkwEWqqp5L1gsyjB68mKux/YAUXECm3FycP2xvpabDd+ACsGlqB8mYH
         LNoey48m1lbG8P99HVHSVSEgoEUpp7PF3VfgI70vuCI5BDRCpFIPVr3mW8sBqZlrHNYB
         l+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116134; x=1775720934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dKmzkaRVL4jDP35LShrfmHuRvdjSaSfXuDszsWfq66g=;
        b=Qm7NRXyjRzfJyx8HIegtTTmkrxmiP1ZdxvbEbBkgJ+ekSVvkLDrPd/OinB+S1R/7/e
         var7S4G3E1j2MifCQ+DAf3gRgWezoG/wttuVQRRNVjw9LbZyQTty5sFwp/aNsBdJ220u
         OeWYClJXTjOe8nO6K6W4xH+9mlZds9iGZTSZhVy06n65mXefhb+YlKFC33fx/aVMUY9Q
         MjbUimwzMN0GUon2DH39neD8UgeRlJAxTz8xe+QWmQeVCLuWeLk7ud4SVr9sNOmAanOY
         ZbsWIqxgGgNzlvEfRPkXWekqKbNQwawt7mxZTkxWiP4IW8YIzEf8CjNMhpXpoQZKgOdh
         o+Og==
X-Forwarded-Encrypted: i=1; AJvYcCWk9P6u5IMsJWaWUcCFM3Uxo9MIKAGaeLpieHjzZt3o0ePjdvqZRpBWOBjETwKT8aA+yTBk1Txj/HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylmVbCOi6/8QCYyyXBk8pEg5twrNpvP78q+xnUDnIGYciemdrK
	9sitxooJHnPsdT2rnIjUMQ6zh/hekq6NWNfLBZxC4j2mB8JCsTiGkclFuV5tYNtM6Ouyhx22yk8
	bWu7pEJe8A2OuVXcyoMHE6sQj/4OC83s=
X-Gm-Gg: AeBDietLwEYZRUnLBrjJrWS7pkt5iLirtmX0ogNAyRUr35rByQoBQr8lkwdmKy3DViK
	+Jb+UJDSZw/fuC7DNsZpNkFj+YlmLtm9zQ7XAYbntgP4cfGvNvTy4gHUzLUqcDwPLtnUGCiYlhS
	HVNgDfy/WcSD0UFykEhh1OekR2BQ+2fLbfRg4Qnv08nGhIFvkc77CxojEnH7DdoD8ulSjSTEW8i
	5sYvdUPA0tm7s/ybBdzYy3K8pRtwolZ5MrHzFzR62h+Ubb69xHL1PcM7cfsSE0Oy23eoUjbNXIe
	zN0ta4DAnilAA434cT2HgVjnSJOZ9D6H
X-Received: by 2002:a05:690c:386:b0:79a:bc1e:a399 with SMTP id
 00721157ae682-7a211e4deb1mr66814167b3.35.1775116134397; Thu, 02 Apr 2026
 00:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402021027.56-1-hechushiguitu666@gmail.com>
 <403a9722-02b8-463b-9980-e7de32e30008@kernel.org> <CAEZ4rQ8QMQ8q0ev2oSmVUoFw=02Sp5BEqTjzr_=Y+pv8Uk8osw@mail.gmail.com>
 <87f5a30f-0b81-4c88-bd33-c89970021ec5@kernel.org>
In-Reply-To: <87f5a30f-0b81-4c88-bd33-c89970021ec5@kernel.org>
From: Haoyu Lu <hechushiguitu666@gmail.com>
Date: Thu, 2 Apr 2026 15:48:42 +0800
X-Gm-Features: AQROBzAdoxMGOoiRKoCMy5xB_z8lvK1uVfMyTxKyB0Mr0XlYPk7jSeDHNSETi6I
Message-ID: <CAEZ4rQ_c9m=3Ksp15706xq7TtH-9SxF8vaNNZoNj_dBgP7EuNw@mail.gmail.com>
Subject: Re: [PATCH] ata: pata_arasan_cf: fix missing newline in dev_err messages
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien,

Sorry for the mistake!
I didn't realize libata patches need to be based on libata/for-next,
not mainline.
I see the driver has been refactored and the newlines are already fixed.
I'll drop this patch and follow the correct branch for future changes.
Thanks for the clarification!

Best regards, Haoyu Lu

On Thu, Apr 2, 2026 at 3:38=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org> =
wrote:
>
> On 2026/04/02 16:11, Owens James wrote:
> > Hi Damien,
> >
> > Thank you for checking!
> > The function arasan_cf_xfer() does exist in the mainline kernel at
> > drivers/ata/pata_arasan_cf.c around line 380.
>
> Nope...
>
> 378 static inline int wait4buf(struct arasan_cf_dev *acdev)
> 379 {
> 380         if (!wait_for_completion_timeout(&acdev->cf_completion, TIMEO=
UT)) {
> 381                 u32 rw =3D acdev->qc->tf.flags & ATA_TFLAG_WRITE;
> 382
> 383                 dev_err(acdev->host->dev, "%s TimeOut\n", rw ? "write=
" :
> "read");
> 384                 return -ETIMEDOUT;
> 385         }
> 386
> 387         /* Check if PIO Error interrupt has occurred */
> 388         if (acdev->dma_status & ATA_DMA_ERR)
> 389                 return -EAGAIN;
> 390
> 391         return 0;
> 392 }
>
> And "git grep arasan_cf_xfer" gives nothing.
>
> So still not sure which kernel you are looking at.
>
> > This patch is based on the latest upstream mainline branch.
> > Please let me know if you need anything else.
>
> Patches for libata should be based off libata/for-next or libata/for-7.1.
>
>
> --
> Damien Le Moal
> Western Digital Research
