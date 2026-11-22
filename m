Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795309442;
	b=yCWvf5tj3TU8xAqpYWH/9Dtox1wW9IAgvp5re+IPlYz8SHEtzTqF/na0c5SSuaDIFakc
	 yU1ONNSqqROUcQraG0pUooCBG7Hy0hVWxlKoyD2lcEICsDlDiPNqiKKl7Kc3f/PvTii7g
	 vuy7eMtwjvLI+qFqDNRn9BWObYYzJAD9ewhrSeHX0LkO2fXDZEWS5LPmTlHsut9KQ3B1b
	 27Ep69gtakJsNTbhkFkHDAVvAcP0YU2tcb+rWCPqtzk6HxRyFfJL91I2Xp4OdJTeECbiu
	 XKZvkBH4SMxAFycSEbT0REKDEURr6gKPWrwoUeomVc/ToJHhfI1CD0BFZVzx9QGZ+Ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309442;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=XU9CTY7WoQNjWuyj0O1gIi3t0Gan/b1npHOP4LTTvJk=;
	b=OZ2EvHF5Cbes6rRxggOaclCWBYn0VSTzTWPMD/BWDNUHnH5sYnRK5b03znYUrFSU1XiJ
	 vvF4oy7iBQmnat6dfgz59YN6Kx8D1agxeKH1U3XWeEh3fe0YqwE2aGs9vYYvocqZLyJWj
	 t6J7Q1+tnA1rG2Q+JK5TqRfEnIhQrDpcWi58Hu+yOqSNTD4VVOGoxR+Fr/5501881TFAg
	 F+bDHgrwXjn2Au/h4wsbCqJXmOEhbbcpBKeTVllhxYhzPZytACGDDkJY4zFOey8zax2OP
	 oDc3u7UiKp4KLvUkYaDEEuh1+rLDcetBOHsthxT/Mu1d4NWY6zuwl03u9z8uaXcJ5Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Or7bJpmP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BDA606A32C
	for <linux-ide@vger.kernel.org>; Sun, 22 Nov 2026 01:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41BDA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Or7bJpmP
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1b244fb7fffso2088296c88.1
        for <linux-ide@vger.kernel.org>; Sat, 21 Nov 2026 17:04:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795309440; cv=none;
        d=google.com; s=arc-20260327;
        b=p7CHoTur4U2x2zAdqJaQ6bKlvfKUmuUO0ae8Q5zdJSmAlRDVUiM5eskQwqh22monMu
         oa6U8c3ZzcTEH8DEjcrCGV+ZkmRlc9daCepndPVLZRoJf4arjvN1ZUOH/gtiAHpzYo8/
         8zLscMimopxfLvu7tSte5Ibh8Y8k+mVkOPU4P0Ms+aE7PcihxmPfEPBNAPWrA3jFGFsr
         FqbqsbyQNnyaeTXbjR1nsm25MSMjTgB7ubY/ylUz25XvaiXPYkE44MNi2I2ya64bPrBL
         6y0+TztMk0uyXLf4Yl2QM5lqNF6BcdWYCJfuGFIlsiEnmsz52pSABmFS0Y66WRZlQ8i8
         lEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XU9CTY7WoQNjWuyj0O1gIi3t0Gan/b1npHOP4LTTvJk=;
        fh=8vPZA3S4b65EavZgnZe/Zb2Q7YuAPg2OcFLN/VHvsis=;
        b=DBPasiNCwl90FwbnqPlv+54lFa+MowlJsPqxPF88mYUQnNh6DB7JgfFcEbPIoc08RO
         ttk8g6EEH7aI4nLh4kUhHglxuhrbkwT4CVBZrutnTbHT91yt+V5lH3A6jMIbS0VQYyZz
         eRheId35uM+P9Qt9jIGjpnRtpsJs7Ql1PZ4mQ3P8YC/u8MX86zLD8gObOuF7tT2f4tRm
         jSpAKknDnMBn0W0q9naSL1otM8drRh9iFv1Birjsft/IA1p8KHrn5oCcNEawwWKvAcCV
         TVm97YdrtwAcgzLBIKBYdsQSNhLMlmRcBR//LdgDAXMGKucRpdRy7MQLhKOwRaZwgFqZ
         GWgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1795309440; x=1795914240; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XU9CTY7WoQNjWuyj0O1gIi3t0Gan/b1npHOP4LTTvJk=;
        b=Or7bJpmPMdcCFB3t5NhRjZTEydDqiebvD4Vbvu/y1ErSGc5OodZjxAAXsmyucEzzIe
         yGTDt4VzIwVglh9B++JjOiylBzTux5Z4/W397y3+0i0832ysu2oMl79pVEC9Njnz7coS
         cV6WLcGxMw8DZQO5Ur3W9ktlR5U+uIRVNKS5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795309440; x=1795914240;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XU9CTY7WoQNjWuyj0O1gIi3t0Gan/b1npHOP4LTTvJk=;
        b=JedXx8HbBj0koJWCSx+Rlui9aELXeOOT31w6tggja9r8zNEl7J5TaO9aqTvUTV39JM
         L/VL3NyeEIxrdBPccOTKC7rVGnaEsW7LCvv0Cm3Gy/KXUO9z6pGn1hTbUBM/RSPJuXNj
         vmBdXeCBHdRK4QJQltXCpzWB92q9zLgnzmZnNDCEcf3n5IA+BjVMBwSYoUPbXayH55HO
         dNWnJ7RWljUsyoVQOLzCEL6UWZSeKUNZAGl3m3qmQ4YJ3UcjtvzKImHLLguYXS35zVG9
         c0UTKuCVPlbkuMgRUiOfnGM3/VQqodsnUHXbOCikANarQlQOlg4dYWcOXbOc4b/OJQ9J
         RUoA==
