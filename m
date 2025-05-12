Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C561885B8
	for <linux-ide@vger.kernel.org>; Mon, 12 May 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048840; cv=none; b=Czb9v2rIiNy6ofRGDkIZMjh/cPZpUVp+LpQevTm1EQnOZ3K3KvBr91tG2cFiqGEImJWuiEiFSrRaRZknFS/wbYm9A51OtJevV34LVu00vaJWb+GP+LcMxPEDr4wDEnWIWkvOEXxlYXi3777ScdmoT/zMHeHnGl1pWwgTSkKTaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048840; c=relaxed/simple;
	bh=J7FbtwngqJ0kn/+4hTGPTUqCyyEyM8uY65frWmDHZC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAdrQW47uv7bYdx/wR5qs3Fi+JyVfKs8gHiIVqZiqDAu2wO0CBFGGddJ5q9P/Yducf17oUlqEpQsn/8WCxFMYm96tFwtoqD60KCRFUcUpP2IVxI5RytJIrgH8THLbWoCODc3NZ+HsV2CVsOWKaW0STwxau/xr1SYYdPpBGjRiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNh3D9Zr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNh3D9Zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5812FC4CEE7;
	Mon, 12 May 2025 11:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747048839;
	bh=J7FbtwngqJ0kn/+4hTGPTUqCyyEyM8uY65frWmDHZC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNh3D9ZrJuOJDDJXblamiqAVd9apYY4xUQzeR8ki3fphfSaMad0OO7ujj/kXfADwB
	 NClpw4cc9ySw1yEBG6NRmvRN2AdYUxe7GO3vKAcqcnoV3OfpAtQNNFgGVDxjZ7s7Mb
	 va0LN0AceoN/gLyAxhsbBD/AUXAtubLODoo1eRkhOr72cdMNzoZhxdPBtKEDlPRpA9
	 cOQl5EWhAkWtG1Iw1Qe0m+FXV1vcIhaYZZS9HvtYm1Ab2HnrERLt52k9VbrmkCIxCw
	 Co8FbJ+l/SIq9pbvlEyDLSbDjBiOjY0S70wt2AQG4wkqOMlqvKvVJr3a8FyyvPrk7v
	 vO5UQ76hrThqA==
Date: Mon, 12 May 2025 13:20:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mikko Juhani Korhonen <mjkorhon@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ioannis Barkas <jnyb.de@gmail.com>,
	linux-ide@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH v4] ata: libata: disable LPM for WDC WD20EFAX-68FB5N0
 hard drives
Message-ID: <aCHZg4tj6YwS9vph@ryzen>
References: <f572f7d2-7b14-476e-aab2-bf674811dee5@kernel.org>
 <CAAZ0mTf3T5RTDKtd148GyGOiVz98isFFbMDXfku8yAk9FfLVeQ@mail.gmail.com>
 <aB8_rITWsMzkTiyE@ryzen>
 <CAAZ0mTe7Tpf2F1cKbmr==43pXDUxcPP4Q2AydpyDFJUrFHzNHQ@mail.gmail.com>
 <98E34F63-CCAE-48C4-9584-9053C3D1A7FD@kernel.org>
 <CAAZ0mTdcAazi=133Dz0+OgSGOERe7WmCTr27ePudEVhkJj6VbA@mail.gmail.com>
 <48F49924-F5FE-4A91-8323-E2C789D1BEFB@kernel.org>
 <CAAZ0mTdtOVSidMeC76X9oZyHCtJdgyiu44+UEKqP5tSUaD9ZsQ@mail.gmail.com>
 <aCG-gS2f3uXKaQPj@ryzen>
 <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAZ0mTfqE+w8BBCyVSg0KKQ6fYZwKaqvh_ND8dLCANg-oMaphA@mail.gmail.com>

Hello Mikko,

On Mon, May 12, 2025 at 01:34:38PM +0300, Mikko Juhani Korhonen wrote:

(snip)

> > Ok, so the bad 6.14.5 dmesg you shared before (where you got timeouts),
> > was when using SATA ports 5,6 ?
>
> Yes, and you can see in the logs, ataX matches the motherboard's SATA
> port number.
>
>
> > So, if we really want to have a quirk which disables LPM only for ports 5-6,
> > it would probably have to be a DMI quirk, which matches the motherboard name,
> > see e.g.:
> > https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/ahci.c#L1120-L1145
>
> And even this would disable LPM for the case of
> sata ports 5,6 -> WDC WD5000AAKX-001CA0
> which works now?

Oh, that drive works on ports 5-6 ?

I assumed that no drive that supports LPM worked on ports 5-6.
(And that you simply reported WD20EFAX-68FB5N0 because that is
what you had plugged in on that port originally.)


So you are saying that:
WD5000AAKX-001CA0 works with LPM enabled (lpm-pol 3), on port 5-6.
but
WD20EFAX-68FB5N0 gets timeouts with LPM enabled (lpm-pol 3), on port 5-6.

That is weird indeed.


From your earlier emails you have shared hdparm output from:
WD20EFAX-68FB5N0

which showed:
	Enabled		Supported
	*		Host-initiated interface power management
			Device-initiated interface power management

i.e. that HIPM and DIPM was supported, but only HIPM was enabled.
That is a bit weird, since you are using this on 6.14.5 and saw lpm-pol 3,
which means: ATA_LPM_MED_POWER_WITH_DIPM.

So I would have expected both HIPM and DIPM to have shown enabled in that
case, see:
https://github.com/torvalds/linux/blob/v6.15-rc6/drivers/ata/libata-eh.c#L3510-L3521


I could not find the similar hdparm output for WDC WD5000AAKX-001CA0.
Could you please post that as well?


Kind regards,
Niklas
