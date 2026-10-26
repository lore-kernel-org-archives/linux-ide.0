Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032880;
	b=jcpDJgMzBVn3sf8cHjXKCNfiwMLi+qoDgkXHSFoTlX0Owb1UOBc31OjpnI4vH1pUh5LB
	 9DKWI/SDVH4ol9j9FdvJ8e2RMvzlwjER/p29/G4esI7JZatN3adeOPmNB9+Yj7Wd8dKLD
	 VIc8LG0Zbf4v0OqrBgoirhMw2dwumwup3IbAhjwF76M0jfRA4yQYUI/86+0XMUkeg+S9w
	 1ba3SSU+RhCH4m4vp057tYt0YhrANpJRiXULNkZ3tU5s1gjcbihczFC5ux1uT7b0hA8SV
	 uaIYxB0yq7BGD2Hfxjjl8UKYQ9b1OW10ud1SBYgQklaYziDMoc1Q2du+r3P11gXPFVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032880;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=KtWeFxYTWeXBUKgoU1fI9FqawycrFC+jBgurVjGO+PQ=;
	b=qFgZscgG2FXKfzLKgLYS+/txQmqVBi8RI2Ov9lNrz/wcixHRhputABsdWrDKjhGDUAER
	 9i/F2vO4bSkxyTZKoS7ie9uCgeN4jj0I3vkbghWV5E7QpTecFxLhyW9QIZFqFWg+bRp4Z
	 PGpC1TAT6+2vrntAneVLFcDUdY/HbNNNeQ8Py7RcR1r5eeK4BOdJs99V/pv1CsG54wNOz
	 L/Flu/hcquKn++6AmdZ6nVUOh9EpvAJyjYAg7eLEPk9v2HzPi2ux268luR8IIN3vxjf1j
	 0j+/CgJryKr98si1WSp/0MTQiJmsXPknky8SI+3xhT5tOeu4fxzqkCSGgtA7VVHOr6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYn8iT7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A1606A31F
	for <linux-ide@vger.kernel.org>; Mon, 26 Oct 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fYn8iT7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5621F031E3;
	Mon, 26 Oct 2026 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032879;
	bh=KtWeFxYTWeXBUKgoU1fI9FqawycrFC+jBgurVjGO+PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYn8iT7ATtxEBegCbZpfBIjI7lA2cdHByVJXKVO1AjkWzR8jYOb+YxThxCweG1PZl
	 XqqRR9sdRWyRe1vYokN52tpiwbJN2OZLwpMfjYxs0AIQbjvGMdsqpa0bmY9BrvHoeI
	 /cytDq9G7NfbGtDIo4qxjyU+n3LP7yhPYcuGRa6xfodyGaeWThp9gb0Kae13KFxRCK
	 iVIFx8RyXX8Fm51CB/pgISR4oE3oPCXylduvIJPBWRpi0RLClDKq/yT51QYDARJWux
	 asawx59TCgbjnIHizBIFxWmb4MW7+ZPLeMJU8xWrYLjx6knSPdJH4PXMXa86G5kvTs
	 nwDslhjrRxxGg==
Date: Mon, 26 Oct 2026 17:41:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Thierry Vignaud <tvignaud@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-core: Add NOLPM quirk for PNY 1TB SATA SSD
 916a
Message-ID: <at-CrMH85_pI7QYn@ryzen>
References: <CAHSMvrH4YRmNaw3+FnKv9-Dwf9PS6R_kNMPGEoOe2=pKwewgBA@mail.gmail.com>
 <CAHSMvrFn+gvgsfM9WPJgPCWFUy2cjR+A7-fqFtDJc=JOD9L7Jg@mail.gmail.com>
 <at9wk18uhg-H18ge@ryzen>
 <CAHSMvrHur59qCpyVk_qd_epVGrntWMeKhogKtutTpJaA_V3VLg@mail.gmail.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSMvrHur59qCpyVk_qd_epVGrntWMeKhogKtutTpJaA_V3VLg@mail.gmail.com>

Hello Thierry,

On Mon, Oct 26, 2026 at 04:55:07PM +0100, Thierry Vignaud wrote:
> That's strange because I did use "git format-patch -1"
> I reran it, it's exactly the same file.
> However I generated on top of Linus' tree.
> Here's the same applied on top of "for-7.4"

