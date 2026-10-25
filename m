Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792899868;
	b=p3Dh6KrrFtE03rwSYQrE8ZxSRumZMyda4Y8Cbj/AIxitljWImirgJhBXyJyTJWWsaQFM
	 uFdSrVSuWT0THScSyJDjVGHqWsjs179wmIKpI3/5dQ6S0JmJ57TINosgc8Ctr+kLTh76S
	 DHLD/jNLIKCLgUw8j5+K3I7aURAuWSIy6V2Vb5MeLTGZu48MWnB1iTsodcyp73oEBECWB
	 upqIK6PfXT/vS5RKX5KlY7FLYAUsur2e9NRJc5DhYT+JC+VN8zrL0WQZVsgopQ98mYq6g
	 b1tT/rSx/UNVdzPeRyrJPRb3ABCtcCRZ7Mt4vMP08i1m1R3hFfyK3YSUzpj9IFVTkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792899868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
	b=HHxhpEhs6nD+4z+BMe6kSw+UR0atOcJY77Upv/wb1/kwZrXAFcmr34bhxfMBZQE6HIPJ
	 qcY7OxzUdJ6mVLwu7kFj6465YVgeifPMPpjevr1Lc9XCNyUvoQ7w5gqoA0FwWIQTogj0b
	 lV74kOhLQFjAy0ltt7K3hsxr8xBZDtrnWdS86x3mtLKdXPgVlbgLupSFG8wjvpj8EJeG9
	 ArGBtorYMwL905p6vHf8H0L2Gz1xJyv5Nvp44X/ODuulffeg8tUKokgYZ/XWTQ0Kyf9o6
	 +i/zt3uc7vYYcvxHU5T98jgehNJc0L6sefOb45sCShvwV3/pJV5SuxJVI1JbCqzkzlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=inpmsh23;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93A6606A31D
	for <linux-ide@vger.kernel.org>; Sun, 25 Oct 2026 03:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E93A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=inpmsh23
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ab41538192so1527257a91.0
        for <linux-ide@vger.kernel.org>; Sat, 24 Oct 2026 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792899867; x=1793504667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
        b=inpmsh23JZihZWIdxCXdcljqgx0ZfDMt/YGILuWXDgk8+0JzAgMh0ettSpv+Tv+NSY
         mQw7yi3bz6cK+qKRZrcd7gvHgnrcWDWdhG6JnkS0V0/Qo5LGOgTw7Qt4yqCuTrEO1lrS
         RIHQDLJdnMNWv5RGy6z3OJ7kBzFvi37Eb6vLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792899867; x=1793504667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mzxcYUCwTt0YqgjKp0GiJp4QFX6CqOyEppZJrIxJY7A=;
        b=OhOtt2w3nKmx+bRLqcO9FTAdKTd0XMh6B/dTQL0wArT63TMekm3Q3tbreuBMEuFEIT
         CHTPG3sb1fLhNRyBb/r99pprxWAok7gheQZAwgzU6myk6Y7PwvS7A84RQwiJDeNdEUp/
         GJQPjjyRSABVJHpIYFWPDNXxYwYdgzmWhSmfh54jb7Q/n8DD88Wwbx26gdBx11YEt9Tk
         yMtlFjufPtpEfrrZ7xLxD/I4MGcxt7j/tCyLZ18xG0+cwBM5NykUSfZV0d2mIFu9ApCp
         yoUtUrZAvSPNQACPmUp4DV+6sB1UI5W2YqYrM1aHsiFexep9c87cijEwatf9EF+QcYn4
         N/jQ==
X-Forwarded-Encrypted: i=1; AKwUvByt9xtU53UFfwCSFYRgGGQLiOfcqrSvvb14RsDALoIG9k/JyWvnO2oc2rdeKHeMrdp4kJfHf+/bxF4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLt5ld1TVVDg7r78kTsO4Szao0FiL1Spaut9lAlXBD0W8pu4W2V
	bKdgYLUvwPvcFd+sX4FWIEX3pnZ0mrdnbDm4P6E3eebBag+IhxrBzoJvi/KRwUeofM0=
