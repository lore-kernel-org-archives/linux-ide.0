Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC6836B916
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788595356; cv=none; b=ap8Q+fDDkPPkqjIs/2VSBk/Eg64zs1ssBe2Y0BJXzQT1MCSS3yuvf1vgtulwZ6wtUnEWPFskOKo2meVQZjssjEvT48IZww28tbRBnZ7c9psWeEcEZN1DTlZdm1t0zRgi9xEbPtP86j5MDaTA2BqoUQ7Z63KZo+ZHnJmHHFJvYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788595356; c=relaxed/simple;
	bh=R8I8oweAS9knfvlYcgDOolf1C9n809RgicPSKaghaHA=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Qs1mUllzVNnWjxeHcAWFjPXFKmIDY5jZxMXRGmw/F/5JjzTVM+yaZTlgQmysMQDhXE1sZUEtABTTC7frdeZZgJ9CtudVXRjnx3ydVdptju/xsE9hF/j/dpKG6Yhfq/M59Uqa8UzSLvU2psqYKPjK9ycLFOGHE2cLuFiwUlMkl40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6zXG/Z1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6zXG/Z1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1478925a91.0
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788595353; x=1789200153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k4a8kETbbno+r0apC2sHIp95ZZ7jnRlfEcHkEbZMrCc=;
        b=d6zXG/Z1apBsqPr0NiFpJ8qbt90ciC2+Pnk+XnZ8WkG2lXsvPaoZGr4T6CBP8aZoCC
         lkmsrg3PmU9SuNEpEBBMoZV4McIMhwKJL6OCmaelOopyBBBAtJFrR7HKIZikU7Qc/pRB
         G2P54+1Z4OyTtD2zi6Q4aFYDX3OandL8m6L6IKm3BRGnPEZNBb6JM9KxGRFIKHqckWh4
         ezB0yQQlyFTR/ZXgK1JRxjuCYV9dkGfL9PGTW/yi+845NAiUfZxZ890rLy7udSN8Bi/e
         dwBiIpFeyqiu7zi0d7Zymj3/N1zEWzLdWV8PZ4qI+Dnez6yHqQfA0w0pOlo8IFstyEOA
         6xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788595353; x=1789200153;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k4a8kETbbno+r0apC2sHIp95ZZ7jnRlfEcHkEbZMrCc=;
        b=Z+KZExp8BaTff+Y0mHbmLTz8iDyrhX5fVq+pByPFsgLn2RrqU16uUhsmrNz+A2cPQ8
         6RV4fdJqUX46weriBqZZcXowZRDZtP6IFolsXeSvZkGlQzkhBMFHND2BZFDuCHzBasbP
         W3PSPgk1y0AshvZ2IukvLHrXBGhnr8hajxNTRyzmMqrmbDc3OGXA/vmAd1DsV3+tZ5o1
         KWETxGNvywhosc1WhI2AH/v13pNZUGhZrGzKBO4Arki6WCCubxZ19OmyJ1rg0etfHyAa
         PvBhXwup63THRwLV+KAuP4weL+kooN6LjAfUbwMY66NXBhJbcKr+H0Ez07fpp/xA8Ktd
         a0IA==
X-Forwarded-Encrypted: i=1; AKwUvByQjlzGwvzYe2ljrAyPBbvhSHfccGTrIYbRQONXtvvqDWOMuOTPOXoo6ilvzp6Rq9YY8fo8ciKYpj0=@vger.kernel.org
X-Gm-Message-State: AFuF++kCUErcXqJ8v2hkMg1CHo0Jw1xtqIIDyL38XbEdXQRxzKXHURlg
	M+bydooBZB/F01iv75/ebVDaYYXnGyLm0DgslMEFg28R//sZ+BXLR1AhbnN4s5qH
X-Gm-Gg: AYBFou2fdJX1Is1EOOnjHTZ4XUSTFivVhI6slYd8cmBfoXY4F4HIPaAgZTzBCnkKTGM
	y42wbc5vL1UCTYGSW9oFHPnZozxP7Njd9yh0dB3G2vNVlA10We7/YMzGvAhKOuI/72hFjv5ww9U
	YUS5cOIt869ZYtBLyIwYfjRvQlIAE/4y/Kuda2hidGQtVeU1MYLjihMKxau859CAYuzy2KqMX6J
	PMjOON/++nWrT4YFPlPkwLzk6nP1IRfmrUrAAXtpSHZjxtoApUxrhkRRUGaP7kJS3WbyMnsksEo
	3+sKw+s2LLcd3GWGs1hhR7hLin4aDazCDfn7MYsdPzcrOgdXSrNHcUZXG4ZqKygsjXcTNeqTt/O
	kcSGaPAFFnyxMRHpnCYRh3BFsqULb2OGtfuZQFF9S+DeoapUStumIvRPycCET0IU0gCzbDoJBaO
	+0hTw6u1vIaWwAwfceXU9Z0gkXIMrh6B0muvTvWRwrbl339zeG2CE5KEVbTmVb8iAS3rydmo9Xz
	k11w2+WopCtKIgggZk=
X-Received: by 2002:a17:90b:5246:b0:39a:e983:d4bd with SMTP id 98e67ed59e1d1-39b262a3cf7mr18232824a91.24.1788595352899;
        Sat, 05 Sep 2026 01:02:32 -0700 (PDT)
Received: from [10.1.1.24] (122-59-250-182-adsl.sparkbb.co.nz. [122.59.250.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacba5sm15543669a91.12.2026.09.05.01.02.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2026 01:02:32 -0700 (PDT)
Subject: Re: [PATCH 1/9] docs: kernel-parameters: Drop the atarimouse= entry
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
References: <20260905070347.25902-1-kmehltretter@gmail.com>
 <20260905070347.25902-2-kmehltretter@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-doc@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>,
 Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <762382f0-87cd-2148-9846-40448c7b1702@gmail.com>
Date: Sat, 5 Sep 2026 20:02:11 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260905070347.25902-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karl,

Am 05.09.2026 um 19:03 schrieb Karl Mehltretter:
> Nothing in the tree parses atarimouse=. drivers/input/mouse/atarimouse.c
> only takes a module parameter, and git log -S finds no __setup() for the
> boot parameter anywhere in the git history, so the entry has been stale
> since before it.
>
> Drop the entry.
>
> Found by cross-checking every documented name against the __setup(),
> early_param() and core_param() registrations in the tree.
>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 68647ff4bdd2..c8d96de4c00d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -591,8 +591,6 @@ Kernel parameters
>
>  	ataflop=	[HW,M68k]
>
> -	atarimouse=	[HW,MOUSE] Atari Mouse
> -
>  	atkbd.extra=	[HW] Enable extra LEDs and keys on IBM RapidAccess,
>  			EzKey and similar keyboards
>
>

The code parsing this boot parameter disappeared in the conversion to 
input drivers sometime between 2.4.33 and 2.6.18 (my fault entirely).

No one appears to have missed it all these years... thanks for taking 
care of this!

Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>

