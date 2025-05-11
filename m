Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466126AE4
	for <linux-ide@vger.kernel.org>; Sun, 11 May 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746989601; cv=none; b=BFJl2Fwg35WZeWDrbNlCQwH0uaJVn3K9BVO2M8XrxdXdWIoyCPRDvRGtFc+FOQZBGJ/mmFt6ptposH+gr1TgYZ8C/dqbiE2GHNeaY4JySfSkmmNo11yazegCzhVaqXIU13OMy/3onztvGkuBWiwfSxp6Ls3bCYrpSFYLhwYrZlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746989601; c=relaxed/simple;
	bh=rBajMwE00UxTubaCbJA44zyWr5TrkFgx7Jc9c8w7LNQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=E9CnZ7UU8JV9UaXWIh6hgeqRpDWwjACx9F4SVaC27BC31n6ExYU5Z73pU/MYZzI2riMmWuNTZdKQQIq3i5tjAXEJJdznY7PGAds4gjL+w6BM+Pjn8vwv3HeQPGF10DxiE5iCsCzrbJhyi40wUJCZgCXt9u75STcsZUdj8GcHy8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjOejJcD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjOejJcD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052E4C4CEE4;
	Sun, 11 May 2025 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746989600;
	bh=rBajMwE00UxTubaCbJA44zyWr5TrkFgx7Jc9c8w7LNQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=hjOejJcD5xsMSHkwpVxbvn48IgLA+UfC8JJcSFPVjo2PO2dFEwPHEvQXsJ8TDtQhq
	 jrIsNsCs8xzlgdXrHdZ1/ISRFVBUgWeNhZ4rQhIwCCNbY5CSlwWasddshl/oRnJYVq
	 Il8TVmhmqXj9Jb4mY4TJdc3t9yTyzuRt/YiUYsA1AlBSE37s/PzeOvSZHMAW24L0DL
	 9mvoKAe3okGOfSaBs/UwPlHn2QcH/j9L/CHNpcakUZb6zUiwkkEHAqPbc7shtBc2+O
	 G4Nuer5mrcWSe8szShlNgul6lpqrgPNQOaLEihrZiPNkcIN6p9z+56hAbxhXk+ZZ7R
	 WqOFkmgoHQSsA==
Date: Sun, 11 May 2025 20:53:19 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
CC: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
 linux-ide@vger.kernel.org, Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_ata=3A_libata=3A_disable_LP?=
 =?US-ASCII?Q?M_for_WDC_WD20EFAX-68FB5N0_hard_drives?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
References: <CADUzMVbneDW06V4vd8si8k=NN_6df3JeejaF3fVk2U=LVC1UHA@mail.gmail.com> <fe406980-f230-4060-9b1a-16295b6cfa48@kernel.org> <88a6fb5f-dc85-41e0-a65d-92704b4c8499@kernel.org> <CAAZ0mTeepp7G9CtLFq+U_n0h2+SF8V8j2K=0hkNAp0Fzdc7TAQ@mail.gmail.com> <aBjbSt5hTaUP_JhG@ryzen> <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com> <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org> <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com> <aB8_rITWsMzkTiyE@ryzen> <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
Message-ID: <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 11 May 2025 19:08:02 CEST, Mikko Juhani Korhonen <mjkorhon@gmail=2Ecom>=
 wrote:
>
>Hello Niklas and all!
>I have:
>linux-6=2E14=2E5/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (good)
>linux-6=2E8=2E12/=2Econfig:CONFIG_SATA_MOBILE_LPM_POLICY=3D3 (bad)
>and these are on exactly the same BIOS settings and firmware version=2E
>There is a hotplugging option for each SATA port but it's been turned
>off all the time=2E So no luck with theory that something got reverted
>to default in BIOS, sorrry!


So to me is sounds like the latest kernel probably works because BIOS has =
marked the port as either hotplug capable or external,
even though you claim that hotplug is disabled in BIOS=2E

Most likely it is this commit that made things work for you:
https://github=2Ecom/torvalds/linux/commit/ae1f3db006b71b78f2cae848b3a1446=
b02818ca7


I don't remember when that was merged,
but it was after 6=2E9=2E

So because BIOS has marked the port as external, LPM will be disabled, mas=
king the problem=2E

However, as 6=2E9 did not work (which will have LPM enabled), it seems qui=
te clear that there is bug with the AMD controller together with your WD dr=
ive=2E

Even if the latest kernel will work for you,
we probably still want to quirk the AMD controller, since other motherboar=
ds with this controller might not have marked the ports as hotplug capable =
or external=2E


Kind regards,
Niklas

