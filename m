Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8581732
	for <linux-ide@vger.kernel.org>; Fri,  2 Feb 2024 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903613; cv=none; b=pIpbaG8iqRzNm0S87XSdQrVLeMPamJQy17ddRfEcHpzuX2o17zPr0TrltnDzEiKd4hdUrOWCpYTrji7K8yqtn8x62fpEABOmc15JucsMr9sLRJhXMvoiXFFTGyB1ro1nKqhz1T4epO+N3YcjVY8ogqf8tSHmSPQ9VJtCKLhKRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903613; c=relaxed/simple;
	bh=H48ltEALErPjet86dTLPNRY+Y2BBnu2ds6SLX+cUiw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=egpLLx/JzhrloeexTqx2MFyg5FZrePWH7Mx7T4dGgh17Fj0HNONWo2TyAxqPfh39SIbJPjwK6L2acHtJkmOrYM4rucv9byAg/W8ZfEwOUW5xxgKuEJ8iFklh6oo2Wozl+QVTBUz2T1x300RE/S9rosak/UNnSTC9hFWLu35syQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=none smtp.mailfrom=vps.thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vps.thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id BFD8321EC0; Fri,  2 Feb 2024 14:53:30 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/3] libata: avoid waking disk for several commands
In-Reply-To: <58834dd7-0946-45ad-8ada-303c0d735164@kernel.org>
References: <87msthdo11.fsf@vps.thesusis.net>
 <20240107180258.360886-1-phill@thesusis.net>
 <20240107180258.360886-2-phill@thesusis.net>
 <f6110204-338d-42b5-8ec2-153dd862e799@kernel.org>
 <878r50uf97.fsf@vps.thesusis.net>
 <abd85855-0767-4e48-a8a7-8046cd339f9c@kernel.org>
 <87a5p5b426.fsf@vps.thesusis.net> <878r4l12c5.fsf@vps.thesusis.net>
 <d058a699-2929-4829-859b-8450f4bf497e@kernel.org>
 <875xziiuou.fsf@vps.thesusis.net>
 <7e324bce-9984-4291-8b5f-0907483e7bc1@kernel.org>
 <87sf2ct0ma.fsf@vps.thesusis.net>
 <58834dd7-0946-45ad-8ada-303c0d735164@kernel.org>
Date: Fri, 02 Feb 2024 14:53:30 -0500
Message-ID: <87fryafxs5.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Damien Le Moal <dlemoal@kernel.org> writes:

> Yes, but only for drives that report full identify data when PUIS is enabled.
> For drives that report incomplete identify data, we have no choice but to wake
> them up. And yes, we need integration with runtime pm to set the
> initial power

Why was that again?  I think you said something about needing to set the
speed correctly so you at least need to know if this drive requires a
lower speed than the other in the PATA master/slave pair?  Wouldn't that
only require the speed information, not all identify data?

> state of the drive to standby (instead of "on") for both the ata device and its
> scsi device.

You mean if the whole device hierarchy were changed so that instead of
the scsi_host being a child of the port with the links and devices
hanging off to the side, the scsi_host would be the child of the ata device?

> I need to check that. I think there may be a better/easier way to get the
> current power state of a drive. Will get back to you on that.

That would be good.  At one point that was the way I found, and also I
think it was in the SAT-3 spec that is how REQUEST SENSE should be
implemented for ATA disks.
