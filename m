Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941A153BEE
	for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2024 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120914; cv=none; b=iM1SLMMbEFlJZACGbR0qHI61iOBlB2TWD8MuMqFWTU29qbGtzSEcCqwREo2DlgTg+7qVTdLeieg/XOfRDwM/gS18mRSXoEmQ/zGxQ1bORa9++hwOyP88YxcWt01VOoDMxKUMIvh7/cmaA+oU2uO7KkxJNbq/bMWrycfUFnDE70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120914; c=relaxed/simple;
	bh=CCaKhwATJXJRfGYEck9C0rB7F3F5doNhS2ivfFKo2Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZgT+XFllcYzn81TRIWuq+cGHpokGvm7jxklchOtRQncbBkqhSoTIViARTD5cB7yHwLs5Wh+/BNTT6sWZvM99eJzhEZZVIeKhy/XJICegew5PmXjSIaxWRdFi98fB+fYgSqgLgSJOHlQ6rGrDpsELDlaYl47ShFqBIajKJQ2eiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrd5mRa4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrd5mRa4"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da3545908so5349517e87.1
        for <linux-ide@vger.kernel.org>; Wed, 20 Nov 2024 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732120911; x=1732725711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq6H1maOJpuqNXCJLHOlniLC9pYMfELF+J71r+dECT8=;
        b=jrd5mRa491PLqKh+tPVxg7lbkllASRf3/j08wKZi5kDsw9oMGU7uNpii0w1RIhag1v
         V7/znbF9hw1EMAm2OJ52YhPQCNft9Z5UCQ9lnxyZYUOWoZ+O3JnNn9+3hOALOJLsswJy
         v13p8uIEZ9Aqi4srVu01FlGYpn5ZGd2WRcw3xpYe3a9+hOuHPINMmA1MYas3V5gcRvPC
         5WpGe9wcZ0wBJvnmagya9qB19jW93aMF7NjsG+rBv1cszuO9psKbxZWzJgpYu2r6//27
         +tmY3Q4D+4d1O6Tw2Ee4su/gVzfqtGhCFUlnCuiaGFZA6OZFWZQsc4xjA37a4ednycRr
         tNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120911; x=1732725711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq6H1maOJpuqNXCJLHOlniLC9pYMfELF+J71r+dECT8=;
        b=qW4awoY0YswOJg4KG12UY/y3EOMlRu0nGQa4+00NwbMRuhUgxZEpFsHnA28a93fkcl
         wSeSnTTsw+x3aCpOBWJ1FyXoAN1sukKBxeYmJ4jBg9AeswA1DD0AceEeUQ4jiemVnbh6
         5Uw6ELX3Nxbjh4BTIOv4OPTozNtiDmQ0bBx7ytzY5L9qDNBpzGeOWLkeMO8x1g29N5O/
         Wq4nyTMaXm35XHiFrM3T2i/nuCnx243Qg2DpCGzTH2kWHQzRir3u0wE9Jrvq5smsR4rF
         bCPDchlE6ildjBG3OqbpM8kiM31pQkzYk8EB/F4zrM4Tg6aeR9YmUYW0iK3REJRqff6l
         FMWg==
X-Forwarded-Encrypted: i=1; AJvYcCXDjfWQaqFh2/R9a1+nHP7SAEwpt6w8MWS8+qj0H9eU5hxmgC60jEHA9GJppTM5lFi4G4Ij74wf9U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH7uLDMiZzNdB7cZ5Mee2yeBYX+tp3Bfq5Rk4yyxPH1QyooRzA
	NG5hJ5D/OvNkCOGE+r0lwkjqcJJPzYL7G9LzE6ou4tIrDgjHTFIJ
X-Google-Smtp-Source: AGHT+IElM4RQ78GQ82asDJ9svlBS6JaV2lUE/1k6R9MuTQ0H4t0T6KiQzOMr0/TaHl6RA/r4BSuudw==
X-Received: by 2002:ac2:46e4:0:b0:53d:a1eb:a0ce with SMTP id 2adb3069b0e04-53dc137436cmr1370724e87.55.1732120910563;
        Wed, 20 Nov 2024 08:41:50 -0800 (PST)
Received: from ?IPV6:2a00:1fa0:420e:494:e536:5618:5f6e:e987? ([2a00:1fa0:420e:494:e536:5618:5f6e:e987])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dbd3edc35sm688692e87.15.2024.11.20.08.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 08:41:49 -0800 (PST)
Message-ID: <1170a234-2bb2-48c7-867c-ef1b091044b2@gmail.com>
Date: Wed, 20 Nov 2024 19:41:47 +0300
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ata changes for 6.13-rc1
To: Niklas Cassel <cassel@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>
References: <20241118155013.2706907-1-cassel@kernel.org>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20241118155013.2706907-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/18/24 6:50 PM, Niklas Cassel wrote:

> Linus,
> 
> The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:
> 
>   Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux tags/ata-6.13-rc1
> 
> for you to fetch changes up to e8a2389ea808c3902d9938b20e40e2df36c3702b:
> 
>   dt-bindings: ata: ahci-platform: add missing iommus property (2024-11-12 12:15:59 +0100)

[...]

> ----------------------------------------------------------------
> Andy Shevchenko (1):
>       ata: libata-scsi: Refactor scsi_6_lba_len() with use of get_unaligned_be24()
> 
> Damien Le Moal (7):
>       ata: libata: Remove unused macro definitions
>       ata: libata-scsi: Refactor ata_scsi_simulate()
>       ata: libata-scsi: Refactor ata_scsiop_read_cap()
>       ata: libata-scsi: Refactor ata_scsiop_maint_in()
>       ata: libata-scsi: Document all VPD page inquiry actors
>       ata: libata-scsi: Remove struct ata_scsi_args
>       ata: libata-scsi: Return residual for emulated SCSI commands
> 
> Frank Wunderlich (1):
>       dt-bindings: ata: ahci-platform: add missing iommus property
> 
> Uwe Kleine-König (1):
>       ata: Switch back to struct platform_driver::remove()
> 
> Yan Zhen (1):
>       ata: Fix typos in the comment

[...]

   What about my 8 patches, could you please clarify why they didn't get
into this PR?

MBR, Sergey

