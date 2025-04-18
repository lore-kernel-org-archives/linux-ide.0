Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702E08C1E
	for <linux-ide@vger.kernel.org>; Fri, 18 Apr 2025 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934966; cv=none; b=tldHpoZ5Ua26wZiVC/u0liiJ6zScSH2M1bMVr0q7E2X+EBUNAEDVu5dS/8HdnN/4CLttB48CQFUUemHo+6mckwH8t4uO9pnhoR1XR3tAmKcKon2zYzns1X+HuGLqpF8qYRi3H59/+jaYMAQqVCVlzu+kBAKzLVPYAN9RTyctFyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934966; c=relaxed/simple;
	bh=1iz9cSuAyLptqR95CHj47SCbPvg7Ohoe4JgNu+5U5qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBjPfuit6X1rTTreOj7ICmXicv3Krpu9M7PaBKu94uKT46uUt88qNhqik4MOnPfYdB5P6rWrKTKJQ/b1boiTxgVCmFrrLLTiyrZbPzCKN7Q/XVSUd+yzt83/xIFf4sNbOSu3h98Fd66fRqD/COIW6PQGbd9F5iucMxNmmUQOobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4nBXufVf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4nBXufVf"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so48425ad.0
        for <linux-ide@vger.kernel.org>; Thu, 17 Apr 2025 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744934964; x=1745539764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRMQb6QKHkmqTIiBM1Dt1HJPQdB2qTTEuCJ+2vuCv5Q=;
        b=4nBXufVf16edin5u70QmZSswWZ1rgDhrUDhZGk019WxD0uvUoGpsYxZCjShvxvvZ8Z
         wRrS6Ko7VwGi7BwfSWhPDAE3VqFqDCiuOgDWPTwXGIc+QqEJdPw5wo1HQ7+1AELo8oeK
         5Q2fDOn+uSa2w+Mc9xkDLEsGza2upiyMQ4u9lScELHegeCMZlHP3lZiW12f3hjdFx9+D
         ubatEaYfG03qO+Ayfg7IalyI+bvxA7AAFzC3j6r6Epjp8XhHJWC5pFzk/2RTjRN5LCJT
         c9lF+CK3LW+amvrweyONSkeFNIi6nabWIHEIf2DWXph4jtixkvDQs1rcjAnNTgw4hx2b
         9Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744934964; x=1745539764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRMQb6QKHkmqTIiBM1Dt1HJPQdB2qTTEuCJ+2vuCv5Q=;
        b=kafOt7jwT8eLcojQ2Ajqz9J38cpZCbMhFih2p2VT9iaIwnMd4zlq41C3KjFZpmGRjw
         MTqp/NgXRGhfvOK2DZPerjRmxHRwHC0ovKy0e181SneXq9EXnj1Oqsl4R8GyYVUMK7H+
         Q/VFsh1q7yf9WBkZFchFlVmu2SUlmU5DUjCsCSQxoiRk4/z1HZcqjP31k1W/ZpdwH1nP
         VOGPTd5k7Mu/40AHYvmROXfxDZFB0Buv/lVE50iZG6GxyhL+5UwXMITPD6sp6+L0Vr4P
         RKMxlwd4SLPwjzJurEqsUWydn0tgrq+aya+rKV0AMpbgBcF8ZW5huPX8vfAguM7C7dWA
         szBg==
X-Gm-Message-State: AOJu0YzM85j3ldjuHS8H+QZrQHYuy0Es2JhJ59rIP4k3qKzlE4Llm+iB
	8XI5YZSRpm7Tk0M6stVg2c/Q5/SPMmqcnopefN6A++ewrLVCLJ0NXafzyYlpWQGD+pggR7Clbel
	SnA==
