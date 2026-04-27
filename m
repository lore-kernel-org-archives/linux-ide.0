Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5467370D56
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777321957; cv=none; b=TrQu4BZaBIvmwskC52cL6o6IOzXETMD9FB8w9RhUH4XTAYVyKmRROSLR3URteKytPxuAW4P0r7G47V4wV8ja2lfLq4UHMxllYCTwpkBrshNs2MWkcx7Fq8ZauHfmE5lcmzDl9FRMTsy3xQ1jFW/uo11bCxzvFqMerM9xwetDuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777321957; c=relaxed/simple;
	bh=3ZLJCAX9kzQtvfT+xKKufH6JV5xXwKlhclsqcKfFlZ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=fSeq+ozOlrIJqDeiPeUkbL3Zv0dRifgMn8gZ6e6yQg0raQavV5LHR39Jdva8bkyiStjaloxYJPtNjMRz6GTL7+Upy/enKxZG5HMYeCfzwvPdpz/4Dvq7ehT4DeSpx6GEjdVr2lQEKefy70wi+M48Xv/3Yn13EvX+tzHgSlSt06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBHZd74A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBHZd74A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBD7C19425;
	Mon, 27 Apr 2026 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777321956;
	bh=3ZLJCAX9kzQtvfT+xKKufH6JV5xXwKlhclsqcKfFlZ0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=VBHZd74AXowaFQ97VVWYaAlXsYgYzw0kXQKPSgy3+1X+DpBy2FHiWfA0RxBk4UqJp
	 /qTdDoRI2fYoNClA0fQkJGn3izP908Hni/wwEhn6GOLflhEqTTresutblfix34ffE3
	 v5oVxK2Rik/hNq20uslqiXPaku9C2qfHGgrcWRHl1i3YJoc4Q1cKUWfreJI9H058ck
	 bpE0Wxru32xJKODZsR+aVujt92GRfPxCQieL+HhJMFf9F0wDH1NyQXPnDJFprdz2U9
	 kMJm/4usziP/+FCrSQJTW5xAMUmlB297kRu/CmOb8k+Nigd0sqFR/y3DwIWu4Hnit1
	 5hhuNdDv5drug==
Date: Mon, 27 Apr 2026 22:32:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, dayou5941@163.com
CC: linux-ide@vger.kernel.org, liyouhong@kylinos.cn
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_ata=3A_ahci=3A_fail_prob?=
 =?US-ASCII?Q?e_if_BAR_too_small_for_claimed_ports?=
User-Agent: Thunderbird for Android
In-Reply-To: <a805fa86-0fe7-4803-ad2e-45719415f263@kernel.org>
References: <20260427060546.1407439-1-dayou5941@163.com> <ae9TGoaQAi7dOVc0@ryzen> <a805fa86-0fe7-4803-ad2e-45719415f263@kernel.org>
Message-ID: <6149B806-C296-42DE-BF0E-119E8AF6129B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 April 2026 22:23:12 CEST, Damien Le Moal <dlemoal@kernel=2Eorg> wrote=
:
>On 2026/04/27 21:14, Niklas Cassel wrote:
>>> +			 max_ports, last_port_end,
>>> +			 (unsigned long long)bar_size);
>>=20
>> Print resource_size_t as %pa instead of casting to unsigned long long
>> and pass bar_size by reference (&bar_size):
>> https://docs=2Ekernel=2Eorg/core-api/printk-formats=2Ehtml#physical-add=
ress-types-phys-addr-t
>>=20
>>=20
>>> +		return -ENODEV;
>>=20
>> return -EIO;
>
>I do not agree here=2E We did not do any I/O=2E If anything, this should =
be EINVAL=2E
>But I think that ENODEV is safer since we are in the probe context here a=
nd we
>do not want to see that device show up=2E


How about -ENXIO?

No such device or address


It is the only error code, except for -ENODEV
that is a valid error code to fail probe():
https://elixir=2Ebootlin=2Ecom/linux/v7=2E0=2E1/source/drivers/base/dd=2Ec=
#L653


Kind regards,
Nikla
