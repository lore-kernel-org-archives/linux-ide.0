Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445834CA795
	for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350094; cv=none; b=f4vGzkGPUWQklZ3dgaKY+z81E+TWxr+4S0YGmPgeVToDUjdH0iAoebJXoR+wZ2fxAyQgi+hLZOobusIUUHviOeVkUO9qhIW2pLC07vIKEU9eteI3+EaW1bVUTowZTg/31MTAAUCRsnqEzXW1BC/Q2i45ou2aXy9ufidtgOyxaBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350094; c=relaxed/simple;
	bh=kzqeDAgce2Ard5nYDJ+4m9yakbptSbQvaAV8qYpI9IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwfSZs3rDn8eYiolvLW1BRrvsYG1pPexMYlrNWg4KJZXUSWmv6O3n/Uxk1NxlZO1OKP0eVeo+WB6KLUIr9qmAbxCVZ5plPhy7mfa9bOxvi2tnChVh9EWBNyEVPSHqLPrNb0ZUAXcnZ0SWmvghxzidwRGID68H7g/S0vNuVVwdlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnRntcau; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnRntcau"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so7906265e9.0
        for <linux-ide@vger.kernel.org>; Sun, 18 Oct 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792350090; x=1792954890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxERPHF1xEoT2ysKg9g7mOTwdVPNji0iYlNP3mxPrtY=;
        b=BnRntcaudlySkYNy5JFRt1t+2hrnXPp6baly76qnNtHZaC1ZpuUDmq7tJK3+MWCT7H
         PUBrjiWI+QrHzGfuix1ZOKhazGKP3nFqp5cZJIranjDk+PDbzqpm2xG+uKHtbgqTeQfB
         JiBbQoBY1gYWJtho2z65YBk8p9nFLuI9eZUUjikmZofTba8ot+O3X/j/v0RHEWUDpeWn
         hqdQ54j6n2TCgGBemMj845fQog+FU8CEMomguYaL7NyVyF3Ud4kPuxD764ipqhLClvHU
         cmDEqIsNAHCWN7E7qzcjfVTzE6cY2qmNgYgFQwVjCQMYi9fZ+Dps5jvGe7T0T6RvpecT
         4/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792350090; x=1792954890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxERPHF1xEoT2ysKg9g7mOTwdVPNji0iYlNP3mxPrtY=;
        b=sddGMWBs3QVY9eSrGkT8CC99XjRjQUQe2hnmi9KJ8dP3Dw5QXGYM9C0ZllFHRO2+Qg
         FWd6JRuyWRufP94MiE+Pkkcb5YD6wT3m6+t7HF1xkHf9rFvQTea0tmNl0WeVUFhPPCAj
         Ecjh8vdhevIuGDDKEhBp2jdDZDBilntZKK5Bc1SWJdP2s92LG4Ncj9lBvzAQBQ5A4JWs
         x2HdCxeOzGa0qC9GHooNm62GgpqZxr2htTAvaLT8k7LkB6ISV22REC0ie255/bD07csW
         4+iHfMt1wPbf7Z72yJMzfDrB+zA/qalmehZrWVYguwxl+7xmmTO50QFYvqbdLtCD0n2K
         FlrA==
X-Forwarded-Encrypted: i=1; AKwUvByXDwq6l3IAQSg9NQAM1ahwTaWVRMMqY7iHxxuEK4dsGjq96/ibqUK51sXCW+cILvYNwo2OZ/pWD1g=@vger.kernel.org
X-Gm-Message-State: AFq9FYKL58ZrBQNYHvniIB554p2wCBXVo3o2BYqUyZ6TVZMoja2OT1xO
	dJoaBhJQ090k5ns560EKhh7UyC5vtlJzn/Rvyj/+3xXcuwwwbfwNnf0=
X-Gm-Gg: AYBFou0mNCs9JtfT2YVXadkK8HMULadktzfwPy7ihNKOpnA/lYfCz3+2YVl/Z8ClyYa
	7Z1mOGtmB7J5Fv+v7orrMJ04quE68/DETMKDgjh2iGDb+cUEe5fb4n5VUJi+9IHLPn2fpVP0q7n
	HkaZabEt2dkV4a8FU6a4jjqJd+VES1Sf6F5tni45j+d3LvGz3Js9tNIUPNNU3tXOx8EU4gBajQA
	MU6WdDm7hX6NFNoAnvu0HHg2v0oui7vhF7KMjetX8Bl0dnyjr0QGFvNR1aLBxrE6/mwB8q/lJhC
	tOhjoPdQ+9TEzfh0uMtntbL1Kbq/T8btqdoWv5/3MNKbZ6XG2zGbGiFpulL7l8Da+bwnfc7DtSx
	zq5UdcZI9O/1oUNYmZWVnJoNtc+D9FgPrmT+Q06k1fJQkYHm2Q6Wrq+qorR5HZzKFU3MJ1V8DFU
	ra6iZ1FGFpxcML0ycFmAu3HlovyfnCxjHbS09hWjdM4mJxvoUAQgz+jAC3YO+allh5oaWHjuZ0Y
	W96TN2U1CvQ8EW342vC8HmcisOLHG534CUbwYv5H/+aCRXmYqo=
X-Received: by 2002:a05:600c:c170:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a1d76060a7mr106131935e9.20.1792350090132;
        Sun, 18 Oct 2026 12:01:30 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:f673:adaa:3deb:83f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm271208015e9.0.2026.10.18.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:01:29 -0700 (PDT)
Date: Sun, 18 Oct 2026 21:01:23 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the
 ATP865
Message-ID: <atUXgx3Bmc4wdXdR@lithos>
References: <20261017041419.311921-1-daniel@0x0f.com>
 <20261017041419.311921-3-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017041419.311921-3-daniel@0x0f.com>

On 17 Oct 13:14, Daniel Palmer wrote:
> The landisk defconfig currently has a similar but incorrect IDE
> driver selected so IDE doesn't work out of the box.
> 
> Select the right one.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/sh/configs/landisk_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
> index 2b7e10c9acee..6b5ec1f3ad71 100644
> --- a/arch/sh/configs/landisk_defconfig
> +++ b/arch/sh/configs/landisk_defconfig
> @@ -28,7 +28,7 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_ATA=y
>  CONFIG_ATA_GENERIC=y
> -CONFIG_PATA_ATP867X=y
> +CONFIG_PATA_ARTOP=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
> -- 
> 2.55.0
> 

I can confirm the PATA_ARTOP is the right option for the Plextor PX-EH40L
(which is like LANDISK HDL-U), the mismatch of options was btw introduced in 
Fixes: b7aaf16d10bd ("sh: remove CONFIG_IDE from most defconfig")

which changed CONFIG_BLK_DEV_AEC62XX (which supported ATP865) to
CONFIG_PATA_ATP867X. To my knowledge there is no sh landisk device with
an ATP867 chip.

Reviewed-by: Florian Fuchs <fuchsfl@gmail.com>

My PX-EH40L has btw this lspci:

00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 20)
00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 10)
00:02.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)

Regards
Florian
