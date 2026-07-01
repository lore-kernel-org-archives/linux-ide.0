Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A81339844
	for <linux-ide@vger.kernel.org>; Wed,  1 Jul 2026 23:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947825; cv=pass; b=HIptfbZgMCURZuZzxDM+1T0Lpz7lOfpKA93DGfZqQuqb7zlU/AlV6H+zrvKglZa6ZcawZDhG9NECUaK6x2hekypKBanHUSMimc7nayOYuIXX/aS7MJtVg2jaNbk7GJdBDIuNHSKzBEZd/3IZq+2Ki5iPmV5bIeF29GLhdUpNEbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947825; c=relaxed/simple;
	bh=vH6SOBXpJo+kBAUL92IXO4pioH8PXNVJdVS/o8dO/bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4d72galSJ3VjdOr+7jEOSZGQK6Hr+sfFaLlG6Aos8burwtmnzOb1MGqSCzGhN9AZbJ1Pseec8wjKPMvLO66V17ynk85b9MpgI7F9ymaa2+4BDNQ8XJBjebwY06xLrJI/uHp/CvSqwl/fvKuuoyumZKvzq3HhO1Jqe9KInCardI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GAANZgUy; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GAANZgUy"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca265d6ca1so26155ad.1
        for <linux-ide@vger.kernel.org>; Wed, 01 Jul 2026 16:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782947822; cv=none;
        d=google.com; s=arc-20260327;
        b=Wt4I5780O7pPQp6jdGcctPQZIAGDv6dCud0oy4ETV3haVH7BHL3HQs9IrNdf2Fa7m6
         i+dTIGjj99mEC8MOz3rsDvekxKFh7xMXf8NZRzDNgC/msndBbHw4+d4tjwgXXhYA5eWh
         4Cj+vLoBZhw+099zF8rFND7ePorLLhMF2psKfjY9yGFBKuX6qXHqOuv40h9eaW2c65CZ
         FEnuc/0Oa5VlM36588n60MKAl6MhpwNNahe9vHgrXjgWrksB8BQtLtV5NiIhAbZhxjwG
         vxRsJtqQZCIX6brfNhGXk5Ihes2xVC7BoSp2+7kEeyrojDlStsujJMInNsmSSpW3tbZl
         H/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=53maIzSEtiW5VuGbxFvHNioORjurdzX20Kf/npBKMX0=;
        fh=oFiR8/+joOihS0KNJOiTKsI820HLc7FDUvn4YVHTrT8=;
        b=IzMWGYAy0JUlr0I/Hd7JrSWklVsV8/lcxPZJ8k0ddK7iDqGIrlJMuvtGpyphVZYOxX
         gPOQ+CANgQU6yZsP0QUBiK6AKqyOpRxIzubjOljyfmcZQ+uAa1tzVcEZg8yMFO8WCWe5
         U2KlaejK8irT3wMGZpq+O9kFxSTS2iupqTwG1iOtjYyBhNZQXhwbqhBMyfhh7M7QYy/N
         tIc0LyJg6sFJm+5uLR36sjF9HezhnCFxBbasLzq9GwCSDoYFcBjWwIHMUlc3aVNgQzh7
         Wx+wQb3y4GTb2EjRrJFKR5qeCq7+pg35vyZnikCFslbN8+HWuE8AQkHMb6KItzhvcWY1
         AbeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782947822; x=1783552622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53maIzSEtiW5VuGbxFvHNioORjurdzX20Kf/npBKMX0=;
        b=GAANZgUyix0tsSISu1UtwMs75iSCbNlQUajRlRH+rj/yMDhwHv3Rv1SFm1gKNXXypz
         C5rmtd1JMRRFdNkKf/yUnkRsLz0Jze6ng/CILOur5gfWlC3OFXAy2PWtOP26halUcyAP
         Cg44tJqLuy/ulT+PG+hexee8BENJzTtoDSqVTy8odNeFoFcwrIMwTFrLvubDAna+V7fO
         XVk19Ohuycjf/lnCG/cGPKwVqnAS31cSfndSy/Ylm9t0fvoGp6OtuFlQJGDZdBSnhabx
         /bzBlN84An4LWOJzX3gzDL37dD2OdI2FVqpDg4yIKtIeKVKcVnFv5wyutHUpoFCFtz3O
         S0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947822; x=1783552622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53maIzSEtiW5VuGbxFvHNioORjurdzX20Kf/npBKMX0=;
        b=E3MCtTyGfKbsfPje/rqHxOVLD3/Ygrewaw4asvq5yIfRlSfoJl/EAEnQiGlZuOH+7a
         947NSM+wURb+S+Wab1sFoxP8h2exODkuhh+Lp0zB7XjeIAPtfTTdhx0vDRKBbTcQJ2gn
         CphblnryvDUTr+kgdxMnpvSVlE8L1w77tlic9a9VVbhTgS8onBYL7+1+KSorRrXdqyaX
         SFO9p72I4jBMZYJoJy3TZQahyPEXi/2vKwNgLZWO2HdqMNKpYi2JcwLvUU7qPPiJghMf
         uzZKkd0owAWX71M3M7OORpj02GeBYc+9VP3qQhgEjicJzx2WSCCHCTD/ALXt0nDrtU8E
         r0fg==
