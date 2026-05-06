Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0F46FBF
	for <linux-ide@vger.kernel.org>; Wed,  6 May 2026 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778026436; cv=none; b=lHHrZdFMF6QeHsu9KOZGZeFwf4Z9w3mdNDIOG+skUgtUR/B75ifK1YlOuG/LQ5aCpG5+1I+mIpQwbvsc/D2eMp0A6f2Xc7bY6gkyy0mDeRnMVYBMpSTEQgndaD/xb4UYMXc0S+eBase+xNbSbkARu86wm/6ah3bODRiZKnOM4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778026436; c=relaxed/simple;
	bh=I3ngZlwL6uX1E2q10xLszEaRMj0Lk3K3zRiDSw/ojOw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AtO0YVBtoLE5Ngh6cmxzj/NHzDY02yJwIRDS0vzsmNpvFxQS353XAMRKw3dKPJOK9smS8dCKtzFk/fWJF/J+HJsWM7NlPsB21Yj784wvoVMrKRPL82Nmetj9b0GQCrSc3f8kiioUHENkFOnC+hMzuF6VwQr34fTDkf+kjwlc0eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=Hlgj/1u0; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="Hlgj/1u0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1778026428; bh=I3ngZlwL6uX1E2q10xLszEaRMj0Lk3K3zRiDSw/ojOw=;
	h=Subject:From:To:Cc:References:In-Reply-To;
	b=Hlgj/1u0KEDo2NRdNn6vfMuPJ7MwXVIN1WakuE1h695ynku69AYXOZ08eggyCeBKS
	 TR7lyP5Cr1gASH6RPzCWBeFtzII3HjF/QVK5lwBe54vCeY+YnFCiNg+t6eEhxjAb2R
	 o+Jl12cp0BVQA/ORGq2hYeCfkaoAJo3M+ObG5v2QB7+MreJdSq7Qeock6IK8C6TvPM
	 /cApGNbXcZnF26pPjHQoRDKf1e+NZJQB1cM6tPNUjx0Nzt07BcAzCvscUOueMhCacm
	 fZdvKGQTNZH6gozzFxUaLyAFTiP9UxVp71eoO4P4sOS1FluYi6U2AOxCHGab29rYzf
	 NYSJtxo+Rs2Uw==
Message-ID: <ec407a6d-2164-4252-90f0-0aebe8227290@tkel.ly>
Date: Tue, 5 May 2026 17:13:41 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
From: Tommy Kelly <linux@tkel.ly>
To: Niklas Cassel <cassel@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260501125410.1204490-5-cassel@kernel.org>
 <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
Content-Language: en-US
In-Reply-To: <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/26 17:59, Tommy Kelly wrote:
> 
> I will also apply the FBS devicetree change (5918bf2) and test with that too.
> 

Special thank you to Heiko for the FBS support!
His patch setting PxCMD.FBSCP works: https://lore.kernel.org/all/20260201191804.41421-2-heiko@sntech.de/

I compiled the FBS devicetree change into u-boot (which passes the fdt to linux),
and running on unpatched linux 6.19.12,
FBS works, and no regressions are present.
Logs:

> Linux version 6.19.12-200.fc43.aarch64
> ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> platform fc800000.sata:sata-port@0: supply target not found, using dummy regulator
> ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> platform fc800000.sata:sata-port@0: supply target not found, using dummy regulator
> ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> platform fc800000.sata:sata-port@0: supply target not found, using dummy regulator
> ahci-dwc fc800000.sata: PMPn is limited up to 5 ports
> ahci-dwc fc800000.sata: forcing port_map 0x0 -> 0x1
> ahci-dwc fc800000.sata: masking port_map 0x1 -> 0x1
> ahci-dwc fc800000.sata: AHCI vers 0001.0300, 32 command slots, 6 Gbps, platform mode
> ahci-dwc fc800000.sata: 1/1 ports implemented (port mask 0x1)
> ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst 
> scsi host0: ahci-dwc
> ata1: SATA max UDMA/133 mmio [mem 0xfc800000-0xfc800fff] port 0x100 irq 59 lpm-pol 0
> ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata1.15: Port Multiplier 1.2, 0x197b:0x5755 r0, 5 ports, feat 0x5/0xf
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.00: hard resetting link
> ahci-dwc fc800000.sata: FBS is disabled
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> ata1.01: hard resetting link
> ahci-dwc fc800000.sata: FBS is disabled
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> ata1.02: hard resetting link
> ahci-dwc fc800000.sata: FBS is disabled
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> ata1.03: hard resetting link
> ahci-dwc fc800000.sata: FBS is disabled
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> ata1.04: hard resetting link
> ahci-dwc fc800000.sata: FBS is disabled
> ahci-dwc fc800000.sata: FBS is enabled
> ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)


Again, that is before this patch series, I see no queue_depth regression with FBS.
As opposed to CBS which had a regression in the 6.19.x series.

I can test with this patch series + FBS if you'd like.

- Tommy

