Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FF3AE5EA
	for <linux-ide@vger.kernel.org>; Mon,  5 May 2025 23:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488027; cv=none; b=J3rfW04iYErCYiLnBWHCGqY8yolUZUnmeOjnelxm1qpXoVoOHoax1Ud+mTpJF4P2vYsejq2P/Y+JCq2D9KpcckSfUOeZ9GFKQUiHMwhOY90e4YzH8GixdV0omCS61xOlWWB9kBwSOXMVH2J9J3Ee/GanPQFFEObmV7sfDluRSeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488027; c=relaxed/simple;
	bh=TnuWVm6BDDlNVhUQyrMRSzkZiudi57NnCMT5fSqM26E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pVfvpGQf2gz0goEYWpyjwhMmLNbzT/JR9JCjjbBU7b4qNVfaTpnYYwdv6IcShkxtHNecSiavOwb8E7rpDKjs91/U9siNR8UqSe8AUkGPkv2zY33en7XrSe2hmEYmx3wShnhZ5jBH47mWCiLxAmXcUPPCGyvBz01CcD7wwkld/Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkLBJeHn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkLBJeHn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A0C4CEE4;
	Mon,  5 May 2025 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746488025;
	bh=TnuWVm6BDDlNVhUQyrMRSzkZiudi57NnCMT5fSqM26E=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SkLBJeHnmvh27BvzFFfgKOMog7AWmiNUAc7waLC/gLFhFLcKWvYoi/5mH4h6fMeVt
	 mMLKBG8AXyfxq4XzGN7UeRjbGyMM5u/8oTQKqi9oyEH711Sit7WWed2r81LM+67gw6
	 cqRJKmpsG+fsPdnNQ+HBroc2Un6HWnbCPkq0RwpxGcN6JQQljYQWIbQoP0mH12oWww
	 7gr2/nVlf1wuCJImprUmJy63TsezhYHHv8ADUA4ae/8LoXMvVjrg2oGscP1MjKkMWw
	 6kXMd/aiJkMZIzJv41iY+Gr8JG7hDRU9hSMtPlAJuF18139HDHvdF2F5W2siAwwH9C
	 1kyh5nO6yvPtw==
Message-ID: <ac90ffbe-0f14-4cc0-9ba6-56552db48f62@kernel.org>
Date: Tue, 6 May 2025 08:33:44 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0 hard
 drives
To: Ioannis Barkas <jnyb.de@gmail.com>, linux-ide@vger.kernel.org,
 Mikko Juhani Korhonen <mjkorhon@gmail.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>
References: <CADUzMVaY_nv1tjFtSuuPiNE6=_h2LABaDAjuOhK=FUdDB-LsrQ@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CADUzMVaY_nv1tjFtSuuPiNE6=_h2LABaDAjuOhK=FUdDB-LsrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 04:38, Ioannis Barkas wrote:
> Hello Mikko, thanks for sharing all those details, we have some
> additional information on this.

You did not do a reply-all...

> 
> I am suspicious with hw and not with you. A quirk will affect lots of
> devices and we need to be sure that we have examined the error you get
> so that there is no need to revert things. FYI, I have a disk with a
> quirk for no obvious reason on all hosts because nForce had NCQ
> trouble with it. If a quirk gets applied usually it stays for a long
> time if not forever.
> 
> Back to your case, on first look I can see that disks are in mint
> condition and are running the default fw, 82.00A82. Damien is there a
> newer version available?

I need to disk serial numbers for checking that but Mikko redacted it.

Mikko,

Please send me the serial numbers of your disks. You can send that privately to
me. Thanks.

> Please run a short test to each one to ensure that everything is OK
> after working for 10K+ hours and share their health log again. It is
> clear that both go south at the same time so RAID array dies as
> expected following that initial event. You just leave the PC on and
> then you get that event on both?
> 
> Supposing you get no error at disks after all that but still disks go
> offline, I would suggest to update your board fw to version 3621 and
> retest. The controller-disk combo should work fine. Just to clarify
> things, upon turning off LPM, you get no error at all?
> 
> Except the short form of lspci, let's get the fulll dump for SATA
> controller to see its active PCI settings with:
> sudo lspci -nnnnvvvvxxxxks 01:00.1
> 
> You can get it before touching anything and then with 3621 fw if you
> update your board. This will pinpoint if anything has been modified
> between different fw releases.
> 
> If the problem remains no matter what, a quirk is inevitable. Do we
> wish to block LPM on Intel hosts while no one has reported errors? How
> about a new quirk called ATA_QUIRK_NO_LPM_ON_AMD500 for 500 series ICs
> or ATA_QUIRK_NO_LPM_ON_AMD similar to ATA_QUIRK_NO_LPM_ON_ATI blocking
> LPM for ATI chips?
> 
> Best regards,
> Ioannis
> 


-- 
Damien Le Moal
Western Digital Research
