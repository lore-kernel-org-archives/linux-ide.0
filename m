Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62761548F4
	for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537608; cv=none; b=oxNQO7EPoXxtpOn+VUAKvVQRU1H+7jt8m2/3gsuSCYc7mPKVvud8sWeIpfrAjCgAA9BqcXwwnPO2GSXjbvI6YkeDe9rV6QlxwNriQZ3ItOq98eOHVr6CynVY0+SjymTBGY7+EtDf+aQIsfAc01BI1lVUdYVsjMUV3hxclVwmv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537608; c=relaxed/simple;
	bh=+KGtRrsdtVYv8AD7wopW3Mnr30pckVpYCUIEf7ipeN8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=G6Ulguo8YqSppVkskbRxttlfkOV1PxltlRqW6xsg8g49q8RByEWEJyKW4BuBvF1FJqS7Kez+xIRJZyWmxmJqgAYCcuBFKjR4q0YUyOuKf3q/hu9z1JtwbjLOCmiQWmeFl7HMc+d5eLbJJ3UmsI2uAmhspMeGU67rR94Cfflg49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2yYaSAV; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2yYaSAV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29aa91e173dso2032107a91.0
        for <linux-ide@vger.kernel.org>; Fri, 15 Mar 2024 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710537606; x=1711142406; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+KGtRrsdtVYv8AD7wopW3Mnr30pckVpYCUIEf7ipeN8=;
        b=T2yYaSAVI/TJpiNAsPgkHeu5jdAzs3RbeKMz+46E4p+k6G0Fl98kQFIKhQze73uCpd
         AAFKHWm5N+38zh8ldsd+PkO2DFN7RwVqsNoR/PZ+UL4lYLmSPTZdAtWekaUBiEuR4hTT
         MHxKXOFoKEYj2sAXKKVjp3MXCVj7T2J7rua0djk8iMfwfWomMFt1OtNUhFSRwYYApDJ0
         dK5cFgrg0IxBTJjeXGDAieIM38kizz69a1vwSMUcOsSsfXDb+DHdmwQHllnqkxcuPOj4
         u+xn00NzRZ5ltihKD9aJb4maS5BHxnJdMJFvxCJhg9nqv9McKQiNaG6QbHvor99AZM2K
         Jgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710537606; x=1711142406;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KGtRrsdtVYv8AD7wopW3Mnr30pckVpYCUIEf7ipeN8=;
        b=PhPb8GxcISyRjX0lxrBa2qVF2kLjHrw/r0m6O/8nd+o6EnFGfRjpoRRFbGERIw8YfX
         9LKPRkrFrDdKccI+CbuqPp022WqKmTRGgb/MJnm/noaPCLIqZz963dSa0ppix5c0/EbI
         8hNTj/vd4h4LN7EHCnMynwy5/lm1E1Eu+RtSh7Pd1SxJFZrIgxVf7ofsfeG+Chbi/XYt
         BnaZHUFEm9+3WIwUorKhRb6CBeyrIOGUBGhCZ+qGfGKohIi5Y7tsr3vOr4JZbZtEAm1r
         7mjC0GfnvismbVv1ORgvhinlhNl1qZ+QxxJHc1cOGkG2jgHC3lC06iM9nXE1UdKP2qJ2
         i4Rg==
X-Gm-Message-State: AOJu0YxCvfaKzQYrXsbSpijhhh0eNJeRjktq5RPHCaymaCf2NtOMwXRJ
	cyBu1Qiv//ijH2qcY4PWdfpbYMaRAOUM8e7KpDf9u14ygwPaTw2mEOVDpd8yjWK67TfR/3Zfled
	LvgFOpEPHr5dUqptGYH/t8XhvbQru7DM9O6Z4cA==
X-Google-Smtp-Source: AGHT+IGgk0sLg8xVhoYtks+GBhffWkLHJMjpQ0/B715jN8/j03S72J475Pf0/DyH1zx1SXtukWpsvA0CJE/2OzqzUcI=
X-Received: by 2002:a17:90a:ea8c:b0:299:bade:ed0b with SMTP id
 h12-20020a17090aea8c00b00299badeed0bmr5112767pjz.45.1710537606474; Fri, 15
 Mar 2024 14:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Fri, 15 Mar 2024 23:19:54 +0200
Message-ID: <CADUzMVaFcD26QiBK_eKCbtC5Ot-+hAruNbUx+2pQNTKtMhDGRA@mail.gmail.com>
Subject: Re: ASMedia ASM1166/ASM1064 port restrictions will break cards with port-multipliers
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello there,

This issue came to surface when I used my ASM1166 card with an
external SATA II JMB393 RAID PMP module.

In kernel 6.8 I get:
ahci 0000:02:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0x3f impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq sntf stag pm led only pio slum
part deso sadm sds apst

In kernel 6.6 I get:
ahci 0000:02:00.0: AHCI 0001.0301 32 slots 32 ports 6 Gbps 0xffffff3f
impl SATA mode
ahci 0000:02:00.0: flags: 64bit ncq sntf stag pm led only pio slum
part deso sadm sds apst

PMP is attached at port #1 of the ASM116. Two SSDs are at port A and B
of the PMP.

In kernel 6.8 I can only see one SSD:
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

In kernel 6.6 I can see both SSDs:
ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)

ASM1166 is not declaring PMP compliance at its capabilities but it
works on its own way if it is not touched. Upon touching it PMP
support is effectively disabled so only the first attached device is
visible. I believe the hflag is needed here.

The safest option would be a configurable parameter to set it per
case. My PMP can be set to RAID mode so it is possible to break RAID
arrays if a PMP is used on that ASMedia host or older ones.

Best regards,
Ioannis
