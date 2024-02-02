Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB33144625
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885625; cv=none; b=bs1x2mCGxs2z99xubzt6Cqllbuw2midkL5YlMM7cyF/lo/vZdgStz4yAmMHW8cKiRKoP2VahyddgH15bXOvN/Ww6OXlJWbRnQCpHsSNyoEOTZzJJdwlUhudmcpD0lxqFhzrGuNr/OwnQXArPr/BPb53I7pKG0bHlUgGfw/Z3wec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885625; c=relaxed/simple;
	bh=mz0eUgvgWwPpoku7Tsh2FfRj+LBhN+JBa2wr9dYmDOU=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=tXoVErubZION5wMVDpIvUG8Bx5pdfQ6d4eBnyxnXGKpqp3Y+nvwZoocCgtmFvOABAR0hejX3gqTXdeUMzVwwV65uAE/Wzw0n9v5bHB8r/cqfUR8njVPfFtZzypc4l+fpzNtiAqd//um4wq06mGiAxcgrksqRxfZ0bb4tP9Cj/p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b=fTpJ0K8Z; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=dmummenschanz@web.de header.b="fTpJ0K8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706885616; x=1707490416; i=dmummenschanz@web.de;
	bh=mz0eUgvgWwPpoku7Tsh2FfRj+LBhN+JBa2wr9dYmDOU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fTpJ0K8ZW+O4OcIaZxo80N9CjxXkvjkywofxMVxcabXqwmTKUGr1FMK9IfB1LshE
	 5lwbaITwvoEH7CGnz9od5mVFfaVMV2Lei0dxrkJ65b+PvFPdMxMZNoFDrRjIrCJvj
	 hCZuqa2974XtokhYWi56UxnPXLoWegUlzjNh+iYNsZULi8geekKCEU9VvYDLoDJhe
	 J8djcmBjTi+vRBSU2rpGu74kJcUj7E7vWgR13PLbD1TpUi3vpk722NrK7CZKuNcQW
	 SEiOa8D3vC5CnXb5Us5j0JM/RwXZdwucypzlXWqFe6c9lnH1BoCwmaxy9QS2/GA9Z
	 kbc/oz5pX1m402ZCVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [213.109.200.105] ([213.109.200.105]) by web-mail.web.de
 (3c-app-webde-bs04.server.lan [172.19.170.4]) (via HTTP); Fri, 2 Feb 2024
 15:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-78c294c6-cd07-4a27-befa-3f3fc9bd79da-1706885616508@3c-app-webde-bs04>
