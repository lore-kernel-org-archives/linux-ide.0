Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D472EDD40
	for <linux-ide@vger.kernel.org>; Wed, 15 Apr 2026 12:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256848; cv=none; b=lrdxGanDKMg/dN6Hq1s9Ox4nOWOMzAYqEuGB3Gbk3ge4+GEZysiP8EPZiCWYr16eDtG1kY5RMn2LBHKbMBqkr5PIMZuVtqq4h8I2W+iyBWm9euKJHX/Bk4NlHT+w70nDER11n+wpoxuDF32iLj1oBnPB1DOejniQUX8QZKK+EEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256848; c=relaxed/simple;
	bh=NBG4RKH4gNPa2YV32Jm/mzUNFLZ8sVvigiYR5hRYsQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvJ5PAYQrTHtEajinGw+er1dy+i1Oohl5QVthzxjQU5pGuMtkHvwXGLspOzwn7RCaThEmGcramAo0D+pEQFyDTzBa4Nyg707LzHhdxPuzBfUB93Q7aIB2BPWDunRVG2vo5iYJ+BaTwTIEF6sFroIWYhIGYrH7Bscrp9csyOlZds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1eYpxZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1eYpxZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D021CC19424;
	Wed, 15 Apr 2026 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776256847;
	bh=NBG4RKH4gNPa2YV32Jm/mzUNFLZ8sVvigiYR5hRYsQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1eYpxZxEIM69A3By2dxbyYgKUwTzoyTB1l+pVgS34KxRJf7yO0DNYv4t3Xr1DKK5
	 pIlkgGhh1s0OLTKxtB0zGnNfVFs7esjmAKhunU/XfKwCaXXZ0d96Kzxj1+WSXso2y5
	 tbAqFXx6Xp9RLxb/irQBs8s26IVuKUKpYD5fJf2LT7Y++WB2rs+WIWi7heZC5sFiVx
	 C6WjnQ6UeCJtCiTSHjcyZtr/io5S+Hmk1wWW5M2AcA4XTnYWnvylcAHlKaJV2SgCiN
	 ntnVKNw7ckNVLd6TXD1gfA6oTr6ufYsgpVVrBwyl5fkYlsRj7UneMaVWv2dbKapTBV
	 r9nh6I4wCob8g==
Date: Wed, 15 Apr 2026 14:40:44 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: AlanCui4080 <me@alancui.cc>, linux-ide@vger.kernel.org
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
Message-ID: <ad-HTImFZxdtkD2J@ryzen>
References: <14015677.uLZWGnKmhe@alanarchdesktop>
 <6740c3b7-c63c-4181-b36e-962e07bb468f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6740c3b7-c63c-4181-b36e-962e07bb468f@kernel.org>

Hello Alan, Damien,

On Thu, Apr 09, 2026 at 02:01:03PM +0200, Damien Le Moal wrote:
> On 2026/04/09 12:21, AlanCui4080 wrote:

[...]

> And no, we should not introduce a quirk for this. Rather, we should do the same
> 3-steps timeout for revalidation after a resume from suspend in the same manner
> as a regular probe does. Or add a check/wait for "drive ready" when resuming,
> similar to the PUIS handling (power up in standby).

Just like regular ata_dev_read_id() (called during probe),
ata_dev_reread_id() (called during revalidate) already does increase the
timeout with each retry:

# echo +10 > /sys/class/rtc/rtc0/wakealarm
# echo mem > /sys/power/state

[   22.709542] PM: suspend entry (deep)
[   22.734353] Filesystems sync: 0.024 seconds
[   22.749431] Freezing user space processes
[   22.750703] Freezing user space processes completed (elapsed 0.000 seconds)
[   22.751533] OOM killer disabled.
[   22.751939] Freezing remaining freezable tasks
[   22.753553] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   22.763375] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   22.764396] ata1.00: Entering standby power mode
[   22.775472] PM: suspend devices took 0.021 seconds

...
...
...

[   28.826052] PM: suspend exit
[   29.063513] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

QEMU: cmd_identify: IDENTIFY count: 4, intentionally not sending completion

[   29.064800] ata2: SATA link down (SStatus 0 SControl 300)
[   29.071055] ata3: SATA link down (SStatus 0 SControl 300)
[   29.072053] ata6: SATA link down (SStatus 0 SControl 300)
[   29.073009] ata5: SATA link down (SStatus 0 SControl 300)
[   29.074038] ata4: SATA link down (SStatus 0 SControl 300)
[   34.168702] ata1.00: qc timeout after 5000 msecs (cmd 0xec)
[   34.169820] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[   34.170754] ata1.00: revalidation failed (errno=-5)
[   34.481679] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

QEMU: cmd_identify: IDENTIFY count: 5, intentionally not sending completion

[   44.920692] ata1.00: qc timeout after 10000 msecs (cmd 0xec)
[   44.921814] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[   44.922647] ata1.00: revalidation failed (errno=-5)
[   45.232872] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

QEMU: cmd_identify: IDENTIFY count: 6, intentionally not sending completion

[   75.640934] ata1.00: qc timeout after 30000 msecs (cmd 0xec)
[   75.642127] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x5)
[   75.643091] ata1.00: revalidation failed (errno=-5)
[   75.643893] ata1.00: disable device
[   75.950433] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)



Alan,
could you please provide a full dmesg (dmesg that has not been cut)
when reproducing your problem on kernel v7.0.

And please explain your problem as detailed as you can, including which
drive/port (ataX.YY) that you are having a problem with.

ZFS is not a filesystem in the kernel, so we don't really care about it.

Are you saying that you see something like:
[   75.643893] ata1.00: disable device

instead of something like:
[   75.068077] sd 0:0:0:0: [sda] Starting disk
[   75.069628] ata1.00: configured for UDMA/100



Note that if you specify an explicit probe timeout value, e.g.
libata.ata_probe_timeout=10

Then that timeout value will be used for each retry:
https://github.com/torvalds/linux/blob/v7.0/drivers/ata/libata-core.c#L1612-L1617

I.e. if you specify an explicit probe timeout value, you will not
automatically get a larger timeout timeout for each retry.


Kind regards,
Niklas
