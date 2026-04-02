Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780A38B138
	for <linux-ide@vger.kernel.org>; Thu,  2 Apr 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121776; cv=none; b=KUqma9i0W1zwACgxzl2NRAWXfZnoc47ZXuQ51KlZDvqCEy92E718auQZQkk7oBG4Bcud7ef+ndkVtJqPux3JpEkI8rsOdTRAXwaDfdBwFz/ZsI8f3p4n5aTSfMiCXXwhqU/CDES8GrMTnwl4ECaMRmJ4qekr/t0wKtLPtvxroLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121776; c=relaxed/simple;
	bh=9eENu7p8MgZqAM8NG2I5UDIU5KSSsabkBme1PE0RrJU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:In-Reply-To:
	 From:Content-Type; b=EajO0sZAMMinRcJvo7rzakIpjAwA+E98itRj1UjtpgteEZez6va5+ldWQRfk8f3V6Fam7qlvnqK3S9G5J1MkQQzw0P+XTGYzY9sl6sCQt2AksdJYBWiiBOqIzuBWfn/Hg3I78k/lgqFNtFq0fJNN48muOmaj3yLF6o6hMcpEBSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=eR0tSPoZ; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="eR0tSPoZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1775121772; bh=9eENu7p8MgZqAM8NG2I5UDIU5KSSsabkBme1PE0RrJU=;
	h=To:Cc:References:Subject:In-Reply-To:From;
	b=eR0tSPoZjlKd+mDFJ6GrrfjJ1Ji5ekdJcV2QFz7/x8nZM1/TtUHFdOGcvpRpX77CH
	 mF6hJTZ1GH3c4m4BlzLK8gDrxRJ/+dKEwccFwSuuB/6xI58HWj+cm36JkA+NPOUKV4
	 wrD/ANOJs86JfrYNfzLV34VJwfRgpDEsIycK/lBfSfKYF2B/0q4pfOR70tDUm2x2Hw
	 wfQ/FWsBiL6SbVSyUMBdsPgmtm5RIrO8WMTJ+ZpoxI+iAw4MZO2fLBqAhz8idEUAQk
	 xfJ2WkHQlikscpp/RA0ilwb30rC+TXC8/oyQED+eG+enO7wpSmw9pZPll95MBC1WxW
	 rLhxhraV7OY2A==
Message-ID: <ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly>
Date: Thu, 2 Apr 2026 02:22:49 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: dlemoal@kernel.org
Cc: cassel@kernel.org, linux-ide@vger.kernel.org
References: <20260220221439.533771-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2 0/2] ATA port deferred qc fixes
Content-Language: en-US
In-Reply-To: <20260220221439.533771-1-dlemoal@kernel.org>
From: Tommy Kelly <linux@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/26 14:14, Damien Le Moal wrote:
> The first patch addresses a use-after-free issue when a deferred qc
> times out. The second patch avoids a call to a potentially sleeping
> function while a port spinlock is held.
> 
> Changes from v1:
>  - Corrected typo in patch 1 message, improved comment in code and added
>    a WARN_ON_ONCE() call to verify that a timed out qc is not active.
>  - Fixed patch 2 to not call ata_scsi_requeue_deferred_qc() without the
>    port lock held. This call is in fact removed: it is not needed as
>    ata_scsi_requeue_deferred_qc() is called in EH, which is always run
>    when removing a port.
> 
> Damien Le Moal (2):
>   ata: libata-eh: correctly handle deferred qc timeouts
>   ata: libata-core: fix cancellation of a port deferred qc work
> 
>  drivers/ata/libata-core.c |  8 +++-----
>  drivers/ata/libata-eh.c   | 22 +++++++++++++++++++---
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 


Hello, this is my first message on the LKML so please forgive me for
likely not following etiquette.

I have what might be a regression from somewhere in the recent series of
NCQ / QC patches.

I have a peculiar setup that might reveal the source of the bug. I'm
using a SATA Port Multiplier (PMP), powered by JMB575, which expands 1
SATA port to 5 drives.
The device/driver/subsystem tree looks like rk3568-dwc-ahci -> scsi -> sda.
The platform does not (yet) support FIS-Based Switching (FBS), so it is
using Command-Based Switching (CBS). FBS support may land in Linux 7.1.

> kernel: ahci-dwc fc800000.sata: flags: ncq sntf pm led clo only pmp fbs pio slum part ccc apst
> kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS

When switching from kernel 6.18.13 to 6.19.7, drive access became
extremely slow, causing lock timeouts at the filesystem level. I solved
the problem by changing /sys/block/sd*/device/queue_depth from 32 to 1.

I also looked through the recent LPM patches, but the drives'
performance didn't improve after changing LPM settings for the scsi host
in sysfs.

Let me know if I need to provide more details or logs. I can see
COMRESET a lot in each device's SMART logs but they aren't timestamped
so I haven't proved that they are recent. Perhaps the slow drive
switching is causing command starvation.


Thank you,
Tommy