From: Dieter Mummenschanz <dmummenschanz@web.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Aw: Re: Re:  Re: Re: [PATCH 0/2] Power management fixes
Content-Type: text/plain; charset=UTF-8
Date: Fri, 2 Feb 2024 15:53:36 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <Zbt3qD8dMSqGYl8Q@x1-carbon>
References: <20240111115123.1258422-1-dlemoal@kernel.org>
 <DU0P251MB082515FC8FE77424231B475CF4682@DU0P251MB0825.EURP251.PROD.OUTLOOK.COM>
 <345be856-8959-4148-bcae-00b3fbcd0d08@kernel.org>
 <trinity-0be6e8a8-e6d3-4d60-be0d-59592a9edd65-1706010022623@3c-app-webde-bap10>
 <a72daedd-48c4-4eaf-9a77-a34679636a8c@kernel.org>
 <trinity-0df92d73-be55-433c-bdb2-4387f7ea590b-1706686178879@3c-app-webde-bap43>
 <3f7cef2a-5ba4-465b-a1f5-77e2bcc50ddb@kernel.org>
 <ZboztvrqKKdLQ1mt@x1-carbon>
 <trinity-61f604a0-1db3-4b6e-a316-fc7e609f38f4-1706771411065@3c-app-webde-bs18>
 <Zbt3qD8dMSqGYl8Q@x1-carbon>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:PfRjTO3TeB72M21aT3heVVZQ2hAOCtvKW4vcpXZD5DoM+gh11PunFN1toICyArUr/h+dW
 mclz7iW83zKI+OQyw8iASU6YnIAQ/qSPJpZyOKR0z0gya9EcDrfCUnKLgWr0eVRNXkhWysVda5KN
 m/QXTqN7zi52QVBbjMf+eENBMHBBMTJF5VI6vxapanShxgAjejq24um/OVfSQD6dfqSZj8071kE1
 evMiaNUBwU2alsVHD9Yn87hF/Lks+5ru9mJGXO3gGixY3T4bHB1WqYv21RT//EC7QmYRey8EmE3j
 lM=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j3LhS4zcH8k=;HAVYiHQ5MtbQ1euv3fHjgy1PPDU
 3UXoDqCkJ0EAJNN19yn5Kb8L185itBSEvC2OXMXlJKj50gsXA85Ta5YoYrj2VV0emDgitw15/
 oFwwQiqyLS0XIpCMBj/9RvwK82xKzqxQ+Mc0VOllX6RbXv0x+4MqC/qh+yxdxlJPpdDMkOZt0
 JP9XJCkEfp6rIDLtwaQK5CH5l4KBC6tv54tLW05V94W74NqTNUFh/iHdAehuf+qQu0Iv45Whq
 cFpipcma+YubXM9uvpYxqPPFyCaKwlD51+UIxP9fuO9pZd6Mgi5DtCwTxdxS5Zn2fdUj24CFj
 fFIJLG09AWhK5Xh6SWTOed0gWrYUW1tp7gZ0fjHQPVSy3shj6uZAICIk8heVLfm4tGp95yaGx
 X4ux3t4yJy2JeWGlnydS4TmJR2U49krqFfL8K6SNpFuemPmfxARvU6YrD7kN9ZxoFeF0RpoeJ
 m7C7MLIszoV2se/Vbq8y4ISIfdMwCOm76TexeOw2mZEm3nBRmniXdfPw4uB3Txg1r9EH9WtvD
 sOeuZT5xPPHGevEBUnD7E5OY6PjBAcI9U7yAJTtuXfgAiWaSsQqafsCXIrzrBhb4e517xCLxr
 OQrIF/XbWCdPn2sFbSCC43sm/Q1y02WrfhUyhIj1UMIwtC0vKcs2Me5+Aq+Vri03Ejg4H2yrG
 XVDB+rRPQH7H73nqACZXRTk4vBjCkD765d31ICKMrINRRCILjAuH3bxPdmOfFtA=


> Yes, this part of the problem can be avoided by adding an explicit entry
> that uses "board_ahci_low_power", as I explained in:
> https://lore.kernel.org/linux-ide/ZaATdGDOo5jiBqCR@x1-carbon/T/#u[https://lore.kernel.org/linux-> ide/ZaATdGDOo5jiBqCR@x1-carbon/T/#u]

> We seem to have a problem with Tiger Lake, but that problem seems to be
> related to Intel VMD.

> From looking at your logs, you don't seem to have Intel VMD, however
> I'm guessing that some other motherboards that uses Cannon Lake might
> have Intel VMD, so I guess the safest thing is to wait until that issue
> has been resolved before adding a "board_ahci_low_power" entry for
> Cannon Lake.

This mighht be kind of naive but what about adding an kernel option to force LPM even if the chipset/board is not oficially supported?

> I see now that Damien's revert (patch 2/2 in this series) is not a simple
> $ git revert fd3a6837d8e18cb7be80dcca1283276290336a7a
> it seems to have some other small changes in the same patch as well.

> Sorry for asking you to test something once more...
> But could you please test with:
> v6.6-rc2 + git revert fd3a6837d8e18cb7be80dcca1283276290336a7a

No problem. I've explicitly reverted with 6.8-rc2 and have the kernel running for 1 1/2 days now with 3 suspends and on all of them my system transitions to pc8 so I guess we're good but I'll keep on testing to be sure. Hope this helps.

Kind regards,
Dieter
