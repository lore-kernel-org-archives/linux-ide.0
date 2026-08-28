Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940391E515
	for <linux-ide@vger.kernel.org>; Fri, 28 Aug 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787901013; cv=none; b=MZI/LMJu/5DGbuAyuHC6RrZHjHTQPz+Gm6qXgnDA1pRTWTJQxgiW/DTP3xkCj2BfyOPX4dnJ43ribG7vQOAhJRFOZE4yKhdRvvQbaA4bTdqZ417YbqLZnBZjkcemMnAGl2NVbcLIXZs+e8YQzERpU3hnKqkJPta2ILVvycjP9UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787901013; c=relaxed/simple;
	bh=8cdfRe1Er+WCohwID1nWeX4xeZ87bkCcb6SmqmTMEQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OugSzodrQIqc2xqWevGCcnJLMLJoYC6YAXkvm4lZIH+E5ZZk6nEUcFw2aef9GgM8fv9dDfouXBu5wAdI8PduF562OmBjntP0zTp0rpBLE8Gg4B1ObI2jZvZ0HONCet7ImjYoOK/hlEW/CTg0M7Gg33orXia+HI006DylL8JI/Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+IP3LGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+IP3LGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DE11F000E9;
	Fri, 28 Aug 2026 07:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787901010;
	bh=XLcW3NH96CZvcxGmlohiT7hW4r0kS0CRBA2fDUS3S5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I+IP3LGzpRo3EAQyoUNdPKeUI+avq2Xls4P4relmvaT5Usqk6HEKyOE4Md9mSxI43
	 vRIRyfA8zbLnjDJCpi1jxPaBL4UlwfYlercUF3efgxE4O6m7zVgZYwagSDeIxfkssu
	 9u2G0a7RXuwDZ55IUVBbMBmZrdcn5ka3UtB0HOE5FioSnyDW6UbzbeMZJKk+5oN0Nl
	 P0D6hlAxk5DlsOJMrAtG91y4VIFC0B4+Gr+QhOwzFWAGTYvH5s86rtqPR5dHfkBWsN
	 Xbl2Iu5/pwLlLPhn1CbmK/gbxig4kAah1ojrFnSU9RGn412WiEgTIAyk4vTQIyq2TQ
	 zFfW8v9NxwTyw==
Message-ID: <633fedbe-49dd-425e-b941-0c26dc33283b@kernel.org>
Date: Fri, 28 Aug 2026 16:10:08 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: ahci: work around lost interrupts on Marvell
 88SE61xx
To: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>, linux-ide@vger.kernel.org
Cc: Pali Rohar <pali@kernel.org>, risc4all@yahoo.com
References: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3d72cab2-d491-4e86-8e69-a735242ec862@noerenberg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 16:05, Hajo Noerenberg wrote:
> 
> ahci_single_level_irq_intr() services the ports first and clears the
> global HOST_IRQ_STAT afterwards, as recommended by AHCI 1.1 section
> 10.6.2.  The Marvell 88SE6111/6121/6145 family stops reporting interrupts
> for a port when HOST_IRQ_STAT is cleared while PxIS still holds bits:
> PxIS keeps its content, HOST_IRQ_STAT reads back as 0, the port is never
> looked at again, and the command in flight only ends in a timeout.
> 
> Measured on a Seagate Blackarmor NAS440 (Marvell 88F6281 Kirkwood,
> 88SE6121 rev B2 behind PCIe) by polling the AHCI registers from userspace
> while an IDENTIFY was outstanding:
> 
>   t=303.046  irqs 127  PxIS 0x00000000  PxCI 0x00000001
>              IDENTIFY issued
>   t=303.057  irqs 128  PxIS 0x00000020  PxCI 0x00000000
>              CI cleared, DPS set, one interrupt taken
>              ... PxIS stays 0x00000020, HOST_IRQ_STAT stays 0 ...
>   t~308.05   qc timeout after 5000 msecs
> 
> The command had completed - PxCI was clear and PxIS had DPS set - so
> ahci_qc_complete() would have completed it.  It never got the chance
> because the handler read HOST_IRQ_STAT as 0 and returned IRQ_NONE.
> 
> Marvell's own driver for these chips clears the two registers in the
> opposite order and says so ("clear global before channel"), and
> ahci_xgene handles its broken edge latch the same way.  Since the
> reordering costs at most one spurious interrupt per valid one on
> conforming controllers, do it in a private interrupt handler selected for
> board_ahci_mv instead of changing libahci for everyone.
> 
> With this applied, SATA-2 and SATA-3 disks work at 3.0 Gbps on the
> 88SE6121 without the drive-side 1.5 Gbps jumper that was needed before.
> Time from link up to a successful IDENTIFY:
> 
>   WDC WD5000AADS-00S9B0  port 0    7 ms  (never identified before)
>   WDC WD3202ABYS-01B7A0  port 1   28 ms
>   WDC WD30EFRX-68EUZN0   port 1  200 ms  (3 TB, HPA detection ok)
> 
> Only the 88SE6121 was tested; board_ahci_mv also covers the 88SE6145,
> which Marvell's driver treats identically.
> 
> Link: https://lore.kernel.org/linux-ide/db6b48b7-d69a-564b-24f0-75fbd6a9e543@noerenberg.de/
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216094
> Signed-off-by: Hajo Noerenberg <hajo-linux-ide@noerenberg.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
