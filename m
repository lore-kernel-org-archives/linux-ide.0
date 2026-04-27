Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717F3A1E92
	for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2026 22:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327824; cv=none; b=PkgY8+KF/akoMpFQDWmVdHFV6u19jrGx6CtSEmlvNWEUbZoXl6LRlMmrlNpLTPyMBF5/McyxDZyqz7doOD+BhGx761i7GOqb3m1xkCnyDAEdnZtUEpCA9Eqt78EL0BoomMsfemtWBvCi9PPJrZzbIUG8QXacpdEsh660Ig13Pe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327824; c=relaxed/simple;
	bh=F+KvTNdxpBViaqcaTjJhVqMCrPaDb5sZ6T566Oso4XU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NkgpgKjp+MeDhU4E2yUL2j6H78YadbLMg6C38Abdkd8YWYnmGFBErFtWVEE9kOXpW9X5Z/Fv2U8UEug4We3xh0uXDCfbSJUzqgLb3DW40ePqQIrO4SxxXIwCZ199Mzr2voi1tsXNhqYszHloX3ZvTzYBV9a8kvtioP3PXNu0V/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcGY6a2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcGY6a2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BBC19425;
	Mon, 27 Apr 2026 22:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327824;
	bh=F+KvTNdxpBViaqcaTjJhVqMCrPaDb5sZ6T566Oso4XU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=EcGY6a2/HtgsEd95K/H5NKBh3mDYb/u4N0d5hP+dCIWvaUEBri/h/1pSFndxO0a0H
	 Z0wK848IqssgJXvy5Yjq82tIY0vwoMZoMt7BlKaxL7BGabr0ijzk4h3aOx46GTMDda
	 ETHEYsU/kZIflc4fPr+Vzc0CSJloW7jy65MHE7lT8t4IyY6xE7bbrqMROwe4CPbcxX
	 wN9j5LmmYjeGbH6ebhm33NuanB24ILKhVGvMH0MhvmSYunmuPpIn5zZvxXn8OiTRxR
	 h17FBwr0EdvTKB3cCw1bsviaZmqz8QS2JTNPUcpy5RDyprIY65j5kcU7N1Cbd6qr2j
	 QVb9I02un5Rag==
Date: Tue, 28 Apr 2026 00:10:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, dayou5941@163.com
CC: linux-ide@vger.kernel.org, liyouhong@kylinos.cn
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_ata=3A_ahci=3A_fail_prob?=
 =?US-ASCII?Q?e_if_BAR_too_small_for_claimed_ports?=
User-Agent: Thunderbird for Android
In-Reply-To: <b135fcde-bff7-4725-87a7-3d3126af9007@kernel.org>
References: <20260427060546.1407439-1-dayou5941@163.com> <ae9TGoaQAi7dOVc0@ryzen> <a805fa86-0fe7-4803-ad2e-45719415f263@kernel.org> <6149B806-C296-42DE-BF0E-119E8AF6129B@kernel.org> <b135fcde-bff7-4725-87a7-3d3126af9007@kernel.org>
Message-ID: <84062023-B38D-434B-98BE-8ABC711CE560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27 April 2026 23:47:41 CEST, Damien Le Moal <dlemoal@kernel=2Eorg> wrote=
:
>On 2026/04/28 5:32, Niklas Cassel wrote:
>> On 27 April 2026 22:23:12 CEST, Damien Le Moal <dlemoal@kernel=2Eorg> w=
rote:
>>> On 2026/04/27 21:14, Niklas Cassel wrote:
>>>>> +			 max_ports, last_port_end,
>>>>> +			 (unsigned long long)bar_size);
>>>>
>>>> Print resource_size_t as %pa instead of casting to unsigned long long
>>>> and pass bar_size by reference (&bar_size):
>>>> https://docs=2Ekernel=2Eorg/core-api/printk-formats=2Ehtml#physical-a=
ddress-types-phys-addr-t
>>>>
>>>>
>>>>> +		return -ENODEV;
>>>>
>>>> return -EIO;
>>>
>>> I do not agree here=2E We did not do any I/O=2E If anything, this shou=
ld be EINVAL=2E
>>> But I think that ENODEV is safer since we are in the probe context her=
e and we
>>> do not want to see that device show up=2E
>>=20
>>=20
>> How about -ENXIO?
>>=20
>> No such device or address
>>=20
>>=20
>> It is the only error code, except for -ENODEV
>> that is a valid error code to fail probe():
>> https://elixir=2Ebootlin=2Ecom/linux/v7=2E0=2E1/source/drivers/base/dd=
=2Ec#L653
>
>That is my point, since we want to fail probe=2E So I would go with this =
ENODEV=2E


ENXIO and ENODEV are handled exactly the same way in dd=2Ec

Anyway, looking at dd=2Ec again, any negative error code will do=2E The on=
ly difference seems to be that the driver core will not print an error for =
ENXIO and ENODEV, but will do so for any other error code=2E

Looking at:
https://linux=2Ekernel=2Enarkive=2Ecom/NI9fvCoJ/device-driver-probe-return=
-codes

I don't think that my original suggestion of EIO is wrong=2E

Anyway, considering that all error codes will fail the probe, I'm fine wit=
h any error code (except for EPROBE_DEFER :P)


Kind regards,
Niklas
