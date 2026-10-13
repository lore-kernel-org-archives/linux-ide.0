Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929D44FC8F7;
	Tue, 13 Oct 2026 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898777; cv=none; b=ipWm/+a8pawC62gcMXUGKr4UijTws/5qKqRPkxMFEw++gozsVqkOQR1mMvghoLg9T811xnexrRtt9iVFnA0rAJ+w84ZZq2ZE/RacABt709iX1Ne+X0UkAdC4b12GbBvWN0LWZ2sOv8mUc25OIUXiqCU7pfGjXCXBxfwqEzqi8Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898777; c=relaxed/simple;
	bh=2WZGIqEbldNKhXLHKAuCMhGNUX/RELV4QSiH5d6ZLE8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B43oMzDB86cgGB+RyHxPb7ob80yFpgYJJ3eW04hdQ7yWc9O+ieOtL9fWh3fejfkj87A48oR96kEJ1HC7m7qZ12j/ftntQSXuMA8CtduOZnc2vBWU3jAzjbmxTbXY/4VpsEjB4VYcetvZH3ks2j4vux4o5v0nQTJb6zysOd9eDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg01ATRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg01ATRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FEF1F000FF;
	Tue, 13 Oct 2026 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898776;
	bh=uwDMgIaomJD8m439CAgoY3FZDR+usALINXr9CkGDmlA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dg01ATRD9kqp3Q8jqcc7Thw9V0pItC95JSWKB9Uk2fSEnSn4Z6GOG9MYscI4pbxy/
	 fhqnL198U3Rm5prcjKSxXbs19N0LE4RJjcH+3SSXUeb2ogfmgtwK2qjYNxV/AA7tSX
	 3oU/86v7Rues+MpQwsAKEO0HRKRFpXLh9u6S+ea6zXdRCo+JNaBbIeLVDpUEnAqjqW
	 nbaf5PjgGwSLz+5YELt2Ic74Oh97b88dV96rye5k5pkvXvGhH+ZFeX2Td1XHGaSUOX
	 Vk6PPyz6tfZGzSHkpXS6Wf7PvD0dh5+CBL3KmlyTeyEt+lMlQHIKdTO1FYE2VOZH8v
	 YpSCXX12WyGIw==
Date: Tue, 13 Oct 2026 15:38:33 +0200 (CEST)
From: Imre Kaloz <kaloz@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Lee Jones <lee@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
    linux-ide@vger.kernel.org
Subject: Re: [PATCH v2 47/53] MAINTAINERS: add an entry for the SGI IOC4 ATA
 driver
In-Reply-To: <abe9654f-c81d-427a-97ec-a9c4d4e18f74@kernel.org>
Message-ID: <70b2e9c4-0b8a-1b73-1690-e9c31fbe080d@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org> <7e185e14e16f071b0850087e30f6cac4af85b1f1.1791890466.git.kaloz@kernel.org> <abe9654f-c81d-427a-97ec-a9c4d4e18f74@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-44373446-1791898716=:27186"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-44373446-1791898716=:27186
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Hi Damien,

On Tue, 13 Oct 2026, Damien Le Moal wrote:

> On 2026/10/13 15:17, Imre Kaloz wrote:
>> Add an entry for drivers/ata/pata_sgiioc4.c, the libata driver for the
>> IOC4 ATA/ATAPI controller.
>>
>> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
>> ---
>>  MAINTAINERS | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a30c09a55c72..826f0ffb71fd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -24925,6 +24925,12 @@ F:	include/linux/phylink.h
>>  F:	include/linux/sfp.h
>>  K:	phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
>>
>> +SGI IOC4 ATA DRIVER
>> +M:	Imre Kaloz <kaloz@kernel.org>
>> +L:	linux-ide@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/ata/pata_sgiioc4.c
>> +
>>  SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>>  M:	D. Wythe <alibuda@linux.alibaba.com>
>>  M:	Dust Li <dust.li@linux.alibaba.com>
>
> Please squash this into patch 45.
>
> Also, the cover letter mentions that patch 45-47 are for libata but I did not
> receive patch 46. I only received the cover letter, and patches 45 and 47.
>
> Are you planning to get all of this merged through the mips tree?

Will squash 47 into 45 in v3.

Sorry about 46: it only touches drivers/mfd/ioc3.c and 
arch/mips/include/asm/sn/ioc4.h, so get_maintainer left linux-ide off it. 
It adds the IOC4 ATA/ATAPI MFD cell that pata_sgiioc4 binds to:
https://lore.kernel.org/all/754bae380c938b63eeaa87e3dccf9755314675ed.1791890466.git.kaloz@kernel.org/
v3 will copy you and linux-ide on it.

As for merging: pata_sgiioc4 depends on the IOC4 support added earlier in 
the series (asm/sn/ioc4.h and the MFD cell), so I’d like it to go through 
the MIPS tree with your ack, if that works for you.


Best,
Imre
--8323329-44373446-1791898716=:27186--
