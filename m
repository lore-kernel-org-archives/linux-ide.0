Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECA76048
	for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699331; cv=none; b=oA1XgjHIU4bNSLQgo6LBoWsh8eKghyyAd5KFQDRoxsZvmtw6F68fyr2t019Hke/nFYefthlvm74eq2NS+264vyiL/NLhRYEn6Z/5uYW29iuyav+UWwqNsrj3/R7Gi50MUJaDlWASLKNoooJysjDJ3CJ/TJy1czDFgMGsQUnmDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699331; c=relaxed/simple;
	bh=vFODrHMqiV3HY8+m5nSz6cb0kesdcNwMLRKYCpAKcWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pylMA/Z29RpWsOHXTW2zjF3tZUtZ7O5bxaFb1y16A+U3fjZUgHV27Lm7Hebp5KpFuXDWmtLzwKjjFjz8zdgIOF1adBKbS/IfHKCw3N8FF5BXUdm07D6nymhn4zyHSHUKeUIk4JeaLDTC1WibfgTvQgNLBOX5iykpMqvoZGhC8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=bvhgdwvQ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="bvhgdwvQ"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc34d761e2aso794410276.1
        for <linux-ide@vger.kernel.org>; Wed, 31 Jan 2024 03:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1706699328; x=1707304128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nDAR7PJX+EQMyirL/3W1Y6Qsu12zaieB0DRPT6UdUiA=;
        b=bvhgdwvQy871L3F5qJLo6O1lJ0Mepz0zG4mXTBg7yPn+y5BS3gE2saBNMqXryHnKl7
         hf3DybZ8d1a29s8P1LGZbXyc64BwODFEykbUmX++byV050cgeVopMNDO3/LkD5KiJfQ6
         I5IZb6RILHJXQYEAubvvBfA82npKFEKoAWbIQr+LIIBksPWzPDC227XTgAPXise1pXAC
         ZMmiFMFlAVn104+h2pfVdPLFvc630m0zuciEh40fSp0gSTMKo06mwgnDGFcXERyQdtqr
         tuU8gKQ8k9XiJTb/kaR2SKfffRlVfHYlsnoevSBCYDSJFO2pl2PCFDie12KonNByygsv
         xkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699328; x=1707304128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDAR7PJX+EQMyirL/3W1Y6Qsu12zaieB0DRPT6UdUiA=;
        b=ctTo64a7f/JC4xGkw0lGHc5CvTIuwYUf18yKnD+8s5nyF9RiAEtgO4bIQKxgmsp1M1
         5NV3LkuEIj6ZRo1irn0m4eKVEYOp2lE2/sfT7uzoNLqnjJUWqtzWoSKHwHfVutPaoa3L
         FKl/7xvcCg773vNDwzJktnctnCifl2PCozbeX21KMWuDweOm8USX011oNPSo8QPrfjtq
         2lClrnBLf1SgSc939OCzzxNP9zWbwCLRab52m/C3T4IJtZ5VnGy+ccbJRWWIp+eOTzk9
         K7zMIKwIWiuQYOizUCj3UwMP7ly+X4E//GJsVGz0PJvOg/HjS2D/BPCWgRPwTzBBHyWY
         3NEg==
X-Forwarded-Encrypted: i=0; AJvYcCWBqtinNyahaXtVhuBIRUdpm1e+BwDrN02rI0Tc5Irv1bHpK5bJqq32dyB7N7euKLhWguSIVuyQdzTu30hVyAbroN8+OQI6RiBp
X-Gm-Message-State: AOJu0YzNxwiLqXqFznXnMNfWuo2TanUdQ7M8u2B6URUQhJvE6X/DuXUf
	0eowt9sNyQ6UpyBZmXdr8DXbqjQ6i3Xx8LJwIkzYQUDRB7S/fTPskV7I8/QlezvEa8a26L9h/xD
	JrcSgMnuQZRPgkIm0kQFR8n2RLxjsh4/a3vMn+A==
X-Google-Smtp-Source: AGHT+IGmAJYZ5cT3bVX5ItNSUhqyQs9ricprzI2Qyl4PaknWlx7aDB3XuBabzFiY5c8lSvvNorSCWQig/oBi/Q5U3pE=
X-Received: by 2002:a25:e08a:0:b0:dc6:9dbf:8247 with SMTP id
 x132-20020a25e08a000000b00dc69dbf8247mr950340ybg.3.1706699328384; Wed, 31 Jan
 2024 03:08:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095933.14158-1-jhp@endlessos.org> <20240130101335.GU2543524@black.fi.intel.com>
 <CAPpJ_ef4KuZzBaMupH-iW0ricyY_9toa7A4rB2vyeaFu7ROiDA@mail.gmail.com> <Zbonprq/1SircQon@x1-carbon>
In-Reply-To: <Zbonprq/1SircQon@x1-carbon>
From: Daniel Drake <drake@endlessos.org>
Date: Wed, 31 Jan 2024 07:08:12 -0400
Message-ID: <CAD8Lp47SH+xcCbZ9qdRwrk2KOHNoHUE5AMieVHoSMbVsMrdiNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ata: ahci: Add force LPM policy quirk for ASUS B1400CEAE
To: Niklas Cassel <cassel@kernel.org>
Cc: Jian-Hong Pan <jhp@endlessos.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	David Box <david.e.box@linux.intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Nirmal Patel <nirmal.patel@linux.intel.com>, 
	Jonathan Derrick <jonathan.derrick@linux.dev>, linux-ide@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:57=E2=80=AFAM Niklas Cassel <cassel@kernel.org> w=
rote:
> Unfortunately, we don't have any of these laptops that has a Tiger Lake
> AHCI controller (with a disappearing drive), so until someone who does
> debugs this, I think we are stuck at status quo.

I've asked for volunteers to help test things on those original bug
reports (and may have one already) and would appreciate any suggested
debugging approaches from those more experienced with SATA/AHCI. What
would be your first few suggested debugging steps?

Non-LPM boot:
ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

LPM failed boot:
ata1: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202100 irq 145
ata2: SATA max UDMA/133 abar m2048@0x50202000 port 0x50202180 irq 145
ata1: SATA link down (SStatus 4 SControl 300)
ata2: SATA link down (SStatus 4 SControl 300)

note SStatus=3D4 on both ports  (means "PHY in offline mode"?)

Daniel
