Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792660657;
	b=B28/w5+Qo7NppLW5gFxm0rOMV3BhYLolwKHVNGMVyy78Hs6nYxOafFph4SOW2ZOMODMs
	 ZIalDkuvUtsWVLxmisoyeMRav31mkYJMxsmw/eP0lPYuITqZ8VuUjmQuULLTSF7ih29Co
	 HlknpeYr5fwgqRcWsuDVoztJLXdmVZNbBjJ+uDOTSVeD+z7N1h82Ltml9YhO1LHzQD6m3
	 56TNwLhg9uzB0sJwex5Iim6urDZTcxDAzQFAfQqMH3Z5zryTe1nC1GDF5od3eQqzZZJTq
	 S+O2lDB6spHPox4wIcUK3am4HQJkVhydii/OmqrCcvaZfkL8wHvOWJ68iB8L/ipn2PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
	b=rdoLXD2stgssNruio9dmpk/K4R3sX+Daxjt/ibWa9OVaaXtlVFOuYktpFH8Is99K435c
	 +McQhdbVkxorS+Tpe7HMKwcq2RKKULcElbLjwN7amIc3xQ/0SvDaRHDMw8YJDEPJBpX+R
	 eqeZzwwXeau/ztsdcqEoZ8JQOpx7LaIb6ZzLOcJtLEn0l1cuN/Zv11bKa6k961jSLKXdh
	 kdBZ2sd6Bjl91GfuiQ4tpVWHmLiJZgTsDC9J3R3Dp7gu4cIMpd5zIpksgVBBZqxIRL4TR
	 AVX+fB8iIKj0bUO4j0YS4G421NFGj4+qeTyL2aQDFaVXAOQScPhMDNZkrKc4lGkFQPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E4606A323
	for <linux-ide@vger.kernel.org>; Thu, 22 Oct 2026 09:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F29E4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b13c7bb0deso9377227b3.1
        for <linux-ide@vger.kernel.org>; Thu, 22 Oct 2026 02:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660650; cv=none;
        d=google.com; s=arc-20260327;
        b=FbdrhsxwEK3XRwZejso2U/ALFxZ+smgBIS003OOipS8OLcigtlfbK/Cm76HBUG9E4w
         zjw+bUpFGRl4UGjV9UIEK1YMpvhrXDwkD7wBg5oulsiZx880M4iKtmL1xt0/c3DIIfG1
         Vznj18IuaFfHqQXKxkAuV6bq7ymvc4chLiFWT+E0ioZ0pJKMy22Ggp2477w0DSWqtzIw
         bddDqIEPmG0tLbELLsigqARQBnDNyanZ6oUMHt3wb7Lx/+pXO33SRC4YX0bKrEtDd6VU
         igZPot7qXWsAS37uLwVx70qIaBbiHbd0ZID8ZqVynTUpsZrTtD/uOPzDU76XYFwHkbV7
         tuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        fh=UQCMb25GX806qs5UjPS+eOYvGr9mvhki3ixgjRyWaIE=;
        b=NNpudNf/UbphvKTRBloedE/EgQxwr+8GPKUQNrQODDg5+5loS2mowKhKgJYKKLfzls
         ZU1YsGh/pcabZRu2fRF88dKR4zYYQ8EstX37RYD2wLdhE53CbsjWjZPjWj1vsrt9iiw7
         5Gma5rRYnP0Zm1vyORAkuyH15KnzOIOn0r6QCU4IHr2BH/uUxO/iIxDht4uLSdPDDksw
         czwMRGe0cU8StQgvi02XZjMsiZ/Ge+B2w8z+tUTA0j9fSGAyzjBcc8h+2F5BQ700NjSM
         +cZuy7JxQ3KWnZcY1nRoFUDYqpv5AsA1kx/2El8OBBoNpnCxwTdc6jRztaqhegozN2Rq
         W1YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792660650; x=1793265450; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        b=QS/VIZ4dgQSENDa+6BaYJAzoA5uVw9/TbVenjpW14qvL7kCWLJmEy1T6yUrMG7IJGj
         b3SCPtOwZwfsm80dgzNO2ImjhSOS7GLSif2dCBM0/YMP3shuzQbXoh4j/pcS1jK0Ja6f
         7zAx/FHVVcFAXfvPrdlute4fKZdAjeL2Zc1Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660650; x=1793265450;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T75Ev+zmY9+TyBZeNfZa9ivEcQCv7sC4JnP+VJ1K3fY=;
        b=EEnQKMnxo1Uhz6q709ypxEJRDDuGuvVXMOHFb7fBkBvs3eyluKwGihrUV8oipjELES
         OviEVrmO/bZ3QlqApjOeGbByRfPZP5P6CEtGdhsaMOqxTWAQiMG1g4I69ZYlI4Fq2oHI
         BpxSBgYsZ+/qyzsGu9wYtGxQnE98kt6Nnrosvdea4gE/5H+9AHy3Cy/8WIUABt9Axzl+
         CljM8erpgt81SP5d/CtIJAXk0MTtmHsgJQCwWg20onkyiXnaeezzRvNnpTYR8GRKS2Do
         oifA9XU6so0zzY8X3T0vii02wEHNc8i/WZJPQKrqJRpPEGLGNGh6korwk5urqezL1A3j
         uMRg==
