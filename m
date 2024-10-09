Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904981922E5
	for <linux-ide@vger.kernel.org>; Wed,  9 Oct 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477108; cv=none; b=pFUxP5+hza91SUrp++yJ6nZahlX+JOZz6ovN+ULQ02sLfoBIiZDQhm/jvsO1zIQqEEVrGViCviyuqvi0p2fpQmFwoOtd9F4cnOYs9ccrpOWUxXQHoRduruh2z1BbKHlfY4/gQyh04W2BVHsv8WWA1YId2c2QaayTaZmzxFzVFlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477108; c=relaxed/simple;
	bh=xqUxeqirKDZHq4AzynvWVBYlkU58KsNBq8lbIS6rZTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VyBQraa+zlrfIqnHBLbvgU5yVOTYqkSVlkhzMQKPI3jcpbU1oabzWZjDi0A3YEy8A0sCb+AZNJ5XN9Cy8y7veAuQaAwaurF0ucGdvEFZMb4Ii/i7UB5z0/4cHbfgVWtffpfOawqzxU69GkkNFRBdkxoqxym4eQNrtfnj6RLOAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Vz3waI2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Vz3waI2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e0c3e85c5so2211440b3a.2
        for <linux-ide@vger.kernel.org>; Wed, 09 Oct 2024 05:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728477105; x=1729081905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uK65wz/F/E6gMxBtn3Oq6CNHNTvH7U5AsxAKJKslvk=;
        b=3Vz3waI2sI7lWICpemGwn/+tOBd8Q31BwhMStKQSqb9IGpN03/Oj7EfI2C6Ej+ighT
         jxjiKm8Da3pX2yFtL0KW25DO88JwVv1qDytbkjzqCxDK41RYjI878jcx/WEcTVHxEIW1
         mrlLCRG4CYXRAyo4V6eBoSWMUsvT6YJNLZOVDRE0fdEXguCm+onM8rIv1W9IbgfvEk/S
         BaQdkBTm3doXYYkG47OqP/guC021RQeY5Uy69CGbIALX8eEAcMOrGsKYjCSu+4jV7zeR
         xd270s6RmgrclmhAZE8gpcYu7Fua7KpSJOlQDvIkNoOiPhusNTMSzA2wiGgsmPhbPfQu
         000A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728477105; x=1729081905;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7uK65wz/F/E6gMxBtn3Oq6CNHNTvH7U5AsxAKJKslvk=;
        b=Gx/Q6d/Zt+0midm1L+mNk1F5rf5yI2zIETS7NkSFI99vy7f3oXh0qfD24OBHwbKurN
         4DtrkKx9d0WylD8Ndu3N3DpBdo0VbUNh44gsPC8j28aB5kjpJXDcn0+IQdqc/H+mTIkR
         4nb2nXO2iqa7eld3vyTKOqZRRb1i72UfR3AdHuwAxWyQaVb1M+GoB0k4zZOFXP0C1RXp
         oKg5v4QVejO9FH2DeFD7Obq5KJWp/PBrrPm4PeW5encWS0yTcUA+yYU5BGFX8P9m0Gfm
         AXbFMXz5xZVuAKPEELCQw76NW15ckaaUjP28fMiU2hAqqsrtDZrZnjKO5//qQGwQAPuw
         /FOA==
X-Forwarded-Encrypted: i=1; AJvYcCVjaCQGY/cbbBGGD5gB1q/0orVSISYYe9aKfihFwFjztwvvj7DlwjPJ/VB1klNcyI0jVxSa1Ba2Qkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztOLZ6uJgqBSHmTOzrExOqpl03xEQ2WP0zawN6/bOKyLfiTs2P
	YWvxv9sjKhczTkKZFgea5MZc9sJG+9GlpikxklJgt+RtWlPJi0HZtxba1wnkcjc=
X-Google-Smtp-Source: AGHT+IFxouz9vGG25AIFl7E2lWUnAC86RmiPcVEuH3vQaQKiWk6+DH6WZy7ooMw31SlvaXbKJd5B8g==
X-Received: by 2002:a05:6a00:10c7:b0:71e:325:6826 with SMTP id d2e1a72fcca58-71e1db64813mr3163631b3a.2.1728477104901;
        Wed, 09 Oct 2024 05:31:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd084sm7665704b3a.51.2024.10.09.05.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 05:31:44 -0700 (PDT)
Message-ID: <24c92679-361d-429e-b257-4d94a6bfce6e@kernel.dk>
Date: Wed, 9 Oct 2024 06:31:43 -0600
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_platform: Modify MAINTAINERS entry
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <20241009081557.377035-1-dlemoal@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241009081557.377035-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 2:15 AM, Damien Le Moal wrote:
> Modify the MAINTAINERS entry for the ahci_platform driver (LIBATA SATA
> AHCI PLATFORM devices support) to remove Jens as maintainer.

An oversight from the maintainership being moved to Damien, not sure
how nobody noticed for this long!

Acked-by: Jens Axboe <axboe@kernel.dk>


-- 
Jens Axboe

