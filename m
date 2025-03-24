Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D414F9FB
	for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 08:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803894; cv=none; b=FTMxi83rdEiiMBeHjOjHoYaSdlDLLgjYAs72dcQHo09iQGnhkJbVCI69Coj/EunLLKswTISFVLkwBGkQJBsevobrcMo3oeZR/wDuya9hSKEMPWoEbFLGaZo6bkjEo3/bNhYROyZ5en8npm69hxcJMJ+u5N9feTlvtCO9bwKeSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803894; c=relaxed/simple;
	bh=IxT+vnE728CV5DHvuNNW1O3OF5i90akxyMV2yXZf7s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmBhoB0XYhImpOpKabFULoY2jMLWXe8PbQEZxp1vHW0+yATgCr4cxmg3vpf/OiGfAB1qe+zFD1OnyD18cH8zjzUEYuGKt/AIWGyEUPOkS28zdHOhRi8M5bc9hpu+KaHFK8v91Lyjnw2deZH2PJDcmuuKFdlq6D1G3rfhmFi7AqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzZ16jIs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzZ16jIs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3913fdd0120so2131646f8f.0
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2025 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742803891; x=1743408691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzHF6D7iEA/JanPswrG1EB47Dn35bVeJXhoVH+eoHo8=;
        b=KzZ16jIs9z5RuzTgsIp/VjzHFQVH8A8THWyWOB5Jd05f+fepLuqEn/UmpltGfRHwug
         fckR4t9sMyHNUzc8oEDPSJwm+jndGQtzXUXQ1iBuPB0/sIiqAG9nuPEWVfoyXXP+x01V
         3IZR8RmqbZBrM5lN0wZpW6Qp87W/qSpaZd8EBRTiSsWCZVb6Q+gW+e8BbUuBav+KhcNS
         bf39wpS7tGxMAhJ9diBnJTwDzd5Zng2YJZPzwTez/HoQC2SdXeHX7tcDVVq2/srPHQSH
         OWOO3l8mYiMX/NE2enlPoEZcBW5gCtxrttBX3z4CXeAAi31jnfhVqzkuz2lKZyUronoP
         fGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742803891; x=1743408691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzHF6D7iEA/JanPswrG1EB47Dn35bVeJXhoVH+eoHo8=;
        b=FLeqoQQpLacl/beZXyBVs5c5JmBcuL34+jVJaxjQeZ9dKi8ftvu4voppAHQhpWQNXg
         zHALmthEyt6AxaT2jr6hmnkbZ42NRO43iapczjqoJl2KdaskZ5MlXNineR6FjIU7U74x
         yWdltMWavDVTg6fRkWDJsNsNAS4VWlAiF5/04nl+EQrBbR1kXbCNgddWE9U3b8Svevve
         4/wI4CO2PTBgbx+jeFC1mfoh7KB2tgn415j5y33JxM/3Fdj1AJcW4VPlaLBUzJ//A733
         lPpWXFLyYK++4bEa4rzrvRe2XGjaKRhVolT6gAlLSBEYRooRJseUdkkKP2Epqt47JI3U
         DeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYmO/NCXe2ovlSvAEI4+rdhtABrYWnR/urCyB1QQN71ux3AG1Xbk+c4DjMfnB4pKXYtcLqxZXFYjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aWX4b1mAHcIzmVD99c0ojrxkStOQx+RUwoKKrT5dvUQ3W4KK
	ggPw/zetKsMXnMJU7soJhKHYNeD747iJvehA3wisNU0i8Mc+o1i8
X-Gm-Gg: ASbGnct/F18MwFsg5COBpaUtqEb13HTlPSiDRXRWdKT1veSWO9cBZNrrlEfWc1ghOOY
	khHXpZSvt0pSm7B9byWofTLmy/5YarPr8jPuiYdbv1bDx1wMBs5j01Mml5JywQnANN9TSofhsW3
	uhv6rlnFHV8XP7AUJu1QqmHOUILWdF/IwkIkms/AUtAlzcSMBNCreZAq/qmKAnaigKTCnixx10h
	wqapVeOkBnjAdygriiqNLP3s5sqPVi8103554yORs0RJunjkT4AZLvdCZxMTnMiSV4LNRi9ef2x
	GvX6PsVjpg+vzB//JxddeB7HaP9HYon+Np5XS1cbers=
X-Google-Smtp-Source: AGHT+IHMm4bghHq3CX0SoXYQssrzigezFeP7OiGhOEIpFdTBFcFh+JTUiUTlb3TSVua32tVywh5MfQ==
X-Received: by 2002:a5d:59ad:0:b0:391:3cb7:d441 with SMTP id ffacd0b85a97d-3997f90d30fmr10440915f8f.25.1742803891214;
        Mon, 24 Mar 2025 01:11:31 -0700 (PDT)
Received: from gmail.com ([2a01:e11:1403:8620:fd58:9303:2c1b:4279])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d42b8fcd4sm99565335e9.1.2025.03.24.01.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:11:30 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:11:29 +0100
From: Paolo Pisati <p.pisati@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paolo Pisati <p.pisati@gmail.com>, Niklas Cassel <cassel@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 2/3] amiga: cslab ata support
Message-ID: <Z+ETsTZviQP9y9Ff@amaterasu.local>
References: <20250321151416.338756-1-p.pisati@gmail.com>
 <20250321151416.338756-3-p.pisati@gmail.com>
 <f9d2da13-1179-483f-a685-fa67d7abd367@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d2da13-1179-483f-a685-fa67d7abd367@kernel.org>

On Sat, Mar 22, 2025 at 09:41:44AM -0400, Damien Le Moal wrote:
> > +	ap->ioaddr.data_addr		= base;
> > +	ap->ioaddr.error_addr		= base + 1 * 4;
> > +	ap->ioaddr.feature_addr		= base + 1 * 4;
> > +	ap->ioaddr.nsect_addr		= base + 2 * 4;
> > +	ap->ioaddr.lbal_addr		= base + 3 * 4;
> > +	ap->ioaddr.lbam_addr		= base + 4 * 4;
> > +	ap->ioaddr.lbah_addr		= base + 5 * 4;
> > +	ap->ioaddr.device_addr		= base + 6 * 4;
> > +	ap->ioaddr.status_addr		= base + 7 * 4;
> > +	ap->ioaddr.command_addr		= base + 7 * 4;
> > +
> > +	ap->ioaddr.altstatus_addr	= base + (0x1000 | (6UL << 2));
> > +	ap->ioaddr.ctl_addr			= base + (0x1000 | (6UL << 2));
> 
> It would be nice to have macro definitions for all the magic numbers you use for
> offsets into base, to document these values.

Thanks for the review Damien, unfortunately the original firmware this driver is
based off doesn't define any macro for these regs/bits meaning.

Other than that, i'll fix the rest and send a v2.
-- 
bye,
p.
