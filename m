Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E23CEB8F;
	Tue, 23 Jun 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782204878; cv=none; b=gQ86nxt94AlT9iTAfLBkVvLL24I2LAWD+yxpWYbYfnUF9rFcPMV1WDmg6iNxJcG1HU/ZLPUkO4286IWoRSVNVlEEiwWU93XOxovh8pKzbdUhdHY17ez7uBnfJY8ffRR50T7PaJGj5edKqE0Ycwcg04zJCPEYO2rQxV+W0jlLeoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782204878; c=relaxed/simple;
	bh=97YPWMvBjcEwckI07SgJ2FnuAF53DCvK11xbM6RFPzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2LFokepMtfeBzHd+T/uGm+Nltt6PymAxlcl0+OsB21ZjCiDVBAFGHYAame0UYcfBPiMsgVPL/xEn7x0UtHtOY1VjlstTDXKjldtNvW8sL0BousW9Y+8V6rd8q/ahJMVlGJ3c9FkIp2iQFBtEHa3SJDAMoUOwkWiFhINfuOBIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML4ESpvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML4ESpvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32DA61F00A3D;
	Tue, 23 Jun 2026 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782204877;
	bh=+zhOM/uFzDq1SDMZdo7xftkoU4thrns0Js84NyeU5DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ML4ESpvCrka1ox/A7ZcVcSoWtLZnE3qUpJhEHVs2T+RcIJbBaPrS0OAvj4dyL92mH
	 KysiwuHGMeEcUt1wmhbLW5TyM3LNb1MgwafZt0GcG7KLvh8eMSRlWY/kJx7ogSPA2I
	 UP0Dgqb4rL7EsL5S8PsyOp9ocFDBoF4RM4uMmBfTPMJezpXG0g6V26q/yYE4/BglEM
	 m0n67K9ApaJ8w+GMzUfD4RmnAx+oXmdG/9+rVO5NdQqNA1mt1uQjM0II8z0s9S59Wd
	 YtU28Tbc7SzNEm22Opf090CJbboBonfT4xHd5w5SibDd0Kwvr1r7kdAODRWkBCL3CG
	 QivXGgoB7BbJA==
Date: Tue, 23 Jun 2026 10:54:33 +0200
From: Niklas Cassel <cassel@kernel.org>
To: hexlabsecurity@proton.me
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ata: libata-core: Reject an invalid concurrent
 positioning ranges count
Message-ID: <ajpJyZFqNIaFzXxe@ryzen>
References: <20260622-b4-disp-1b9ba697-v3-1-14ac65dd4413@proton.me>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-b4-disp-1b9ba697-v3-1-14ac65dd4413@proton.me>

On Mon, Jun 22, 2026 at 10:23:45PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> ata_dev_config_cpr() takes the number of range descriptors from buf[0]
> of the concurrent positioning ranges log (up to 255), which the device
> reports independently of the log size in the GPL directory. The count is
> then walked at a fixed 32-byte stride in two places with no bound: the
> log read here, and the INQUIRY VPD page B9h emitter, which writes one
> descriptor per range into the fixed 2048-byte ata_scsi_rbuf. A device
> reporting a count larger than its own log overflows the read buffer (up
> to 7704 bytes past a 512-byte slab), and a count above 62 overflows the
> response buffer on the emit side.
> 
> Bound the count once, on probe, against both the log the device returned
> and the number of descriptors the VPD B9h response buffer can hold
> (ATA_DEV_MAX_CPR, derived from the rbuf size). Reject an out-of-range
> count with a warning; this keeps the emitter in bounds with no separate
> change there.
> 
> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
> Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
> Fixes: c745dfc541e7 ("libata: fix reading concurrent positioning ranges log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
