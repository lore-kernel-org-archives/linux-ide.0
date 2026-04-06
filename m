Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8C14AD20;
	Mon,  6 Apr 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462497; cv=none; b=Vq6GVNRhuZpwQTUprGJVIxq30IHMu9C2SUwU6wRFdGV3x4GoMzfUfouJ33qWQhRZd9x+c8C9yxejTCyZcOTw4wQdMiXH3X2anvnpccWicnVP6sHyVdlZfXpnoTbeuppaghaJ39cPW4MqweGvq5cFsBC7guQ8ARekdnL83xGQEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462497; c=relaxed/simple;
	bh=0OpvVrdHXgcfvKpDrLBL4hcXDDTU9ay9fhxZhKXC9W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOENSvu2zcNn+/JYFE+SYKNaW5OCwmEPsbH/TVceUCwKf5bQqCFwyToFYo8GDiy2/ZwrQb3+Qa6TBeeOSk7RlODoGnGbJaQC+jUKy2QsdlcHW15kMXR85PUjc7H+XPMvyV+huIW+L/ITEml0IDd6hjMEDNqD87bfKZMi/VanEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgBQaaZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgBQaaZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FE3C4CEF7;
	Mon,  6 Apr 2026 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775462497;
	bh=0OpvVrdHXgcfvKpDrLBL4hcXDDTU9ay9fhxZhKXC9W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JgBQaaZH7RfD/+c2HRLU/aef0XysvYbXOy0/rXI3xZ0iHhnRsC/pyG9sneXTx6SLO
	 mL2vNyUox7UdtM9E8XYvh0m9cPKnQFyDoBzqz0WlvbUteUka+/VkE3JSLPrYjnILyH
	 TdkjmsAc6nYo4wZHQMOVQX//H/5hU+INLZJAWyIcG6TN76RYUMskGshYehhg+TDyFX
	 T9GYAzZMYXq76n49vEIJkTavqbrHmOyKJHI4iA7EcZCrg1UesEQaJ3GaaLPnPZbOqw
	 Rd9aRUNdiyO4jgxyNd93spnj8gs34kQAmM3E5yIF5EPXAhlvPJBq8DI/kB5PG/+enQ
	 Nz02sBRjXrnpQ==
Date: Mon, 6 Apr 2026 10:01:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Patrick Zima <pz.102010@gmail.com>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] ata: ahci: regression in f7870e8d345c disables DevSleep
 for ACS-5 drives on PSC=0/SSC=0/SDS=1 controllers
Message-ID: <adNoXbieRl5DGbgA@ryzen>
References: <1350BE53-13DB-4250-B323-7FBA335583BB@gmail.com>
 <73386b55-933f-42b3-b566-e9f4e3ea001d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73386b55-933f-42b3-b566-e9f4e3ea001d@kernel.org>

On Mon, Apr 06, 2026 at 09:30:34AM +0200, Damien Le Moal wrote:
> On 2026/04/05 21:01, Patrick Zima wrote:
> > Commit f7870e8d345c ("ata: ahci: Disable DIPM if host lacks support") introduced
> >   a regression: it disables DIPM — and thereby DevSleep — on drives behind AHCI
> >   controllers that have CAP.PSC=0 and CAP.SSC=0 but CAP2.SDS=1 (DevSleep capable).
> >   The guard condition is too broad; it treats the absence of Partial/Slumber state
> >   bits as grounds to disable DIPM, but DevSleep does not depend on Partial or
> >   Slumber being exposed to the OS — only on SDS=1 in CAP2.
> > 
> >   --- The logic flaw ---
> > 
> >   The new code (simplified):
> > 
> >     if (!(cap & HOST_CAP_PART) || !(cap & HOST_CAP_SSC))
> >         set ATA_FLAG_NO_DIPM on port
> >         → SETFEATURES DISABLE DIPM to all drives with word 78 bit 3 set
> > 
> >   On a controller with PSC=0, SSC=0 but SDS=1, this fires unconditionally,
> >   even though the controller is fully capable of negotiating DevSleep.
> >   The flag ATA_FLAG_NO_DIPM then also suppresses ALPM port behaviour at the
> >   kernel level — re-enabling DIPM at the drive level via SETFEATURES after the
> >   fact does not restore DevSleep.
> > 
> >   --- Suggested fix ---
> > 
> >   Gate the DIPM-disable path on the absence of DevSleep support:
> > 
> >     if (!(cap & HOST_CAP_PART) && !(cap & HOST_CAP_SSC)
> >   +     && !(cap2 & HOST_CAP2_SDS)
> >         && (ap->flags & ATA_FLAG_DIPM)) {
> > 
> >   If the controller can do DevSleep (SDS=1), there is no reason to disable
> >   DIPM — the power state sequence Active → DevSleep does not require Partial
> >   or Slumber to be present.
> 
> Instead of sending what looks like an AI generated report, what about you
> actually generate a proper patch from the suggested fix and test it ? And send
> said patch if the suggested fix works ?

From AHCI 1.3.1, 8.3.1.4 Software Requirements and Precedence:
"If CAP.SSC or CAP.PSC is cleared to ‘0’, software should disable
device-initiated power management by issuing the appropriate SET FEATURES
command to the device."


From AHCI 1.3.1, 8.5 Device Sleep (DEVSLP) Feature:
"Entry to the DevSleep interface state may be accomplished autonomously by
the HBA via the aggressive Device Sleep mechanism or through software
utilizing the PxCMD.ICC field (similar to how Partial and Slumber are
managed). Device Sleep is never initiated by the device."


Since DevSleep is never initiated by the device, doing a SET FEATURES to
disable device-initiated power management should be irrelavant to how
DevSleep works.


I'm not saying that there is not a problem with DevSleep, but the AI
generated analysis and suggested fix seems totally wrong.


Kind regards,
Niklas
