Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7530E3D4114
	for <linux-ide@vger.kernel.org>; Wed,  6 May 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778057122; cv=none; b=mFSEpnvem+JksyVjJusvKvdl/QXku9s9HB0idwvp3ujicsPCl1yeHBy67xigUxSef86p7coO7khMjTyRAfCz0mWWR9zfj0TsI8xFutCLElCiNAROJtfdd4R7nw/zz5GgNvZzvR+yGjgrg+habOjghLOCaGEHvZ7+5f2A6HJAgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778057122; c=relaxed/simple;
	bh=ph54DW5NZIihPoNhqngg51t7Y1MPaSLbd2O7x7VxF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqD4oiwh15YhvUYZj3QGEGkBFkQMBwa+0IvK+2aCJMxAryDWXzMui3/6fsMX20tI1j04ASEZfsxdgg1RZxKfVY+dFNmxKCNNgf1tbbXSFvuDa5/d26BOiQ47afPVuZflq0Hctera7QQ5cH0OR360aSlrBH55oJX/NKLezTiMYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vjdhnAD+; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vjdhnAD+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=ph54DW5NZIihPoNhqngg51t7Y1MPaSLbd2O7x7VxF1E=; b=vjdhnAD+KYWmsmAA08NwXr4Qsv
	KDyg2xA5LpHzwV0/0y+QcbfUs+nktgCn86tgbKS76+cpE+JcxJVFtM66TX7l382hICguTX/qmqUod
	LFd1G3NLV9fR87eGV7K2HYFmIRQ4ovYRmShTohxQdrzLtJYFAXkep1a2RpWvy97xYvgCf6Fh3K+aM
	E4sbkcqkHsAswBNtmKz3FAqRJq5EoSfwr0CZS+cWwRI5Pc0CsUK9KW/9WAb20r8w39PPvROadatPf
	ZphOsD4b+NRm7K8qKR/KqdivecDZJU5htO1vVfRC9YheXa/MMeK2edQ9ZpTXldwT0Cn8wvGn2V5dt
	SNJxmr8A==;
From: Heiko Stuebner <heiko@sntech.de>
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
Date: Wed, 06 May 2026 10:45:08 +0200
Message-ID: <8711044.4vTCxPXJkl@phil>
In-Reply-To: <ec407a6d-2164-4252-90f0-0aebe8227290@tkel.ly>
References:
 <20260501125410.1204490-5-cassel@kernel.org>
 <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
 <ec407a6d-2164-4252-90f0-0aebe8227290@tkel.ly>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 6. Mai 2026, 02:13:41 Mitteleurop=C3=A4ische Sommerzeit schrie=
b Tommy Kelly:
> On 5/2/26 17:59, Tommy Kelly wrote:
> >=20
> > I will also apply the FBS devicetree change (5918bf2) and test with tha=
t too.
> >=20
>=20
> Special thank you to Heiko for the FBS support!
> His patch setting PxCMD.FBSCP works: https://lore.kernel.org/all/20260201=
191804.41421-2-heiko@sntech.de/

well that is a pleasant surprise :-D .

I just needed the port node to hook y phy-supply into, and therefore
checked what capabilities were supported/which properties needed to go
in there ... but really glad it helps you too :-)

Heiko


> I compiled the FBS devicetree change into u-boot (which passes the fdt to=
 linux),
> and running on unpatched linux 6.19.12,
> FBS works, and no regressions are present.
> Logs:
>=20
> > Linux version 6.19.12-200.fc43.aarch64
> > ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> > ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> > platform fc800000.sata:sata-port@0: supply target not found, using dumm=
y regulator
> > ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> > ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> > platform fc800000.sata:sata-port@0: supply target not found, using dumm=
y regulator
> > ahci-dwc fc800000.sata: supply ahci not found, using dummy regulator
> > ahci-dwc fc800000.sata: supply phy not found, using dummy regulator
> > platform fc800000.sata:sata-port@0: supply target not found, using dumm=
y regulator
> > ahci-dwc fc800000.sata: PMPn is limited up to 5 ports
> > ahci-dwc fc800000.sata: forcing port_map 0x0 -> 0x1
> > ahci-dwc fc800000.sata: masking port_map 0x1 -> 0x1
> > ahci-dwc fc800000.sata: AHCI vers 0001.0300, 32 command slots, 6 Gbps, =
platform mode
> > ahci-dwc fc800000.sata: 1/1 ports implemented (port mask 0x1)
> > ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slu=
m part ccc apst=20
> > scsi host0: ahci-dwc
> > ata1: SATA max UDMA/133 mmio [mem 0xfc800000-0xfc800fff] port 0x100 irq=
 59 lpm-pol 0
> > ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> > ata1.15: Port Multiplier 1.2, 0x197b:0x5755 r0, 5 ports, feat 0x5/0xf
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.00: hard resetting link
> > ahci-dwc fc800000.sata: FBS is disabled
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.00: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> > ata1.01: hard resetting link
> > ahci-dwc fc800000.sata: FBS is disabled
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.01: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> > ata1.02: hard resetting link
> > ahci-dwc fc800000.sata: FBS is disabled
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 330)
> > ata1.03: hard resetting link
> > ahci-dwc fc800000.sata: FBS is disabled
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.03: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
> > ata1.04: hard resetting link
> > ahci-dwc fc800000.sata: FBS is disabled
> > ahci-dwc fc800000.sata: FBS is enabled
> > ata1.04: SATA link up 6.0 Gbps (SStatus 133 SControl 330)
>=20
>=20
> Again, that is before this patch series, I see no queue_depth regression =
with FBS.
> As opposed to CBS which had a regression in the 6.19.x series.
>=20
> I can test with this patch series + FBS if you'd like.
>=20
> - Tommy
>=20
>=20




