Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AC1BD504
	for <linux-ide@vger.kernel.org>; Fri, 24 Jan 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712986; cv=none; b=cgy+0BXQEoSiqRye8TcROkpHUekO3IjUtsrYswEIiEQsaPzaXmo3OdroKyUUP7Gc9CqTKvO2PgSqbET4YAJQtqPI4C8siWVbiT+n8Y069E3Zu3197DK1UaEAcXzVIIqtn8C/0+5Ow6A9KHQoumccgpK6PmHlfTx7vf0nNfTNXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712986; c=relaxed/simple;
	bh=KhU3k3OYzf+lliKCPYShWxmlYrOpRLqM9lJ4B99r1Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEe4B1o1qeYVoL+czYj1nLXp5t/i7X9TKLJ1aByRRWXT9QTgD4wgEkE9+S4MJyxVNRp7x/oKjoZrEB/jSYI14+b3CklE/nj9IJyyH0Advht5Vz2zjRt3ihN8au+1u29eRqEymd9G5Oj5IB4sLqlDfJS6sAoS3lqEtgYX6XNFr7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2loNj09; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2loNj09"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35116C4CED2;
	Fri, 24 Jan 2025 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737712985;
	bh=KhU3k3OYzf+lliKCPYShWxmlYrOpRLqM9lJ4B99r1Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2loNj09SfsD04QSNxbHQsvFkSmICxc4Liw3o/CJCFgCnnA6MkA4Dt1g63mL/HPvH
	 oKAf2YoExBnytVyRniinaQ6vjCaFwLpb2LXeoOva3+6jtwVxVK/jg/q7Y7bkM65rEX
	 TZ1LOwo0Pm4MAUdZRDO97oGBh/bAoqmituMQKyuSgPSCTdf7REpQaRYlggZrce5xUu
	 tw0RkpcHsxGt4/tVlBoVUWyN8BVQdgwBh/ruvcfwBrXYp8ayr3qh5QIwdc2MJI2J6i
	 quo+bO2MAU4fHD4OCE4wTEi0FE/jEGLu1rXmypEEnY3xSkpAjLD1STaa+imEBtKI9W
	 BFetUMc3z1OjA==
Date: Fri, 24 Jan 2025 11:03:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z5NlVjIMp6Wo8dQd@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
 <Z36GMwr49ihd2nAG@ryzen>
 <e1985151-c206-4be1-91c1-92eac16f6236@philpem.me.uk>
 <Z3-_dt0m_2UrtKon@ryzen>
 <e1b79ece-b4b2-42e5-b259-290820324b5e@philpem.me.uk>
 <Z4pdD1Z2mJnF7N3O@ryzen>
 <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bb1510c-c42f-468b-a8cb-70603bee846b@philpem.me.uk>

Hello Philip,

On Thu, Jan 23, 2025 at 04:19:44PM +0000, Philip Pemberton wrote:
> Hi Niklas,
> 
> I've reproduced the issue on an Intel based board (an Asus ROG Rampage
> Formula with a Q
> 
> I tested with the following Debian kernels --
> 
> vmlinuz-6.10.11+bpo-686-pae   (bookworm)
> vmlinuz-6.1.0-30-686-pae      (bookworm)
> vmlinuz-5.10.0-0.deb10.30-686 (buster)
> vmlinuz-4.19.0-27-686-pae     (buster)
> 
> This is with no libata related options on the kernel command line:
> 
> [    0.062948] Kernel command line:
> BOOT_IMAGE=boot/vmlinuz-4.19.0-27-686-pae root=/dev/nfs
> nfsroot=10.0.0.32:/mnt/zfs/debian-nfs-boot,rw ip=dhcp
> initrd=boot/initrd.img-4.19.0-27-686-pae
> 
> Here is the output from the 4.19 kernel when it tries to initialise the Zip
> drive:
> 
> > [    2.549684] scsi host0: ahci
> > [    2.550052] scsi host1: ahci
> > [    2.550260] scsi host2: ahci
> > [    2.550474] scsi host3: ahci
> > [    2.550692] scsi host4: ahci
> > [    2.550905] scsi host5: ahci
> > [    2.551061] ata1: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe900 irq 26
> > [    2.551133] ata2: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffe980 irq 26
> > [    2.551204] ata3: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea00 irq 26
> > [    2.551275] ata4: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffea80 irq 26
> > [    2.551346] ata5: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb00 irq 26
> > [    2.551417] ata6: SATA max UDMA/133 abar m2048@0xf9ffe800 port 0xf9ffeb80 irq 26
> > [    2.863069] ata1: SATA link down (SStatus 0 SControl 300)
> > [    3.041029] firewire_core 0000:05:03.0: created device fw0: GUID 001e8c0000b2df93, S400
> > [    3.175068] ata2: SATA link down (SStatus 0 SControl 300)
> > [    3.648939] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> > [    3.651027] ata3.00: ATA-8: WDC WD1001FALS-00E3A0, 05.01D05, max UDMA/133
> > [    3.651084] ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> > [    3.653455] ata3.00: configured for UDMA/133
> > [    3.653693] scsi 2:0:0:0: Direct-Access     ATA      WDC WD1001FALS-0 1D05 PQ: 0 ANSI: 5
> > [    4.128939] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    4.135599] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr
> > [    4.135671] ata4.00: applying bridge limits
> > [    4.142464] ata4.00: configured for PIO3
> > [    9.216983] ata4.00: qc timeout (cmd 0xa0)
> > [    9.217040] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> > [    9.692938] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [    9.706493] ata4.00: configured for PIO3
> > [   14.848995] ata4.00: qc timeout (cmd 0xa0)
> > [   14.849051] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> > [   14.849107] ata4.00: limiting speed to PIO2
> > [   15.324938] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > [   15.338347] ata4.00: configured for PIO2
> > [   20.480928] ata4.00: qc timeout (cmd 0xa0)
> > [   20.480984] ata4.00: failed to clear UNIT ATTENTION (err_mask=0x5)
> > [   20.481039] ata4.00: disabled
> > [   20.956939] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

I little bit weird that we see link up after it has been disabled.

I assume that the device is unusable at this point?


> 
> The messages are the same (albeit with different timings) on every kernel up
> to and including 6.10.11+bpo-686-pae.
> 
> I can try and go back earlier if it would help.
> 
> If it helps any (see my previous message for more), the ata_piix driver on
> an Intel ICH5 Northbridge + 82801EB Southbridge (Aopen EZ65 board) seems to
> work fine on the exact same kernels (literally the same binaries).
> 
> 32/64 bit seems not to be a contributing factor as the AMD B550 machine is
> fully 64-bit (userspace and kernel) and boots via UEFI.

It seems to me that you have found out that your "SATA to PATA adapter + Zip
drive" works fine on recent kernels (v6.10) with the ata_piix driver, but not
with the ahci driver on that same kernel version.

This does suggest to me that there is some bug in the ATAPI specific code in
the ahci driver.

This makes me a little bit surprised, since ahci is usually the most well
tested driver. I'm quite sure that people have CD/DVD ATAPI devices working
with the ahci drivers, so in order to get to the root of this issue, you would
probably need to debug the ahci driver.

I wonder which bug there could be in the ahci driver that allows it to work
with a lot of ATAPI devices, but not your "SATA to PATA adapter + Zip drive".

Did you try using the same mode as the ata_piix machine? e.g. PIO0/PIO3/DMA.

You didn't paste the dmesg from the ata_piix driver.
Did it have ", DMADIR" as part of the string that prints the device?
i.e.
"[    4.135599] ata4.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr"



Kind regards,
Niklas
