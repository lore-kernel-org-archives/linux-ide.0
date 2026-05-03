Received: from mail.tkel.ly (mail.tkel.ly [149.248.17.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C71140DFB7
	for <linux-ide@vger.kernel.org>; Sun,  3 May 2026 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.248.17.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770382; cv=none; b=Iz9B+MV1vHA7MhXlxSXb3gOz/+DKUdeOmkmte0nIa4aS1n5r1z10kBygpZhzZy8gYRO4ReK7Mn5FD/BaaRY0lTMSEJa1PdJXeU+FkQmAEgRD0AOFp62Bmwz+bVdhF5cgVcLCTR7rD5vH3v+YplXBhsxivDMeRykrRL3UG7WVnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770382; c=relaxed/simple;
	bh=g/HiGntLKwRrijwxSpmz1z1bzqJb2tvCxVOM5L7pAOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:In-Reply-To:
	 From:Content-Type; b=SkzWi0/mkSBWjmH8peoxfWu9J65RBdpgSutB4RPN0SH+vkxpo7n4vkP6dI3rFgRWlwK269S02pHFbrG/Le9XnEVHSQc76+56R2vkZ2LqkV7Qpn49uDUw+HGxUH98qkdC52GWjbT/5AH/pcULAfFZDZJezrh5gBwDNX9v0nz+9Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly; spf=pass smtp.mailfrom=tkel.ly; dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b=Z+yeoLiW; arc=none smtp.client-ip=149.248.17.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkel.ly
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkel.ly
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkel.ly header.i=@tkel.ly header.b="Z+yeoLiW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkel.ly; s=mail;
	t=1777769955; bh=g/HiGntLKwRrijwxSpmz1z1bzqJb2tvCxVOM5L7pAOI=;
	h=Subject:To:Cc:References:In-Reply-To:From;
	b=Z+yeoLiWt5znu/FuoW1rud/UnkqfXMRzDCqxPQbeLBnWXBYZTr+yaWDmPs1UiR4tQ
	 7Ft5PtLx559bx+AyLgctsU1a7DrurcPmAKNva1ssqrMRMXMKX8LATYsZG52Ig1kqEq
	 7cFGcRLipRogqWtXBGbmIDBNAcViidyemc0mI0Rw5/l/4SA7xsNKPgXgip5hrdOE9P
	 8aO0UoceqxyGLcg7D0FJclK/RUjAfr7m0SmSJUTbQ0BSSQuB2fZxSo2fW5WY+dGPIo
	 sO8FNFg0dScEOSM9mzsgh3OKpPlVbolg/zGYr8+pt5XO/NPNZIyqotQGz+a70KbbRh
	 QET9Z1HIvXrjw==
Message-ID: <88ea5d12-520b-4022-9faa-3ea879a8bfb6@tkel.ly>
Date: Sat, 2 May 2026 17:59:12 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
 John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260501125410.1204490-5-cassel@kernel.org>
Content-Language: en-US
In-Reply-To: <20260501125410.1204490-5-cassel@kernel.org>
From: Tommy Kelly <linux@tkel.ly>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 05:54, Niklas Cassel wrote:
> Hello all,
> 
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/

> 
> Tommy, it would be nice if you could apply this series and see if it solves
> your problem. Right now the series is compile tested only.
> 
> 
> Niklas Cassel (3):
>   ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
>   ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>   ata: libata-scsi: do not needlessly defer commands when using PMP with
>     FBS
> 
>  drivers/ata/libata-core.c | 16 +++++++---
>  drivers/ata/libata-eh.c   |  8 ++---
>  drivers/ata/libata-pmp.c  | 13 +++++---
>  drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++-----------------
>  include/linux/libata.h    |  6 ++--
>  5 files changed, 64 insertions(+), 45 deletions(-)
> 

Hi Niklas,

Yes, this patch series fixed the regression for me with a CBS Port Multiplier.

Here are the commits I tested with:

> (HEAD -> fedora-7.0-libata) ata: libata-scsi: do not needlessly defer commands when using PMP with FBS
> ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
> ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
> ata: ahci: fail probe if BAR too small for claimed ports
> ata: libahci: use ahci_nr_ports() helper
> ata: pata_parport: switch to dynamic root device
> Merge remote-tracking branch 'libata/for-7.1' into fedora-7.0-libata
> (tag: kernel-7.0.3-0, kernel-ark/fedora-7.0, fedora-7.0) [redhat] kernel-7.0.3-0
> Merge Linux v7.0.3
> (tag: v7.0.3, kernel-ark/linux-7.0.y, linux-7.0.y) Linux 7.0.3

And here's some logs showing ata_id (non-NCQ) resolving immediately.
After, I'm able to boot and mount and use the filesystem no problem.
No errors and no timeouts.

> Mar 12 17:00:10 localhost kernel: ahci-dwc fc800000.sata: port 0 is not capable of FBS
> May 02 17:12:39 (udev-worker)[874]: sdd: Starting 'ata_id --export /dev/sdd'
> May 02 17:12:39 (udev-worker)[874]: sdd: 'ata_id --export /dev/sdd'(out) 'ID_ATA=1'
> May 02 17:12:39 (udev-worker)[874]: sdd: Process 'ata_id --export /dev/sdd' succeeded.

> $ cat /sys/block/sd*/device/queue_depth
> 32
> 32
> 32
> 32
> 32

I will also apply the FBS devicetree change (5918bf2) and test with that too.

Thank you for your work on this!

- Tommy