X-Forwarded-Encrypted: i=1; AKwUvBzayBsAyFaud2U9AODoZDoLotPak2ikbJX5IYqkXDeScz3YfqUON9VBZbqkckRsQkoPtU9nUU/ia4Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJALX/2ioikLoNuHaPbmHaBbpL9jT0eIHOIGJSfM0R3KuTZ1ps9
	mw0JQtL4oF6eFRwL7P3LGkzhFCM3+H9zYpCjJDhaov1/U9J1O/sRDc7W/0boJ/dQOJiil1yUWJG
	fP/jw3zEhHgFz2MJG1nr75UYnW6URWITLSJgCP0wqGQ==
X-Gm-Gg: AYBFou3xf0UfrbQkEZJB4TvyA4pcvNcK8n/5oHmOrFpGh7dQkzgIMSrMEL2Y5t/iBkB
	4ccwbAXylHGoN/8IGLjDcQiu12/g7Rf/sn5PHf9lVm9mzBEKtyWcA5gDMMfkgQhZYW/PEUge/Ay
	/pxDWuZrbUobTlOUtiw3WyPiICKlYvgIdpq2PzJbHjpWQDIT0hzBp6e8wZ574A+YnGWX+48eS5A
	5R+KtRp2nbeK0jc8Q06pce54CUviIb1HfDcyLkl+//XugUmXPLqRH8FRStrud0ULo4WhuK8/b0J
	ksMH16EUOrWR3s3u2wAcEn+rOGbDR1n1rVlGik7FU1h7EJHJ82w0aBGuFwHjOWaC1/ZZzAorJsm
	b+BA0MxLy+FMJhI0OEDF7Ki+5gbHQBLm619rKi2RVZAfGsu0HTLBuJLDMol3Z
X-Received: by 2002:a05:690c:6603:b0:873:5c7b:c102 with SMTP id
 00721157ae682-8b133f865b4mr28955697b3.58.1792660649848; Thu, 22 Oct 2026
 02:17:29 -0700 (PDT)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <20261017041419.311921-2-daniel@0x0f.com>
 <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
In-Reply-To: <3f657b75-64c9-442b-a609-987cc16f5501@kernel.org>
From: Daniel Palmer <daniel@0x0f.com>
Date: Thu, 22 Oct 2026 18:17:18 +0900
X-Gm-Features: AclHuK_xkZziVetz0qA3HvsssgwelX2fb-dhEKVmNQmS_hEtJeTxKXJZsKa-iK4
Message-ID: <CAFr9PXnNKfZtXpBe2OVZvu=rf+fsx5NEp7tSGS_FxRKsL3+wQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: pata_artop: read the ATP865 mode register
 through pci_iomap
To: Damien Le Moal <dlemoal@kernel.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	cassel@kernel.org, linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	geert@linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Damien,

On Thu, 22 Oct 2026 at 16:01, Damien Le Moal <dlemoal@kernel.org> wrote:
> > +     case 2: {       /* 6280 or 6280 + fast */
> > +             void __iomem *bmdma = pci_iomap(pdev, 4, 1);
> > +             u8 cfg;
> > +
> > +             if (!bmdma)
> > +                     return -ENOMEM;
> > +             cfg = ioread8(bmdma);
> > +             pci_iounmap(pdev, bmdma);
> > +             if (cfg & 0x10)
> >                       ppi[0] = &info_628x_fast;
> >               else
> >                       ppi[0] = &info_628x;
> >               break;
> >       }
> > +     }
>
> This is really ugly... Please move the "case 2" variable declarations to the top
> of the function so that you do not have to do something like this.

That's fair. I'll fix that up.

> Of note also is that this switch does not have a "default" case, which is really
> bad practice, even though in this case, we should never hit unknown values.
> But I would still prefer seeing something like:
>
>         default:
>                 pr_warn("Invalid driver data\n");
>                 pci_disable_device(pdev);
>                 return -ENODEV;
>         }

Can we fix that later or should I roll it into this patch? Being an
old driver I think it probably has a bunch of preexisting style issues
that need to be fixed but that seems like a separate issue from making
it functional again.

Cheers,

Daniel
