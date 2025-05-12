Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC047255F4D
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046118; cv=none; b=cS/zFipWbmziqEuVk5hGAjaplwn57lW1j7BQVulaMkwxvmtirawiQVKfQuVw0kMQRx0WFzP5JKOzNuZsytnZxPpyqmT49fAHPGTWJP1M+kA8e8i+DmB1/cNrDnmg/GykmTMFgv95tG/4iwAN+bsJ/x4Q2vGzSybAi2/C2GtA+OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046118; c=relaxed/simple;
	bh=oW9htvxCkKn5W3jrH6zthhHOrtjiS/vqbO2P2rY3RSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLc+SmLMbjf/XjIVacjvwuzH84ckqjskM86ESQDA14jgnNzfbisqACXVziNEz48AzdV3+OSFctzR8+q8ii4jVGMK60wAm9BvX9s4GANnSomdAA7LdtosCTkjmsrtzMgQ+tzBAIew9ma9KmPEXK+BfFZZ7cDHKKv70z9po2yZNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gy5iHM3I; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gy5iHM3I"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e731a56e111so4122385276.1
        for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747046115; x=1747650915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oW9htvxCkKn5W3jrH6zthhHOrtjiS/vqbO2P2rY3RSo=;
        b=gy5iHM3IqnaIxxe7FGvEP15esCn1Y4dwQQNNZ3ofq2BqIVO+16ijClGhcU0Pp4893F
         fZJXF1SIWUbGTSjMMBpnGAfn147dv2AWaH0svFVCPk4pu9ZofTN6b41JC0K8c1gb4E59
         +Ue0Aw/lVudBZ8dvs6rGH3vQGnSqlf5c2bA8tpHbbqQyl/Fqnmr0+Gk9FFokAFGLnoI0
         GoT7vl+v5WDnKQVkpKTmsGBhoZfkcH6HOhczOjJzwuCF9w8gxtt248YA4pCxyaB6SlII
         cYpHBkuKycdqVadH4r+GzVZbI5p8H8XbMIROtCqsIWR7rvxHGzpqSEepnFq/fxI8JIQJ
         UkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747046115; x=1747650915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW9htvxCkKn5W3jrH6zthhHOrtjiS/vqbO2P2rY3RSo=;
        b=CuUBMRBaj72TX+Rb4iJcO4+2JhqPMk6XB5eZ51Mdf0b+pfBmuiJesgJ/jli48KJdIO
         Oh+oDltSXkgrMmV5xSkP6rLzDcgQGhaYEAbsfjNjkHbLbk4td7tgutCfHNWeVpRGtcB+
         A9Do1jZAQ1DFQ1lM4naA/MhOOFBKtpJsc63sw8GRsFFIQytM+fO5OQ+tf091mAXvE1wr
         gzsDGqHb6vnDltj/VLrEizB11k1/gEetUAf93r/Cu+5ZNpNJf+04v8mKlqe9DLF6tQpq
         c7vWzsGT9v+uL5Mg7Q2Hu+fynOqPjrIF4mCMiyZCbwKhjDdtrItxVq7lTmuSAwHSagWx
         ng3w==
X-Forwarded-Encrypted: i=1; AJvYcCWtvIu3PtkAOF2Fmp2qvGQLF5BZXRYtshqgOiY26kkLG7qkxDgFgl48dwUU/pjjqdaV7iGlwf6S5X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YUaqOiyRKCNyEt3WEZKQdj1HYZzKd7hdX54xWXBJ9j61d26X
	pf1monHe79i8mEo6niLh44D5ErMJk/J9De8/wS9cYPhOGYVtUwZO/FpbbeBjCaXSIWHEDKlUG9L
	6ZOIohmVripyckxDNjqPqK19RVQd0PTto
X-Gm-Gg: ASbGnctOIHhZlEIPGghduWZ9nTzSa9MMWSDo/WDZkxYufeZbPzwwO2/cTKFYKcDNqSA
	J4t5L46G3Lml8d3LocoDprqqRGK3HiYyl4rpk6dWuhgvMgoR6dg2gU/VcCsAOBaVe1+z1mownYs
	cTbdeZymsoc9To782c9LTnvPq8wiLndqt6sg==
X-Google-Smtp-Source: AGHT+IFMt3/glZyoQPA2Vpa6oC6RY0KdCv3KLVTEaStOOkt6K7QT3MTCIxUztoIkauVtGeeLqLy+SwlxKhX7O/J5gcM=
X-Received: by 2002:a05:6902:2708:b0:e73:29b4:d563 with SMTP id
 3f1490d57ef6-e78fdc0f8e8mr17209772276.15.1747046115432; Mon, 12 May 2025
 03:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org> <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org> <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
In-Reply-To: <aCG-gS2f3uXKaQPj@ryzen>
From: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Date: Mon, 12 May 2025 13:34:38 +0300
X-Gm-Features: AX0GCFvglZKtXzFVYiK2HuQmsPKQGBT2zzJcaOl3w2AwwiNcU7EgDPKiyrU_aTk
Message-ID: <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard drives
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org, 
	Mario Limonciello <superm1@kernel.org>, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
Content-Type: text/plain; charset="UTF-8"

ma 12.5.2025 klo 12.25 Niklas Cassel (cassel@kernel.org) kirjoitti:
> > I have a aROG STRIX B550-F GAMING (WI-FI) motherboard with 6 SATA
> > ports from which I can use due to space restrictions 3,4,5,6. New
> > info: having checked the manual I notice ports 5 and 6 are special,
> > they can be used only when M.2_2 slot is not populated.
> > I have WDC WD20EFAX-68FB5N0 and WDC WD5000AAKX-001CA0 drives.
> Excellent find!
Thanks!

> Out of curiosity, do you have the M.2_2 slot populated ?
No, they haven't been in use ever. There also isn't any setting to
turn M.2_2 on or off in the BIOS.

> Ok, so the bad 6.14.5 dmesg you shared before (where you got timeouts),
> was when using SATA ports 5,6 ?
Yes, and you can see in the logs, ataX matches the motherboard's SATA
port number.

> So, if we really want to have a quirk which disables LPM only for ports 5-6,
> it would probably have to be a DMI quirk, which matches the motherboard name,
> see e.g.:
> https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/ahci.c#L1120-L1145
And even this would disable LPM for the case of
sata ports 5,6 -> WDC WD5000AAKX-001CA0
which works now?

Best regards,
Mikko