X-Forwarded-Encrypted: i=1; AHgh+RrypBZL/LUTyRrZ+1U+lr3l2QkV3y1SHNIOpJYF1z1FthHkHxJPya75pZeApvdCFFI9JCNKf+47tt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfABUsgT2qZAVvlW4JeuTDOzxmiUH+8OKGdKRd6zcdmFE36jRG
	JYCBkzqsndyJEODV6/LoYbmiY0rH4u1zzxxGBGTOxta7w/S8ok+2wKd4h10dSoRGaVJ4KHJFI/n
	c1nV/Egfg5AYLPyHp7CK4JJd/5Scd93IC7KfZXbNF
X-Gm-Gg: AfdE7ckOmvHlcoTV77osoFT1H+oAWmzvUynvfdwPSzuiGYZeuY+2Kf9zq8kLKoJhT/1
	LxmO1R7yAD2wnqEbRj/AJ0A9XsKTtOAhIU3SccrdcUF1+uCicLLfh9s7uGFhLL6zZAV5mRRBUhw
	gUq/m2WYTrKy4ABX7Smxhx+g/C+oElNQGXKqzXhCi8bxLFo9GGRkhezvoZaXihLsWUeNjXTY2Le
	7bdtfjPlY7GJT7rYiyGpyzAL+CNzkPhSZS6asGlKATYFzqDlaJhqEe3HtCKn7rf2zERyMcFFhA/
	BVEHCDzq+9aXXuw95xieT0zY5Q8=
X-Received: by 2002:a17:903:178b:b0:2ca:e3f:6a44 with SMTP id
 d9443c01a7336-2ca4487f0b1mr68937265ad.1.1782947821825; Wed, 01 Jul 2026
 16:17:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622182844.2795777-1-tadamsjr@google.com> <ajvny2mkowNmu81Z@ryzen>
In-Reply-To: <ajvny2mkowNmu81Z@ryzen>
From: TJ Adams <tadamsjr@google.com>
Date: Wed, 1 Jul 2026 16:16:49 -0700
X-Gm-Features: AVVi8CdREKMrCULaPH08j44TabWOlzQCBv2BDhxPS6NTSAcWxPaLN9Ym4VGJ05U
Message-ID: <CAL54JgfakNzRSe8QosjAdBtQnDpiJqjOYFZvuOPjM1RphKEw4A@mail.gmail.com>
Subject: Re: [PATCH] ata: libata-core: Allow capacity transition to zero for
 locked drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Salomon Dushimirimana <salomondush@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 7:21=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
>
> On Mon, Jun 22, 2026 at 11:28:44AM -0700, TJ Adams wrote:
> > Commit 91842ed844a0 ("ata: libata-core: Set capacity to zero for a
> > security locked drive") introduced setting the device capacity (n_secto=
rs)
> > to zero in ata_dev_configure() if the drive is security locked.
> >
> > However, during runtime revalidation, ata_dev_revalidate() compares the
> > new capacity (now 0) with the old capacity (>0) and detects a mismatch.
> > Since it does not consider the locked status, it returns -ENODEV.


Hey Niklas,

Sorry for the delay in response. I had some difficulty recreating the
issue outside of our specific test suite.

> Please explain how you reproduce this.
> As far as I can see the local n_sectors variable will be 0,
> and the function call to ata_dev_configure() will set dev->n_sectors
> to 0, so this should, AFAICT, never get a "n_sectors mismatch" print.

Here are the steps to recreate it:

```bash
TARGET_DEV=3D"/dev/sdy"
TARGET_NAME=3D"sdy"

# Lock Device
hdparm --user-master u --security-set-pass TempPassword "$TARGET_DEV"

# Disable SSP
sg_raw "$TARGET_DEV" 85 06 00 00 90 00 06 00 00 00 00 00 00 00 ef 00

# In another terminal set active I/O
dd if=3D"$TARGET_DEV" of=3D/dev/null bs=3D1M status=3Dprogress

# Do an active reset (then wait for scsi eh)
echo 1 > /sys/class/sas_phy/phy-X:Y/hard_reset

# You can end the dd command in the other terminal and then run this:
# You should see it fail immediately
dd if=3D"$TARGET_DEV" of=3D/dev/null bs=3D512 count=3D1
```

Some things to note:
- Disabling SSP. I had some attempts to recreate the bug but didn't
  realize SSP was enabled. I would lock the drive but on reset the
  drive would actually come back up unlocked, masking the bug.
- The active I/O. This is so there are I/Os in flight whenever the
  drive gets reset. They should timeout and then trigger the error
  handling path which will cause the ata device revalidation. Without
  it the revalidation might not occur and you might not see the bug.
  I also experienced this.

> Since you seem to state that the old capacity (local variable n_sectors)
> is > 0, it seems like the device wasn't locked during the initial boot /
> ata_dev_configure() call.

Yeah that's correct. To recreate the issue you should boot unlocked but
lock at runtime.

Also here is a dmesg snippet showing the capacity mismatch:

```dmesg
  [76834.784699] ata36.00: status: { DRDY }
  [76834.784708] ata36: hard resetting link
  [76834.940530] ata36.00: supports DRM functions and may not be fully
accessible
  [76834.940537] ata36.00: Security locked, setting capacity to zero
  [76834.943566] ata36.00: n_sectors mismatch 15628053168 !=3D 0
```

Let me know if I didn't explain something well or if something is
missing. Thank you!

Best Regards,
TJ Adams