I don't think the problem is how you generated the patch (git format-patch).
It seems to be how you sent it out.
(It appears that you did not use git send-email.)

As you can see, the mailing list rejected your email:
https://lore.kernel.org/linux-ide/at9wk18uhg-H18ge@ryzen/T/#u

Most likely because:
Content-Type: multipart/mixed;

instead of:
Content-Type: text/plain;

git send-email should send it out as plain-text.

I can see that you are sending using gmail, see:
https://git-scm.com/docs/git-send-email#_use_gmail_as_the_smtp_server

For how to configure git send-email with gmail.


> 
> This patch survived heavy I/O such as compiling a kernel multiple times.
> However I hit the NCQ issue after trying suspending (which I remember was
> an issue too).
> On resume, I hit
> I've attached dmesg to https://bugzilla.kernel.org/show_bug.cgi?id=222187
> See https://bugzilla.kernel.org/attachment.cgi?id=311297
> 
> Note the following (one hour before suspending?):
> [12014.334779] sd 0:0:0:0: [sda] tag#25 timing out command, waited 7s
> [12612.911419] sd 0:0:0:0: [sda] tag#16 timing out command, waited 7s
> 
> Then when suspending/resuming:
> 
> [16199.520287] PM: suspend entry (deep)
> [16199.525373] Filesystems sync: 0.005 seconds
> [16199.532331] Freezing user space processes
> [16199.533685] Freezing user space processes completed (elapsed 0.001
> seconds)
> [16199.533689] OOM killer disabled.
> [16199.533690] Freezing remaining freezable tasks
> [16199.534837] Freezing remaining freezable tasks completed (elapsed 0.001
> seconds)
> [16199.534881] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [16199.553767] e1000e: EEE TX LPI TIMER: 00000011
> [16199.578187] sd 3:0:0:0: [sdb] Synchronizing SCSI cache
> [16199.578249] serial 00:02: disabled
> [16199.578307] sd 4:0:0:0: [sdc] Synchronizing SCSI cache
> [16199.578315] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [16199.579852] ata1.00: Entering standby power mode
> …
> Resuming:
> [16200.017987] PM: suspend exit
> [16200.101972] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [16200.101995] ata6: SATA link down (SStatus 4 SControl 300)
> [16200.102060] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [16200.102076] ata3: SATA link down (SStatus 4 SControl 300)
> [16200.102590] sd 0:0:0:0: [sda] Starting disk
> [16200.103016] ata1.00: configured for UDMA/133
> [16200.118929] ata2.00: configured for UDMA/100
> [16200.240742] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
> bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [16203.543281] e1000e 0000:00:1f.6 eno2: NIC Link is Up 1000 Mbps Full
> Duplex, Flow Control: Rx/Tx
> [16205.102517] ata4: link is slow to respond, please be patient (ready=0)
> [16205.103508] ata5: link is slow to respond, please be patient (ready=0)
> [16215.160283] ata5: link is slow to respond, please be patient (ready=0)
> [16215.160305] ata4: link is slow to respond, please be patient (ready=0)
> [16217.967230] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [16218.011741] sd 4:0:0:0: [sdc] Starting disk
> [16218.045035] ata5.00: configured for UDMA/133
> [16218.274151] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [16218.310512] sd 3:0:0:0: [sdb] Starting disk
> [16218.343817] ata4.00: configured for UDMA/133
> [16306.847985] ata1.00: exception Emask 0x0 SAct 0x7fc00000 SErr 0x0 action
> 0x6 frozen
> [16306.848009] ata1.00: failed command: WRITE FPDMA QUEUED
> [16306.848015] ata1.00: cmd 61/40:b0:18:70:44/05:00:39:00:00/40 tag 22 ncq
> dma 688128 out
>                         res 40/00:01:00:00:00/00:00:00:00:00/40 Emask 0x4
> (timeout)
> [16306.848034] ata1.00: status: { DRDY }
> 
> ata1 being the SSD:
> [    0.654757] ata1.00: ATA-11: PNY 1TB SATA SSD, H220916a, max UDMA/133
> 
> Any idea what I could try  (besides disabling suspending)?

I'm guessing it is a drive firmware bug.

Have you checked if there is any more recent firmware version for your SSD?


Kind regards,
Niklas
