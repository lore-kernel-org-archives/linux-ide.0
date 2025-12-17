Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C06334C3C
	for <linux-ide@vger.kernel.org>; Wed, 17 Dec 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765972957; cv=none; b=E0g3iN3TLsabvfWp5CTUVSZW2+eZPeIHTz4+WqnH/XrPUXYsBqKh31QmEL06UGBdmxZCapfFKaaYeA5LJFyzKh1C5j/zttOzNsnr/SB8whr2Cw85k8rIAtyjLSeGClYgjrLYMejunH59mp/UCoTkyqSHl5+n+p7kpEE/7Fem6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765972957; c=relaxed/simple;
	bh=0KNtJdTOLYH11to739a2kWupOMu2KuUwEFh7BLSnkag=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gVf0m3zq4HXVF2s590GVRzVq4vb+nd3JjuhnWg/m2nIe2DgaZfQ5koZVWDp25Z4bP1QgMozd+EJN3BYJfLWa/4HENTa57+JGG9Onen80o8Vls/CUslyolhp3ARxB587mRHxotIWkOKk/E+mXXKk5KSPzMVuxtBkaDrNRs3fT+K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtkgNy+R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtkgNy+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F25C4CEF5;
	Wed, 17 Dec 2025 12:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765972956;
	bh=0KNtJdTOLYH11to739a2kWupOMu2KuUwEFh7BLSnkag=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dtkgNy+R3ZqOz0a4t7I/NAYVxNwhXLVkhCb5K+DuLNkl9YEiM6C9pkzuAu52lRLmO
	 neUHoVf382/meudHT4UDunSW4Pe2YvzsnyIr8Pq8uuEMk6bfMpJe1JFC4oj62Bul76
	 Q9r/SqvHG/iEaCpm6rI2E/KcSAh9hfXS2oFxDA7GAqPLSwH8gCPsq9SabUfGGMASCC
	 vqWKSFy1pUViF9sA4ZslWMAaL/Mqkzmo+8f7SVIKY2rcrqfdegtTN2Klu8Fgk0SRXj
	 oRQgKhFVe3fTP8HTRfby1FhPJvBsnYW2tPL0D+Z2ZJruC2JoNNmskevgmU3WoEUJWO
	 ypBG5yvLP/3/A==
Date: Wed, 17 Dec 2025 21:02:32 +0900
From: Niklas Cassel <cassel@kernel.org>
To: eyal@eyal.emu.id.au, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
 list linux-ide <linux-ide@vger.kernel.org>
CC: Damien Le Moal <dlemoal@kernel.org>
Subject: Re: ata timeout exceptions
User-Agent: Thunderbird for Android
In-Reply-To: <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au> <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au> <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org> <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
Message-ID: <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17 December 2025 20:56:07 GMT+09:00, Eyal Lebedinsky <eyal@eyal=2Eemu=2E=
id=2Eau> wrote:
>On 17/12/25 12:35, Damien Le Moal wrote:
>> On 12/17/25 08:39, Eyal Lebedinsky wrote:
>>> Resolved=2E
>>>=20
>>> Limiting disk access bandwidth (as suggested by Damien Le Moal <dlemoa=
l@kernel=2Eorg>)
>>> 	# echo 1280 > /sys/block/sdX/queue/max_sectors_kb
>>> did the trick=2E No pauses/resets anymore for over a month=2E
>>=20
>> We now have patches queued up to limit max_sectors_kb for devices and
>> controllers behaving badly=2E If you send us your device information (h=
dparm -I)
>> and controller info (PCI ID of your AHCI adapter), we can add a permane=
nt quirk=2E
>>=20
>> Though we would need to determine if is is the device or the adapter th=
at is
>> mis-behaving, and also ideally, the command size at which things break=
=2E
>> We had another case with a device breaking above 4MiB commands=2E A qui=
rk setting
>> max hw sectors to 8191 sectors solved the issue=2E
>
>The machine is: Gigabyte Z390 UD, BIOS AMI F8
>
>The disk is, according to smartctl:
>	Model Family:     Seagate Archive HDD (SMR)
>	Device Model:     ST8000AS0002-1NA17Z
>	Firmware Version: AR13
>	User Capacity:    8,001,563,222,016 bytes [8=2E00 TB]
>	Sector Sizes:     512 bytes logical, 4096 bytes physical
>There was no hw change during this period=2E
>
>Here is what I think:
>
>This disk did not exhibit the problem for the last 1=2E5 years when it wa=
s in constant use=2E
>	[before that, since Jan/2016, it was used every few months as a backup d=
isk]
>Then, last month it started to show the problem=2E
>
>Being an early SMR disk, is it possible that it reached a state where all=
 block updates require a track read/write
>(no more unused tracks) and at high bandwidth it gets into trouble=2E It =
did not matter how high I set the timeout
>(I tested up to 240) it always timed out if any pause was encountered=2E
>
>Being a rather old disk (a 2014 model?)
>	Maybe a fw bug?
>	Maybe an SMR design misfeature?
>
>Do you want me to try different max_sectors_kb values to see where it bre=
aks?
>

You can also try this:

https://github=2Ecom/floatious/max-sectors-quirk

It tries these max_sector_kb values:
declare -a sizes=3D(128 1024 2048 3072 4095 4096)

You can simply modify the script if you want to try more intermediate size=
s=2E


Kind regards,
Niklas
