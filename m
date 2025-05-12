Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178125D8E7
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041925; cv=none; b=i7gWn3Ll5i13oTwbq5ldJqWcWOmp1Mpkw2SrSY062hR8k6qMSZtemrzbEmHsf1I8bokUdFxBAbpSLalP9in4t0HOpc7t57VFOOI7fyK/whQTNlojN4DC++Wr1TUiwFB3OJp38iR6f8UFkF7zyrGdekYAdXGT1Bnmlj74nQeyp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041925; c=relaxed/simple;
	bh=hMX6XfCKPtF6/yPQibSU9YsliW2aPL7yUTyWU6jUhVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GA93To38U8WALwirMC4ZTMGWIpspivXpjwRJI46cZpbZOgjIkoH0EjiBK9XnPIH3hBxi9ZXmMqJZiSIECm/0PuyBHRc58PZVQBQ7+8jPFOTP2gTyNS0fcdNO2ocr/Ae5Vlhemntn2NQxACfAsUCEb0LiicClTx+47UM1m8v+sd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxBS+nWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxBS+nWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD35AC4CEE7;
	Mon, 12 May 2025 09:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747041925;
	bh=hMX6XfCKPtF6/yPQibSU9YsliW2aPL7yUTyWU6jUhVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxBS+nWMbWwqVS80cbzlMM98XWEseCOuXFEeB43H1H42l/FMu9zm1YREJqY9jk+0r
	 r/9xkayh504lo0a/rIAkPxpHQqaFvc2EiviTAyT2GZVAIRS1zXDomHjqnBS/IPmnPg
	 rRZn0hNRNl6F6pKT8OMpkO+yKBDiBSllJ6GnDFFtOzfgRQAYtNX+M5YBS/6SXmdhZ+
	 ZWS4C3NSSmG1EPUzRg+xgh1UCnhByTqIdjdrmWRkeGLh0QBtrgzthoMnFxfBbkgOWD
	 FW8BtEJzoAgqgWr+SA3Xi1tnX/AdiMa6SqfijUYxvx9EiWBp1+ZFghseqiYqLRr9Dg
	 tJoovd9jtlDdg==
Date: Mon, 12 May 2025 11:25:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aCG-gS2f3uXKaQPj@ryzen>
References: <aBjbSt5hTaUP_JhG@ryzen>
 <CAAZ0mTctoC5UCsDVH56x5OS_500URheBU66USNuq+rwktLrEiw@mail.gmail.com>
 <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
 <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen>
 <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
 <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>

Hello Mikko,

On Mon, May 12, 2025 at 08:37:51AM +0300, Mikko Juhani Korhonen wrote:
> To clarify:
> I have a aROG STRIX B550-F GAMING (WI-FI) motherboard with 6 SATA
> ports from which I can use due to space restrictions 3,4,5,6. New
> info: having checked the manual I notice ports 5 and 6 are special,
> they can be used only when M.2_2 slot is not populated.
> I have WDC WD20EFAX-68FB5N0 and WDC WD5000AAKX-001CA0 drives.

Excellent find!

Out of curiosity, do you have the M.2_2 slot populated ?


> 
> Every combination worked up to 6.8.12 but it were lpm-pol
> keep_firmware_settings.
> 
> After that works:
> sata ports 5,6 -> WDC WD5000AAKX-001CA0
> sata ports 3,4 -> WDC WD5000AAKX-001CA0
> sata ports 3,4 -> WDC WD20EFAX-68FB5N0
> Not working:
> sata ports 5,6 -> WDC WD20EFAX-68FB5N0
> but setting link_power_management_policy to max_performance gets it going.
> 
> 
> > Basically, we wanted to compare the good 6.14.5 output with the bad 6.14.5 output, especially the lpm-pol output.

Ok, so the bad 6.14.5 dmesg you shared before (where you got timeouts),
was when using SATA ports 5,6 ?


If so, it seems that you've managed to narrow it down to:

Things works as expected on 6.14.5, when using ports 3-4 (and most likely
port 1-2), lpm-pol is 3, which means that LPM is enabled (it also means
that hotplug is not enabled in BIOS).

You get timeouts on 6.14.5, when using ports 5-6, lpm-pol is 3, which
means that LPM is enabled (it also means that hotplug is not enabled in
BIOS).


I think this makes things more complicated, since as you have figured out
yourself, LPM appears to work correctly on AMD 500 Series SATA Controller,
when using the ports that are not also used for NVMe.

This means that it would be wrong to apply a quirk for this specific
controller (as that quirk would apply for all ports).

Since this LPM issue only affects the ports that are also used for NVMe,
this is most likely a BIOS / motherboard bug, and not a HW bug in the AHCI
controller.

So, if we really want to have a quirk which disables LPM only for ports 5-6,
it would probably have to be a DMI quirk, which matches the motherboard name,
see e.g.:
https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/ahci.c#L1120-L1145


Kind regards,
Niklas