X-Gm-Gg: ASbGncuknNMcPl+H7vNH+mryikB/8qD2I/sWpWP1mloPvsMehpdGrAmEVo6Lm98pgXG
	nALtUGJVR5prXwUUaRftYo1AQOgEv4iBpBmH8VInmDw0RmTalvepHXn6khxVfNz8mn7pwKKXYv0
	5ti6r3dNRUYw2F3M7fMT8WfUq44trco7C8lcYOVygF59+tdD01Shz1mgJRKEcFQZ+kt0JoO39vb
	SaoxwzNtg9lotwmY7AQA3hhujy6JpKORPZDhMR7iPplgEvZahJkhKQyTjm/YFF+CsYRQ1XzvQS2
	fb5evFBVdWuezNxLtlB7R9+R7gSHpTKCo57pcB/9CwJW6GvY+JCJzllYAPtK1wF32LsOHfYALPe
	V
X-Google-Smtp-Source: AGHT+IH/FUWHONJ58qRBe5zN9276vPde2PtlCDbwdodDOO1MF6EJkjcY5EVoILQbbQDQgKGBVq1tRw==
X-Received: by 2002:a17:902:f603:b0:229:1de5:e8c9 with SMTP id d9443c01a7336-22c54560238mr794325ad.13.1744934963329;
        Thu, 17 Apr 2025 17:09:23 -0700 (PDT)
Received: from google.com (24.21.230.35.bc.googleusercontent.com. [35.230.21.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf5230sm6236225ad.73.2025.04.17.17.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 17:09:22 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:09:18 -0700
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 3/3] scsi: Improve CDL control
Message-ID: <aAGYLkwoeMJI1s1Q@google.com>
References: <20250416084238.258169-1-dlemoal@kernel.org>
 <20250416084238.258169-4-dlemoal@kernel.org>
 <aAB3iU7ZuQo5cH9z@google.com>
 <3c8f7e2a-ba73-4943-8372-0f322aaa3935@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c8f7e2a-ba73-4943-8372-0f322aaa3935@kernel.org>

On Thu, Apr 17, 2025 at 08:08:00PM +0900, Damien Le Moal wrote:
> On 4/17/25 12:37, Igor Pylypiv wrote:
> > On Wed, Apr 16, 2025 at 05:42:38PM +0900, Damien Le Moal wrote:
> >> With ATA devices supporting the CDL feature, using CDL requires that the
> >> feature be enabled with a SET FEATURES command. This command is issued
> >> as the translated command for the MODE SELECT command issued by
> >> scsi_cdl_enable() when the user enables CDL through the device
> >> cdl_enable sysfs attribute.
> >>
> >> However, the implementation of scsi_cdl_enable() always issues a MODE
> >> SELECT command for ATA devices when the enable argument is true, even if
> >> CDL is already enabled on the device. While this does not cause any
> >> issue with using CDL descriptors with read/write commands (the CDL
> >> feature will be enabled on the drive), issuing the MODE SELECT command
> >> even when the device CDL feature is already enabled will cause a reset
> >> of the ATA device CDL statistics log page (as defined in ACS, any CDL
> >> enable action must reset the device statistics).
> >>
> >> Avoid this needless actions (and the implied statistics log page reset)
> >> by modifying scsi_cdl_enable() to issue the MODE SELECT command to
> >> enable CDL if and only if CDL is not reported as already enabled on the
> >> device.
> > 
> > Hi Damien,
> > 
> > What happens when a drive spins up with CDL enabled? Last year you sent
> > a patch to make sure that CDL gets disabled by default. Is that still
> > the case?
> 
> Yes, that is unchanged so that we keep being consistent with the fact that the
> scsi layer starts with the sysfs cdl_enabled attribute set to false. So if an
> ATA device starts with CDL enabled, it will be disabled.
> 
> That does not cause any issue with the CDL statistics log page because that page
> is not persistent and cleared) on power-on-reset events and this change has no
> effect on that. The CDL statistics log page will always be cleared on boot/reboot.
> 

Sounds good. Thank you for confirming, Damien!

Reviewed-by: Igor Pylypiv <ipylypiv@google.com>

> 
> -- 
> Damien Le Moal
> Western Digital Research
