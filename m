Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1823C8CB;
	Fri,  7 Feb 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957520; cv=none; b=OtLCkBToSYpY/w8prgmg90cJFu9r+kgp9S3rDoO3lEPr++GRq+oJqzpmH75kS5n9H7Ce4EuIBjUq5LhPfDcoNArvdgvVTVeuRNE+hpKhLEw19WOlqiTs5D/ZG7mv05vxa6O3k1aPs+8tg9kMH3uWDk2H9lb2SlxSKMyxeBmt2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957520; c=relaxed/simple;
	bh=mQMp2Q4K9qMcm2adb9zu4siRw7YphIPITTmEykH+ZIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eD2pHHrEE9gatxJX0R1/6lLV0R3twzqGgfaklhevwvvtdQYNQIerzpAcsJZPQ2QBjrPII5Yr79khlx97hkPyZJAif3dSD7734Ag4HsgqkdDcw/v3r1qpTPBHrUnR2WQYV+WrvwDdH70czwNtECvA6BHl1QDi0VMIi9JM03FGQpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQsftHSk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQsftHSk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so339232f8f.2;
        Fri, 07 Feb 2025 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738957517; x=1739562317; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/3TFXYa/aO92AWFEhX81Q70LQNPuijI5G6HSoxTBVD8=;
        b=JQsftHSko3f8vqPK2clwP368jyer8/1T2nzIJA7o/MYW1LDYcP2NxyF4Q2EB22ncAb
         NLHg8zwO3Mg+kBx4oI+5Dp8H3V/sjM35O0U6qVRKfG9E6O0aE8XSatGdPB5hjn9Hm6dn
         6UPE8xyGnYMe6z/Lq2xOd3+myfZ1JegmXsNXJ+24kB97uB9EB16rLp1WHFZlMgEY1JIE
         0QsAVM0K/1ZgoC1lxcqSS67+JJ0eqPAVwSFZVOWpVD0ks3+6qkPdcRWkQLv0sb/Zohvp
         +GcEowEuuCk/PJ1G8ueiGHHTpcrPRea6ziQu8rDyn5CPLAv0qt9EbK3CJdIHaUwgnWYo
         oqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738957517; x=1739562317;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3TFXYa/aO92AWFEhX81Q70LQNPuijI5G6HSoxTBVD8=;
        b=eBXdzZYDtBld9SERe2WZs/uhVg+7VGGDb9dhOYCvpfm0g3Y9IXB51thAc0oHZCDY2O
         izVmsH4yEG8B+a/s24SYqL1BUP97pyd7intAxnpxBtodIGjkEzpmONlMRXdOVCQMBWKw
         BBvjmBhjM+3BGQCFPwIByAPghf2ccOytgT361pq1mt4HNzozAt6hkNuym9VW80+y1AhW
         CNWqnn8O03ju4NF7lI6mepa1t2tykVLsgiUzjtV/FJRdYuXrBONwyRgvbjhet/GwCKsc
         FD9EXCceZUKv9a80wqdrmK62wgrVdRAFDO6aHZBhw4T4PPd90GLhaWP1MZP1qU3FM3Nz
         8LXw==
X-Forwarded-Encrypted: i=1; AJvYcCUrVJ29rC5P+6gq7wgvDDZy7gT+4sfDVhTpOYNuI6zt4cznrLC3RBYjIX/CSpHhFixbaHmKi+9Rto0=@vger.kernel.org, AJvYcCVZTEkIKS0RM7USBfAgXAmvtVBtAtdnD9GiC7mPVgeidctiK52GFD/XgtlwQUrbX0r2kvFTI1lJTrm5xOo2@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXhndPHe+qofRzoH28OdJULroO8CBZEtgjCodQOV+lQT4PFGf
	1Ro7AkJaaoAUQOcQPSI59zXeNlhcevOFq2UJsRTKOekX3T74nex99WAXUScV
X-Gm-Gg: ASbGnctfImDK1FHF1fE09u88eFXYsIyTxIedG6YJ0QH16vg9/aeTyJbIFH+0QDpjVVS
	oMhlNTz/yMjg0c/gkOO4pfVHBlcii7+GQG2bIuU7EUPxjoi5fc0TPwKgGehWq8jxbXe5+266Ocp
	NlGXSreO5bG/t18ya/PcovZ2+ixzYPGtmSfZ61WDQSk532XwFUFIXTgGJNapkquJcT0syeQIGhe
	7MxDNoVZYzyyH7o2FwWwNX1YGWkhJNwQNstLjNjNU6V2GDYUi9VyzDI8PGYJF/Iuubjcp60zZUw
	Bzugro50BVViddo+fLi/gfxjX2AJ+iKELMgxe5Gk80L6xQ/FqiGlmSgb5ek21g==
X-Google-Smtp-Source: AGHT+IHfVO3TmcFE6wwThceqlTu7GIBKI3hiMo4CU69DJ4VtkgliD/l6s9beMA7RTDnWO94SX6B5rg==
X-Received: by 2002:a5d:64ad:0:b0:38d:c5c7:4f07 with SMTP id ffacd0b85a97d-38dc8dd07bemr4034237f8f.16.1738957516438;
        Fri, 07 Feb 2025 11:45:16 -0800 (PST)
Received: from ?IPv6:2a02:168:6806:0:865e:8fbc:80e7:2e03? ([2a02:168:6806:0:865e:8fbc:80e7:2e03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dfd7d7asm63183025e9.36.2025.02.07.11.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 11:45:15 -0800 (PST)
Message-ID: <cb8175c2755557dd6532ee71d1064241a1412ce2.camel@gmail.com>
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Josua Mayer <josua@solid-run.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>, Mikhail Anikin	
 <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, "linux-ide@vger.kernel.org"
 <linux-ide@vger.kernel.org>,  "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Fri, 07 Feb 2025 20:45:15 +0100
In-Reply-To: <08981396-59d9-4be6-91c7-83421706931a@solid-run.com>
References: 
	<20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
	 <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
	 <fa54a148-6016-429b-b494-490041564e51@kernel.org>
	 <016bbf83fec9a0a7c7697462ce0970b94572f50c.camel@gmail.com>
	 <08981396-59d9-4be6-91c7-83421706931a@solid-run.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3-2 
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-07 at 11:22 +0000, Josua Mayer wrote:
>=20
> Can you confirm the physical number of sata ports on your board?
>=20

The second port indeed seems not wired on Turris Omnia.
If the "masking port_map 0x3 -> 0x1" kernel warning had not suddenly appear=
ed, I would not have noticed this at all.

> I would be curious whether in another board that has two ports physically=
,
> whether both of them were functional before my patch.

I don't have such a board, but to me it seems the existing code was made ex=
actly for that case.

For reference, my board later reports
  ata2: SATA link down (SStatus 0 SControl 300)
  ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)

Best regards, Klaus
