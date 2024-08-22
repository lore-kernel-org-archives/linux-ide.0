Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4241D0DED;
	Thu, 22 Aug 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359159; cv=none; b=MVqzE4qwrUozrRRKDK2CpmM3lInLHAS+go4wgYHXkhKEhpGxCSocxq3WVHjEULl4EH65KK8Wsaqy0Z+sg19lI6gHY975b1XoHI3WRVQUNyoOpchJuUoYGH7LgJ+z8gl6/FdgiEGKDlf2lzsei4iHdB+8AwzIhPhqKbnD/Ls2KlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359159; c=relaxed/simple;
	bh=AQjV6ehQmbvNgyTGaLfWJdq63F7rPiXDtiyi9bGvcBA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YRG1dihua5OTxWe+Iy5JjHnyJZFbN0z7jvtjdmFAzW8xC4fsaozzgyrVsZklV6umv2geQjlZFSO5LsbxkJqSczwTvTyckaAg6Mnd1E6d5JkXGeyyXHWTGz/rTMh8qay2Cbeb7M7lfK3HGlKgnO/Sg68xxu0juoG4pUOhiCBSJKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXzlJ3mp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXzlJ3mp"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533de5a88f8so623058e87.3;
        Thu, 22 Aug 2024 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724359156; x=1724963956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkFn0AdhVgyDSLEmCSbk7UuIUs0dBVqwRiVvtrDuc3Y=;
        b=gXzlJ3mpdIg0Sqk/a61hpcNazhrnqLSM7egAoYnn8siPSza1n2f+MW3FqlBdpoyKiY
         PgX/sa51wuVhTke6uUwJDIYRbiggO1/vXOO2PWbEjtbAuOuroOinv0ZFu5TyknpR8Izw
         xCNIpRrRv6YbQ2fAlH9L6IbEYRgbSh36yUi7b5WLTVz8x+h+uyOEXwcVRCIAPxKtaPF/
         bP+T1H7kT+dMecXMjJT+L/syVd3Q5y+RZojDAxzHAXrOsSxr+GU83WD61+i5jfPm1mr8
         BZ+rGixRuh3ttjOTSf48tUwXkFl/rx+nUnpRZE8IZNmDge4IPZKXo9w/g9qvLYnBTJee
         8VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359156; x=1724963956;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkFn0AdhVgyDSLEmCSbk7UuIUs0dBVqwRiVvtrDuc3Y=;
        b=iT8T4q9pwxmm231DmjLJO4er2oVBNmznbC4Lkt9VhegLrp3oh4JchfD8+uHumNFXtF
         eK5lOrFZsOB+CLQpW3oNIchMTidJo4vcn2lyGVEQcXVANZZZnRWk/tYVoulRIOBlpMlY
         XWjTyNIqDnUURSfPn3piDko7mc3soHx1LKV2mtouQkVZTxYjhq0BdOTAwpS7fv8oASz8
         fDirA1B5Z8MsoNvdoDnkrWnSKy9iNDRgbT/N3b9V0kkjw+kzfa2+OCfs+nRxwXUC1/hM
         GeCRuZJ354kQwqjRLX7oxqDgKYSPvuu2gg6u/uClSa7dadkm1d8toi5HU/OhVLak4qM2
         vZrA==
X-Forwarded-Encrypted: i=1; AJvYcCUDdph/6OtOcm7G6ZAU0SThgHMQMXQwVudSYgNSvRkEv2Ju00efvyD1W8utUNDqzd4wF9rIGR/yffM=@vger.kernel.org, AJvYcCVHMjVht+hX1HFIBrwTgNVt7zPC3nJPUzNhsRXa6SVFyHRgY410C/gaEehbobX2HJVdjKqyTt62XgWoCc+I@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcl0kIrXEtFfn+RClm7CAxRNDrAICUsHm9hV6T4r3dCq6K71MR
	AMhCmr39xoc7AiSIH/3WS/EeBkIl8qh/H8qFvbN08WJYtHvQ5rRJ
X-Google-Smtp-Source: AGHT+IG7aXm73Ndu+NiqWPAkccFpdhVsfBo5sgR8yeluU7T/U/g51mQZyz4I6LQ6xQXtCJpg3cjjSg==
X-Received: by 2002:a05:6512:224a:b0:52c:d626:77aa with SMTP id 2adb3069b0e04-534387c290dmr71446e87.58.1724359155604;
        Thu, 22 Aug 2024 13:39:15 -0700 (PDT)
Received: from [192.168.1.105] ([31.173.84.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea59415sm356805e87.120.2024.08.22.13.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 13:39:15 -0700 (PDT)
Subject: Re: [PATCH v2] ata: pata_macio: Use WARN instead of BUG
To: Christoph Hellwig <hch@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, cassel@kernel.org,
 dlemoal@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-ppc@kolla.no, vidra@ufal.mff.cuni.cz
References: <20240820030407.627785-1-mpe@ellerman.id.au>
 <6b2208d1-c18f-14d5-e6d0-acd5c82b4db1@gmail.com>
 <20240822025952.GA32067@lst.de>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <95c3cc5d-17e3-d19b-22f6-6a519f480143@gmail.com>
Date: Thu, 22 Aug 2024 23:39:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240822025952.GA32067@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 8/22/24 5:59 AM, Christoph Hellwig wrote:
[...]

>>> The overflow/underflow conditions in pata_macio_qc_prep() should never
>>> happen. But if they do there's no need to kill the system entirely, a
>>> WARN and failing the IO request should be sufficient and might allow the
>>> system to keep running.
>>
>>    WARN*() can kill your system with panic_on_warn -- Android is particularly
>> fond of this kernel parameter but I guess it's not your case... :-)
>>    Greg KH usually advices against using these macros. :-)
> 
> And in this case he is simply totally wrong.  The whole poing of WARN_ON

   Greg does have a point: on billions of Linux systems (Android phones) that
all use panic_on_warn=1, WARN*() is pretty much equivalent to panic()... :-/

> is to have a standardized way to assert conditions.

   Hm, makes me remember assert() in C aborts a program... :-)

MBR, Sergey