X-Gm-Gg: AYBFou3qWQR4yHllynzHqqoz3cNp9tja8YD60w3kgEwtiRfur8PxXeQ01fNsmEfm57u
	WrBnBQkmkOAKVbMsc/gCvYApZVOypz6DvwNTKZY+WenX4y/VuyDlVaIAT0Tz7aE3XwSOWGxzt8w
	Eh+iqinyET5SOLKSqON5YrnmU2TBGJOpLI4z0+BA1pddFCRtGVKdxK4fs623syZyAV31DRBmpCF
	iKAL90f4xOUK8P6vjix34D0urLSoWN1LQ0xn4GW/FRsWww1vBDiUV3Nv49nN8GeBMQjRTuzmP+U
	9gjZYKAUmm9OaI9Jmy7/HPlii+eoTv7TQwZlU15vkQvaaWqnc7c39OeRGGllUSuLYv3qTo23K2A
	j1jDzC6436vs4sHfpo+N/iKAtXKK0bpadTRmzQkac3vVt97HQCmx05e8GNqcth+XbgcZmE4tlXq
	iSO/8yTsyQTauSdoSxc4YYqyhYbPhZH89m4J/v47BdkwtbK2f14osi57NmwSN30WJNCA8wkLfML
	NBfH9hwZ10XIr4sp4uMh5Ktm5P+EzPJLrVXBmtB81JvDuZ7bsO/btF3qPoNPevhtpQmkx43TzYJ
	XEpTyOL7To/98IcQjydI
X-Received: by 2002:a17:90b:4c8b:b0:3a4:f8da:2478 with SMTP id 98e67ed59e1d1-3adeae9c560mr3198326a91.29.1792899867044;
        Sat, 24 Oct 2026 20:44:27 -0700 (PDT)
Received: from shiro (p1469046-ipxg00b01sizuokaden.shizuoka.ocn.ne.jp. [153.223.97.46])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adebe8f0b2sm4181927a91.8.2026.10.24.20.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:44:25 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Colton Pawielski <colton.pawielski@gmail.com>
Subject: [PATCH v2 0/2] sh: Fix IDE on landisk (HDD models)
Date: Sun, 25 Oct 2026 12:44:08 +0900
Message-ID: <20261025034410.808796-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I dug out my landisk to look at kexec for Geert. Since I'm lazy and
LLMs are good at fixing bitrot I let my LLM work out how to get
it to boot again.

There are some other issues (perf is apparently borken, there are
some issues with the decompresor and big kernels..) but this
seems to be the only thing stopping it booting with the defconfig.

Disclaimer since we don't need to give LLM tags anymore:
- LLM debugged the issue.
- It has been checked on real hardware.
- I have checked the IDE driver patch, cleaned it up and
  cleaned out massive walls of text that LLMs seem to like
  to add but I have left its summary of the issue in the commit
  message.

Changelog:

v2:
- Fixed up the patch to pata_artop.c so it looks a bit nicer.
- Updated the text in places to reflect that this covers the
  models of landisk that use a PCI IDE controller.
- Florian said that the pata_artop.c patch might change the behaviour
  if the pci_iomap() fails. I think this is ok, if pci_iomap() fails
  there is no point continuing into the core driver where it'll just
  fail again.
- I'll address the remaining style issues in pata_artop.c later.
- Somehow I have now ended up with the CF based model (USL-5P) too
  and I have tested these changes don't break it. As Geert mentioned
  the CF models need their own patch to fix IDE in the defconfig.
  I have a few other fixes for the USL-5P that I'll put together into
  a series and send later.


cc: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Florian Fuchs <fuchsfl@gmail.com>
cc: Colton Pawielski <colton.pawielski@gmail.com>

Daniel Palmer (2):
  ata: pata_artop: read the ATP865 mode register through pci_iomap
  sh: landisk_defconfig: enable PATA_ARTOP for the ATP865

 arch/sh/configs/landisk_defconfig |  2 +-
 drivers/ata/pata_artop.c          | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.55.0

