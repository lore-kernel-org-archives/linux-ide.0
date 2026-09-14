Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022733065D
	for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789402723; cv=none; b=Ic0QUwNAaipliIlsseqv25ILwu5YyVxWfQiERRF1in7FJZA89+4u3cqqSlgVdiczSFn1D6qUlWUa+SKnSJoHHjlmQS34yOJQnztQM7Rsl1MJ8u4ZWmr5k5TC2GLFn6aS31K1jrX7RjRImSq0ExjTDPvCxKqHGFxfLjGYLLniU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789402723; c=relaxed/simple;
	bh=eHNWRQ6svDTop1BTauX2207+aIgriqU/sX9gr3Z9X/E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LFKLpVfQUPHsYHtaauybBMenBZ7vB/VVK6QHp/qQG+txf/ShnRQeMqSWga9JSyW8b9wU3/sqUgHcpYOccOCRTnmB43OBnvxnuUre07jF9lZvRjh8+UKM6GPTSq3bvwinSlLAY9s7LVSQso+F+zMd4Kt+MStilLnDc8UJdSUbQd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq1cySug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq1cySug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274071F000FF;
	Mon, 14 Sep 2026 16:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789402721;
	bh=SE+8Jej7Oq6lvORv2EPNeTRwao4RbqZ2kQB7sF2CmMo=;
	h=Date:From:To:Cc:Subject;
	b=lq1cySug3PXG14UrJP8Qf6eau4YixyR88kMiumskbz/WDVgY4wb63svliEcWRD+2s
	 PnDz8+a4OMiSGOE2Jn9a6cCisF5LVFte07oOBHJ3jeK9gRN4wZMw3VLGLufjK0awnZ
	 fXT75tcfQzGbU+Gs5dNlV6vldT6a0yV0NRAmDMjCKUGq5RuBT8rR9x1oYIoABOmEuZ
	 dojVLrltajFXd3adQddFS94+wvFavvHTBdWwyfiaJBbRnaei/4m3F6P448BcsdPjG5
	 pUNo9Nuy+1Stfr1xvlRY2F6jWIMOFO+1Gc8jMzUBMao3mEOmIvS9tAqHODgyy23OlP
	 xk0KOXKZmVBbA==
Date: Mon, 14 Sep 2026 18:18:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: grandmastertriplej@gmail.com, Damien Le Moal <dlemoal@kernel.org>,
	linux-ide@vger.kernel.org
Subject: AMD AHCI + Samsung 870 QVO STANDBY IMMEDIATE time out
Message-ID: <aqgeXSdsH_QVgKqg@ryzen>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Mario,


Perhaps you, or someone at AMD could help us with this:
https://bugzilla.kernel.org/show_bug.cgi?id=221986


Is seems that a user is having issues with:

12:00.0 SATA controller [0106]: Advanced Micro Devices, Inc.
	[AMD] 600 Series Chipset SATA Controller [1022:43f6] (rev 01)

together with:

Samsung SSD 870 QVO 8TB


when being issued command STANDBY IMMEDIATE (E0h) during system suspend.

The command never receives a completion.


It seems that this is only a problem when "med_power_with_dipm" is enabled.

Apparently, when using "max_performance" the drives do complete the
STANDBY IMMEDIATE (E0h) command successfully.

From looking at the AHCI specification, the HBA should automatically wake
the drive when a new command is issued via PxCI.



The user did point out that these Samsung drives are quirked with:
ATA_QUIRK_NO_LPM_ON_ATI.

See commit:
f2aac4c73c99 ("ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain
Samsung SSDs").

From earlier reports, these Samsung drives appear to handle LPM perfectly
fine on Intel-based AHCI controllers.


This LPM quirk is only for the old ATI AHCI controllers, because it was
assumed that, just like the ATI specific quirk that disables NCQ:
ATA_QUIRK_NO_NCQ_ON_ATI, that the AMD AHCI controllers were unaffected,
see e.g. 7a8526a5cd51 ("libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung
860 and 870 SSD."):

    After verifying the chipset from the user reports, the issue appears
    on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
    recent AMD SATA adapters.


I guess it is possible that while the AMD AHCI controllers have fixed the
NCQ problem with Samsung SSDs (that was troubling ATI AHCI), perhaps the
AMD AHCI controllers still have the LPM issues with Samsung SSDS that was
troubling ATI AHCI controllers.


It this anything anyone at AMD is aware of?

From the users report, he is using the latest available firmware from Samsung.

Considering that Samsung SSD work fine with LPM on Intel, I'm considering
the users suggestion, to simply rename the ATA_QUIRK_NO_LPM_ON_ATI to
ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD and modify the quirk to extend to AMD AHCI
controllers as well.


Kind regards,
Niklas
