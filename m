Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CB1E9B22;
	Sat, 23 Aug 2025 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755978733; cv=none; b=DqNQJhyPxx5cdZ/lIzT74+nV9aS6rxxscFY/4oTki47F/pgngwSmCQ+PMNp40CEeHr/ufMg1R+lElicLsKOdaOROLpNqDuNxPSnPA/u++NDZJ18gzJ7DtY5ECxUTDAEG4Bb6/QbIQZtPN/1yKYcOrvKlUj2LP4MTpk5kVIJbajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755978733; c=relaxed/simple;
	bh=b6ao/xxPWGUmNWThbU3dcZInXNPwtuZ2aciA8jz9EJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPjHb9G7hDTYIUV/zax+Ux0Ab2vLRb8u1BhRWs4cSx5StxOfrwLpGkosWI1TZJXKl0FHB/NoWKJguXqk9kmQUdZTYXPBXFAhV1x4nFqFsE4fmQSomdazwQMpszId1p6RSV71lOl8UlU0OGRM5IVvMtkZ6scrvogjwAeAz/wLzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK10sklJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK10sklJ"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55ce528a0f5so3438932e87.3;
        Sat, 23 Aug 2025 12:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755978730; x=1756583530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6ao/xxPWGUmNWThbU3dcZInXNPwtuZ2aciA8jz9EJQ=;
        b=lK10sklJ+IUcq274z3RujmkqAVGaTf0ujW+FJch0YljJaUtW72rAgSgV0kdSgyxjZk
         wRfOwrLXaBMneTP++c3io6tim5QwV11ssN8hHPUgO/MBbYCjestkBvjUImZdIUP/zxR9
         C1FWo9BMK1bT6/mA/KLIkadmVqQdCvG5lcaNNJcMgyXNc5uVOFQlwEdUkovwYpbS4cbs
         qPsia7fJSaH4ztyeziZCEE7vBBAOAipYFi1uk8R3fYS3DecjjhI4Lkm4h0ZRtK83DBoP
         vUsG9RWIzPrhDPEjA2ff3wgbjAqyD4ka3puS6BrouTTvEwl0VhiWjXy7IOnnkHKZTlS4
         G/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755978730; x=1756583530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6ao/xxPWGUmNWThbU3dcZInXNPwtuZ2aciA8jz9EJQ=;
        b=AfGADj32d7Tka8Y3lOTMPX7ufqepos8xitQfJn4uDViiNrvO23hXEGHZp+zfvukqNU
         swxbutvnFQ/pEsKaciZFulWqSSyE1edh1xHPJhqVCv+F6jGZX+X8xICDUwnkF0+m5pUO
         mjQopUBpajcihAQJeVv/YJpAq8DMKvb475YDmF1UniYp1WeoWch1onbeXl4BwPPZRl61
         D9MkLQafWXdU0oJ5XPy7sdaj7RKW3lwD43haYfkEjPG1xPJcjmQnRTzcp2Wfl8fRX25J
         Ea7YTjpPfJfwb7sWqU5va42Jw0Z0eUO4+G3Zln0Evjf/qqfu1BIiTELIXi7g14H8CJyX
         FSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVkj37m4eVhP9GtOSq0Hf8EG/I/NqdslJCbSdW9fZXTjWCZb2a2BKz5woMRzQx3VcR5npB7Ip2WPe4@vger.kernel.org, AJvYcCXMFURsVXjG/QHHhtGuG2B6nOUlUm+9LvqQVPpt/JfaiuQY0bXgQJQHaIB8Sge1oMmrGbkgZllUbgZH@vger.kernel.org
X-Gm-Message-State: AOJu0Yws4UaVxXSIxIHhaMhX1rRtg6byJVFheVQNgEKKSXw/KB7LSKVi
	CvZjXnu+2Z7KtbW/P2ec6yHKCL4xs2AKbUIMzsNgymF8gvqul0j74JIc7l4IVrn4y+MNLnNWLlO
	EeGGV+Ms6si4EDhB047nUbb91Vklizno=
X-Gm-Gg: ASbGncumsUqbe78F89Kl7qwMF3orCqf6AZ0sA1wSP07jh30tx9y+dlZdoZPMY9V3j15
	nd4vyNcX4gIkjxfgFMackwLFnuoQhk01WyH/Ix9AJyeSz2wwHcaYvGoVfL/ILrIGdfCBAm7drls
	j9v7V39xTC/n7do9OVhgvgGAJ3pICfKcmpg2PtKOjFhNRuSGeYB3AKWw1YUsUJD9IzrG6wg8Pc8
	sH+Scf8aHMzAf25AJWrckE9oMJKd5r8iQsWJNA=
X-Google-Smtp-Source: AGHT+IG+8Kkuvq64IDsQlIP2OZRaUgDmETadfu13CGBRU9moiuJRH4/RpaO3xxJnaix0E3/8Vj2JxqOjvP8l5PtZ7Uc=
X-Received: by 2002:a05:6512:31c3:b0:55b:8df6:ebfe with SMTP id
 2adb3069b0e04-55f0ccfe43cmr2539674e87.54.1755978729373; Sat, 23 Aug 2025
 12:52:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822175830.91682-1-festevam@gmail.com> <20250823-altitude-scone-fe104905ff48@spud>
In-Reply-To: <20250823-altitude-scone-fe104905ff48@spud>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 16:51:58 -0300
X-Gm-Features: Ac12FXzyMcqfz4Llso-gdfdx_Tp2qQ2YGU7hdiuJQIpeDgkHiJQe_2YE-beP6U0
Message-ID: <CAOMZO5Bxaenzy73U1mXQLM4LYaE_B6FdB42saKrzG3pTqETiHg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: ata: imx: Add a reference to ahci-common.yaml
To: Conor Dooley <conor@kernel.org>
Cc: cassel@kernel.org, dlemoal@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:55=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:

> Same here I guess, you're allowing a bunch of other properties now, what
> of those are actually permitted ones for this device?

Only 'target-supply' is actually needed.

I sent v2 documenting 'target-supply'.

Thanks
