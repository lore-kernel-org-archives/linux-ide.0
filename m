Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0426C3BD
	for <linux-ide@vger.kernel.org>; Sat,  5 Sep 2026 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611394; cv=none; b=YEmgoAhVtcSHloynFe+1F9S4zeYP2iyVatzlsFcQxPH3Kl3Rk2z3RNSOoFNa1b1+W3Azyt0Cg76+tAhOYufskUW42CsItK1QU3ziu7wXKYI2rIyemptZLUIyOJv7Zir6xtU7rEYVo9h9EZNcj9jamH2AjQkA06V+CUKCXxlV95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611394; c=relaxed/simple;
	bh=hMg7RJefHBNDjWx7qlSUPFnIqApIedOx+ccA1coGGAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WURxd+l2MrJ34PS/Bse1AH7MMBr5p8DPKA513JQU5EbPEH1joFXZUyL5VK9EO8aKDKFOx0DZMIc9rVvrrJWj4XztUkBmGD3Hp46D6hQcEHDhGT6xMIygCNNKPPl14DjMxpfgFPKzIavTZ6DwzVZePc7vvht8JXKX8BOG35KlGOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUIYRGfZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUIYRGfZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so26060285e9.3
        for <linux-ide@vger.kernel.org>; Sat, 05 Sep 2026 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611389; x=1789216189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IR0+lkethKHvrwCdwLXMATakzMSwaAKd6EpWxgPc0oQ=;
        b=lUIYRGfZzMxbh71ntNcHdfaX7qcD4W21aZLxy5KXsV9jI0WlTJMjwPTfoYUixE1+ax
         8VMCo0qv0LwmCspW/ZecFnFlkVR/KWFcMLPa2gNvG5MNCnXFfHJGsX+HiBRcZJ2ULwdo
         RvT44Vy9q5hmqgqqogM2Cc/pWIFt34PI1TYu6UM1fZZKQdezEwJ0jtWE3CE3gK1KDF8S
         3s9Z4ISt+ScI0rYlwygCxRJXM0UkOQIvcunGyvlinYZKEdEPhUHdzXkfTsnhGqdCHcCY
         2XMYd2un7S7NmKo52rrnRaQq+5CXgSSsvwGK0AMrnk/flDzw/NIk2/cvhhGqIXR9IfgN
         SBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611389; x=1789216189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IR0+lkethKHvrwCdwLXMATakzMSwaAKd6EpWxgPc0oQ=;
        b=Esy8/KVyfoAMuNGfoewE0/rnj9xfiLsTVAyNaExNkZF7Je96wmaurMV/RP9PWsLvH9
         DFS84lWAj5R9vS6KnX9BUr+TEC5TjeDysw7HTEpyOqyYohkJqfxvcaDHtkgwaeuqdXH7
         yZPkgchC6zk5C/5JXQ9KncCOeR449GSPGxUB1SNBF3T4RzkRLlEhdBJtcQ5hwf+S2pEl
         Y1nfDTT7YHl9p55MSfwGf3gvr0etJj4b1NQ0BOk/+qORwojm05Uf/FnsCetPhpDIjoZe
         Nr5wCUGkN7BBe/9Zdvs3p8+LXdW+6p3ooUwX2MPRjdjATW1l6ovTWzKGwKrBsHxZK4bN
         cPmA==
X-Forwarded-Encrypted: i=1; AKwUvBz/t+wx+4/USwtTkMVKPkVxcwmmNHq9BJeg2ygPMy8l79wq9PZzNPOa/fmcZbBpgUgcyTlWtIhiqZY=@vger.kernel.org
X-Gm-Message-State: AFuF++ld0Ic3NVBfag9RPsyLx9pm+aujy72FQ7+ag6wzOSs/GQpfXxv0
	2bkseNQwyhnwbfkazj5MBhme4LJm80nfXAUdY/JiiwmfvBmQSphbL/hZ
X-Gm-Gg: AYBFou1HtO++krPpxs4EI4H6+xwPaw/ZOFj0cen3emRdyuq9EjWKIC+mu3AqiqTUVgP
	iUmNqh9F0t/UE7qAPLwfxxHvmNjBMJ1OsNNuc9oYIZ/tKa7zNys2gNvxm8yT/XZKoIz7Z0Q9Oq7
	2cHyt7Bu3TWZerU9Ty0ikewPQe1vvKBaN/vBJCwUoUoX5mgOrqYO+w0Cm9cZzIlbPHM+fpYnlJC
	bGstK8DHtg2VmpIY9TBuSabSrW5EDZHGKJM1hHOXdEYIpoAHQCYsfL2HBsH8xawh5XrCI6FWlMl
	EZZRknCNJQAg0nXSGqMqpfo4hhfMSjMx/V4GpcjI5juaaCXi7RZBlmRCFUyveUbVnYgM3QIW+93
	m91ON92PrLoPaNFqPV7+lekxMaMU4dk2HcsH1Ig1iVKTqleJQzzit5EPW7gsxaFFt6Q5Ht3h8uX
	SQyjKkmkhlmTfDJudncTG1j+i0WQsLt1udC8jgcqmDUw8fwgEgd7/bsOMYMFH8os8u9SK6BpPBM
	jJosAFgPpeI9BGZh98JiH/gL65wXsJFzXlT+VGmA54BcXADCU7btxinlYaobkriTOFf7EGrqY4c
	HfsXkOm04VSF6c8fNANi7EUPnH4ePTvOzWWhOUMv1X9mdH+HhCttKc5TafVJY2kU
X-Received: by 2002:a05:600c:3495:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49cf8244bc5mr116977535e9.7.1788611388275;
        Sat, 05 Sep 2026 05:29:48 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm118555475e9.11.2026.09.05.05.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:29:47 -0700 (PDT)
Date: Sat, 5 Sep 2026 14:29:46 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k@lists.linux-m68k.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 9/9] docs: kernel-parameters: Drop the pata_legacy.qdi
 and pata_legacy.winbond entries
Message-ID: <apwKitEmOv3ZwLkd@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-10-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905094649.41996-10-kmehltretter@gmail.com>

On Sat, Sep 05, 2026 at 11:46:49AM +0100, Karl Mehltretter wrote:
> pata_legacy no longer has the qdi and winbond module parameters:
> commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> both together with the VLB controller support. The entries also refer
> to CONFIG_PATA_QDI_MODULE and CONFIG_PATA_WINBOND_VLB_MODULE, which do
> not exist either.
> 
> Drop both entries.
> 
> Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> Acked-by: Damien Le Moal <dlemoal@kernel.org>

This one is actually a duplicate, I just found out. Ethan posted a more
complete patch in June that removes all six pata_legacy entries which
commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") left
behind, this patch covers only two of them:

  https://lore.kernel.org/r/20260607064053.195166-1-enelsonmoore@gmail.com/

It has a Reviewed-by tag from Randy, but does not seem to
have been picked up yet. 

So I suggest: drop 9/9 and take Ethan's patch instead.
The other patches of this series are not affected.

Thanks,
Karl
