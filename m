Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2E14A60F
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767316882; cv=none; b=rpL/bCNs6XxM+HlfcoY30dsHSb1Y1z1Nt6c847hwYMzj/ByOXOy4abeB1qbJ6Gb6xcANCx4grfmjor/jW8dQwYfivp6XpvlCDDxqXd4D0dtab05eZjYdONEEACapuwEvUDi8RjizI3xbRdNN40mRXXMlNb6x6uvsfqq8YVnKGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767316882; c=relaxed/simple;
	bh=zQ7jVyU8nCgQ55wCKTMUNIl7O1HhtkpC3w8B9pbdC0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHMpdcGP9Qwi4RtV1E26eHvCwtENB2ExXTgfotSXEQzf+I+ZBJ+uFkNU6pRmOEZ7dVxpA3Nte+laFqT0fj0TVDqaZHqjHAwnINk6/MLN2jud9632h5qNOxbPyVYvKcuwG1AJHtsyEfdVsiZO6IUSHwPsazUySolK/kDb+Cx9LiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7xzSZo+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7xzSZo+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C95C4CEF7;
	Fri,  2 Jan 2026 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767316881;
	bh=zQ7jVyU8nCgQ55wCKTMUNIl7O1HhtkpC3w8B9pbdC0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q7xzSZo+jhuHSOQeTblmOAKQa7avFvcchzM3jPa/O/qI15G0Z+v0ph5FpaMM44XtD
	 Y9g5Y+FVHoEYGHW7RPlpV1u3kHDYTblYsmV6Q8BTWaP6tYZbaC691yuUVR5TGML+NR
	 KGliyCzHrOKKgqm6ZAEYCyHoqBkijVtklLIoiE4P7P3hB/Lbg1P88uu4f1RdftmJkl
	 fvn1JZ7gzvn+Fc+SUDknUQPe9N8Bat31gzKUGU7zlv80fL2DU9LnuqKUBLz7GX7feR
	 TxRCCFqYwop4U7YNFaFKB96Sud6aPUrHlXYh3jlZjUeI5hYnuwKdeg0PhJyUHPCz1V
	 KCY+NbFSqV57A==
Message-ID: <6a821520-a4a2-454f-b220-c62ef4bf7a99@kernel.org>
Date: Fri, 2 Jan 2026 10:21:20 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ata timeout exceptions
To: eyal@eyal.emu.id.au, list linux-ide <linux-ide@vger.kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
References: <acf2fa9f-f98d-4eb0-b18b-a04aa123201b@eyal.emu.id.au>
 <080383fe-63cf-4198-966a-b32d798bea06@eyal.emu.id.au>
 <13bf2e98-1774-4444-bc56-38a39d539d8e@kernel.org>
 <79fcb2f0-d09b-4649-bda0-55f309b20985@eyal.emu.id.au>
 <746FB9BB-5945-415F-915F-3F05D8A6B063@kernel.org>
 <582e748c-3e29-4f21-af7c-c799fb457e59@eyal.emu.id.au>
 <3d476e67-31a9-4e7d-b8cc-5bb298a6d62f@kernel.org>
 <9933af72-944e-4bb3-bab9-fdbd4fb0fad0@eyal.emu.id.au>
 <3e81e6ae-1ef0-454c-935f-eee2bba91176@eyal.emu.id.au>
 <cda2a663-10a5-4212-8725-8c780a2c291d@kernel.org>
 <0239be44-cfc7-4c99-b245-636e376df037@eyal.emu.id.au>
 <9d5644a9-8365-4dce-833a-5e26e2d79684@kernel.org>
 <f6665313-7b26-40e5-9185-ada5e63c41b0@eyal.emu.id.au>
 <893cb476-ca89-417a-a710-95f1e8c77c04@eyal.emu.id.au>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <893cb476-ca89-417a-a710-95f1e8c77c04@eyal.emu.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 07:43, Eyal Lebedinsky wrote:
> On 22/12/25 16:57, Eyal Lebedinsky wrote:
>> On 22/12/25 14:43, Damien Le Moal wrote:
> 
> [trimmed]
> 
>>> Once you confirm if we really need to maintain NCQ off or not with a small max
>>> sectors limit, we can write a proper quirk for this drive.
>>
>> I am leaving it this way. It runs the usual workload (rsync in) every 2 hours. I will report back in a few days.
> It is now "a few days" later (9 days). All is well and not a single pause observed.
> My job (rsync'ing 21GB into this disk every 2 hours) reports:
> 	max_sectors_kb=1024 timeout=120 queue_depth=32
> 
> I am keeping it with these parameters, but can try different values if it tells us anything.

If you are OK with keeping these as your default with this drive and setting
that through a udev rule or whatever else you prefer, then I think we are good.
We can make the max_sectors_kb=1024 permanent as a quirk though, but that would
be a little extreme since in the end, we are dealing with a very very slow drive
here, not really a buggy one.

> Happy New Year Everyone,

Thanks. Happy new year to you too !


-- 
Damien Le Moal
Western Digital Research