X-Forwarded-Encrypted: i=1; AL+hErEMM2NRgm9xmZMnSAGWftYxuRBdYKqNd3NqimLIjJX+qHAvOZP9rJI1IfeeX+rK8AYZiYcx6wnOHek=@vger.kernel.org
X-Gm-Message-State: APuU4Z906AePua1uJFLjC8EolD5j+Qd+zCj0jSR5DJe0T7FqkJz3uBr9
	YclzOuzyKGbAkMgUbDHb09mnFadlU0kHDn+ixaT6R2rWzX0uwMCHDjpKiKdkYqdeTJg0bNorcJ0
	ktB1zzHaH5gcNFOUo7GYo+uHm/mj6zpfsqciacL8vbg==
X-Gm-Gg: AZFdTZdcJ5+/JFHGiqIna9NT03Ne5fUPVI87PmCkLctMpVRBoQxDpZA6Z8DrtwckZv3
	yBnW0fihCOM2vTjW83uIFt9T3VtiYnTHIe1koDur1OOAXE7xphQ06yYlmC5IlzkhG5hAp8Wf2s2
	sBE676JsCfZBDm2HGgybYydZZIwnsR+QL6D+tLwcCLdBPz3XuyQuE3zHFrZJJYiqCurlrKo/YRE
	oseHNuOaIyILBIwNwM5V0NuCSUwDxr06+1Z9INFXagjFO8UokGE1NMQqCLDvvJ4CSlHA8hyCeq7
	yw9fNMhSoPnxhgyBJPyZaudzJNwfIh9LGutmh5/tdnYwXL0bRSPcIz+0XEXLQ0QTdtencNaLreL
	JtR7xd7uWDyOesqO+xZAG0I5SA/g3pGSiKIc691Q=
X-Received: by 2002:a05:701b:4587:b0:1b5:1a7a:2ebc with SMTP id
 a92af1059eb24-1b56f87ab60mr41806c88.16.1795309440060; Sat, 21 Nov 2026
 17:04:00 -0800 (PST)
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111163735.227286-1-p.pisati@gmail.com>
In-Reply-To: <20261111163735.227286-1-p.pisati@gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 22 Nov 2026 10:03:48 +0900
X-Gm-Features: Aa3M54q1ImzjAY62LMRYJIQ2A3YvuU8mR98bZ0JQppFgLr97xa3DaAxEG-GBzXM
Message-ID: <CAFr9PXm9+gn0Gz47TU+PG7LexCYWWrU915BLcLAHg8GSsEDDeg@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] zorro: add a CS-Lab Warp 1260 MFD
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Paolo

On Thu, 12 Nov 2026 at 01:41, Paolo Pisati <p.pisati@gmail.com> wrote:
>
> The CS-Lab Warp 1260 is an A1200 trapdoor multifunction accelerator: it
> contains a 68060, an FPGA, an ARM co-processor and several sub-devices
> hanging off them. The 68k drives the IDE interface and the RTG display
> controller directly, through the FPGA; the ARM owns most of the rest -
> USB, SD card, WiFi, audio, the Kickstart slots, the CPU clock, fan
> control and the board telemetry - and the 68k reaches it through a
> dual-port RAM mailbox.

I can't test your patches (I wish I could but I only have a 060 + G3 +
Radeon hd 2400 A4000 ;)).
But since you have an 060 could you maybe test these for me:
https://lore.kernel.org/linux-m68k/20261119123558.2108296-1-daniel@0x0f.com/T/#m42ec8c1fe97b64b22f9cfc8d7ce753937bdbab1a

I also have a fix for a small performance issue in 060 only kernels
which I'll send next if someone else can test.

Thanks,

Daniel
