Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2021F7D3F0
	for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843295; cv=none; b=erqWlan7y71FXgv48Pmswsu2K4TwIA3rqMoA80PUgZaeObJL64E2gMCuFP/Qy5je/+srPLF586GMbsQ3QpfJqpqV/CWNCXx8sjQBrQNF0imK+Au21qtaNAjwa3aYBvlbCTA0PIycQLDgbU/RyjfHD/EbeJAvxXRAO8/5knxm3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843295; c=relaxed/simple;
	bh=8N82lj09vg3Uwpae39A9uxoWnVNb5hAv812MaYzEZzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzzmmvYC/G0bMgnyhngDJs+72qBrGtaN6Eq44p6GBKvc2yxkjdZA8eMeY4NK06501K3YcDaJwTuA7JOMOoFkA/QyXfG79y0FTbF2pw4oFy0jirF3E2BueWttYNQXLAxbHk4l0Nh5mNrK6O2hegLPI5JYs4sZmHmDFFC/g/Q6c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/3MKqRP; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/3MKqRP"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so6759014e87.0
        for <linux-ide@vger.kernel.org>; Tue, 19 Mar 2024 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710843292; x=1711448092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuabKlIuCM1rlCLNo16RAGbNdGcA1yqufLiihN794Co=;
        b=K/3MKqRPI1QasEzXRy2lI8Pn+M5RKibSn/JQoJkQg1QrkT/txiWiUWDcxzxxGxqsbS
         Xpa4lfEczHVOLM1ZyeuiZp6CkCQC8xei3mQOr53rOF3vY/h24iCpjVr/hpEsUNUTlP2k
         X4qTqliLDoOerv/z67j0tzcY8wql6Lp984vj7Hulgi/kf3mR0VptXZn1vI/oARMM3aoS
         FIGm4AJTAf81hnwcBiJFMXelIUcqoBBx315ClHh0BP21T+X2uyG1GQ1eA4TT8kRCNKAv
         RIyGnPzff7ZhZ74ujMBR8Ap/nXAyMr1bD+Q7AkMrDxYgD6cT/ifdBhJ2YpbwvSEEq83P
         21Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843292; x=1711448092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CuabKlIuCM1rlCLNo16RAGbNdGcA1yqufLiihN794Co=;
        b=us15PbO8TKf16a20N7aW7m6sJhzZXYeNG2q7u+flCYsDh6jMmW3/NSq+GHlftHA//F
         lU3jr9NW4/jNOTOPzArZtygD2BwE+zpl8q+T4padaQL8FG1LbKEZbV6VOakgtQWFtFJr
         GQWzr+u4DAD7zCq40QsQD+7giFpbMSNkpgRprE20IMYGAU2bJ3cvu9JhC4xzkjyT5RRA
         i+xR5Xm5xO+wt3syoGgswNrrYvHHF2y7ykRJAieXoeLxY1pIPlI/Ov07MgwFlGBBq8gn
         iAqVVj3ZrbOmu1wHAElUDVKhtMpXedtU3nBMciPJhU+ghG55gbIF/DgfB0oejz12EvGZ
         INlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5BIlUskzrCYJ6sc/Lk+KFt5X3QqvZXTBNwzkEhdSqVnPOMZnhkhtZGqEQBIKLM2zBCmDBy4ozvnvbBWk4UUiXifvqb3CjOE+j
X-Gm-Message-State: AOJu0YyPSbljTJ8dKqksCzbx3aY1kP/wZ6o8Vw/PvZT0c8R9XbhnOfl2
	Av/nQ+5f7pIirbM1fRa1h8mwL045C69MYH9EBglpLwUYqOlPBnvZHktARviPN0s=
X-Google-Smtp-Source: AGHT+IFMFb9MCIM9L6f0jDdcipMU0rsTpRV4nmA3bPnG3yHOHsM58Xj5fihX3AP69xr858uQrGY4eg==
X-Received: by 2002:a05:6512:2145:b0:513:1a9c:ae77 with SMTP id s5-20020a056512214500b005131a9cae77mr7917886lfr.52.1710843292013;
        Tue, 19 Mar 2024 03:14:52 -0700 (PDT)
Received: from ppc.Dlink ([91.223.70.172])
        by smtp.gmail.com with ESMTPSA id r18-20020ac25f92000000b00513c4e41140sm1871737lfe.204.2024.03.19.03.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:14:51 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:14:50 +0300
From: "Andrey Jr. Melnikov" <temnota.am@gmail.com>
To: Szuying Chen <chensiying21@gmail.com>
Cc: cassel@kernel.org, dlemoal@kernel.org, linux-ide@vger.kernel.org, 
	Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw, Chloe_Chen@asmedia.com.tw, 
	conikost@gentoo.org, cryptearth@googlemail.com, hdegoede@redhat.com, 
	jnyb.de@gmail.com
Subject: Re: ASMedia PMP inquiry
Message-ID: <27omhqrgppkwzluvdcdsol7eawr6qh2jgumvj7u3ozzrtgztaj@vy3lxlfxw5yf>
References: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319091322.10909-1-Chloe_Chen@asmedia.com.tw>

On Tue, Mar 19, 2024 at 05:13:22PM +0800, Szuying Chen wrote:
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
> 
> On 3/18/24 19:32, Niklas Cassel wrote:
> > A user plugging in an external PMP (so not a PMP embedded on the PCIe card).
> > We need to be able to read the PMP device and vendor ID, in order to apply
> > the correct PMP quirks, see sata_pmp_quirks(). So trying to hide which PMP
> > that is connected is bad, not only because it violates the specs, but also
> > because it stops us from providing the proper quirks for the connected PMP.
> > 
> > Could you please tell us how we can communicate with the PMPs directly?
> > (Regardless if they are external PMPs or PMPs embedded on the PCIe card.)
> > 
> Hello Niklas,
> 
> Unfortunately, our design does not provide interface to communicate with
> the PMPs directly.
> When ASM1064 plugging in an external PMP, we will hide the PMP and map to 
> the virtual port to run.

How is possible detect such configuration?
