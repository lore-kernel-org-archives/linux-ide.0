Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732832973B0
	for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746045378; cv=none; b=YRZqJeJdl25HVpQzpMOSk+XKVcgFxNbljsQ7mb8L7Re247Sc3mDqTcIOhymXYV26t8fasqrN30mpPoEhqR2RoFSDZ81gYoff17bLiwJ3ZiiC2is0WYHiXLyONlxwLcy/vopkPQf8RyVW+KwwAnd7Bgr0pzl42f1qnD68KPClSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746045378; c=relaxed/simple;
	bh=CGIs8g5apXVeU5pLo+hPOiq1CRuYNe0EcIRcypV5wOE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=r32hC5jKwl+d/UOduTBCTJU744fx3tCYJ6XggdGnDvRC1Wb+05b0Ha3e8C+7nDo55suDYyeahmBqi9LimPe4onF4iWY+jQXf5N3Lcie1bQTaqTg4G10IAuncrh0yIwZKBstQIc2G2a/fg9/pwrIl3Xhy70vhKwFSRUXnCiLjmLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RE1p3H0z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RE1p3H0z"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3031354f134so294179a91.3
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2025 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746045377; x=1746650177; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGIs8g5apXVeU5pLo+hPOiq1CRuYNe0EcIRcypV5wOE=;
        b=RE1p3H0zJAu6enOPl9V9JUkK4lAyQhJsyqkvmlYamk1m3VvR02HQ5Dz595f/ihGUOE
         o/cATyNhmNw9GzX4JpdVwo6axD8YUzRfOJTe6ZQ0+cnWgMXWtRF4jwANlr9gT6gIla9A
         DsYL23SI3v+DuRY/MdzpabCWtRGS7VwhcYlio8X6mN6V0kXSgd4SNqkmOOpc+y+vOt4j
         Hzshjpl2oheuUcCJaFuuDPeDWL3f48E3e6jLHrCWxD3HBWp2d/LNheQwpjc3yXtcCePA
         XoVvM+wKcA31Fy/A4aZTMSsulfhzfQg3q+INn16U1BYRTLlMig5528qZFtUiRe0eoV73
         zvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746045377; x=1746650177;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGIs8g5apXVeU5pLo+hPOiq1CRuYNe0EcIRcypV5wOE=;
        b=a+viF4gIUpvF4CLFn3VbiDyDkhJ6umciSAdocs5jki2uZ1yP+PwBtCioIGAvQY0bon
         AwGjOgU/fP2aggkBibY0fMDl+4YKlWuqYEsflDjLEGcPV7s+JbjbZ0PtDl8HX0C6ZV+K
         3W9eT8NMB0VhWadlh06sejElXKpRbGgHKihkUFYjWqVSQNKXWCpq2doveQEbMGtTsSyv
         4EJsxJXhVefXzwLl6uVGibHaabiUkKVRebWlh1ecizkHNNQ1lMXaSSbsTFhsVYXQbo2K
         CslwcnqHlINv9VhhE8vEnV+zDETDFFjhKRdqS509LBFUW3pwNLUYzgqRU7jBJp2oRQec
         HRUw==
X-Gm-Message-State: AOJu0YwVaCNEx9iYJwZkEwLPKbQotCLSPhvvAl548BpCfiHJFQvVoXQC
	dVU0J+AK3ndHsnlnsaNXHw8/Y6vrBmt++c5LowlyGfDUpVu3ulGSOVwxmwKKU22UPK89uiYatAM
	hcTzN5IocsB57ItwwtqzkO/E0yCmC2HJJiFA=
X-Gm-Gg: ASbGncv+9zFdcdZ4qJ8TXDyF70GAuti7tGWZYIHsuAgNCm49v9sVm1Hw28eqI3AZ5/I
	pYnxTG351AvGglivmTNcWLjMlb39xhVcd+WsMZ1GDVxiQDTnfv70ZiWFUwd0/x4qp7IN/AnpLuk
	6WQsF87hFaZZm65Uh+9R0AxqCO20cpzlMxc+PZOFSszjiqsV6mVWdIvTg=
X-Google-Smtp-Source: AGHT+IHLmuYynYgA89VbLqLs8CCGqio1s0N2KusMMciGoX3O/vYI4aMebCouMM2edo7Hb+Xa+uuSSPu9doqcanYt6CE=
X-Received: by 2002:a17:90b:562d:b0:301:98fc:9b2f with SMTP id
 98e67ed59e1d1-30a41cfc2e0mr204208a91.1.1746045376646; Wed, 30 Apr 2025
 13:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ioannis Barkas <jnyb.de@gmail.com>
Date: Wed, 30 Apr 2025 23:36:03 +0300
X-Gm-Features: ATxdqUG-hoj6glIf37Ei40Snp5TflqSSpsDVH6mo9Vhs5d2lX8mDExPBfPMINl4
Message-ID: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello guys,

It would be better to have more details on this since only the 2TB
model is targeted.

Please provide hdparm, health details from the affected disk, full
dmesg on the latest kernel you get errors so that we can confirm
active lpm-pol and see platform in use as well as board & chipset.
Have you tested this disk at another LPM capable system or HBA?

If the disk is in mint condition then it should be blacklisted if it
fails on LPM transitions.

Best regards,
Ioannis
