Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AE107B6
	for <linux-ide@vger.kernel.org>; Wed, 24 Jan 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092885; cv=none; b=tmQzMNlG9OUUEUOQxw4Ry9jkd6I1lvHbQZFy7mszL2NtF2ItKmPbjleTIOGeohrpOAoITt8nEWG15ph1fm8TeUOHhiCqRRvpT1WZ7kbbDmGPRR5pbmkKdqYPSUCYO7+q+MCJPGHhz8a2fGKjDXKqjBcALX4oWIcssSfSB5SWofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092885; c=relaxed/simple;
	bh=aQV5wdtHG6XVbVmskbVq/ID3RemofwlXNGFh3SBPOFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTpUWJBuQbA7WXHKE5tMw4HZFuZoj53eB9a+EGjcYQqPLXCwGj8GPrTlbEhPJVoW6D7z8MU0hD5m4y/DDZPNDaCLgkRhnwYKOgP5WDBxBK3oBizXAuJhduyAMy51kVTpqelUsvKnIIPpiWhrfTwX7/k+4UCyl/LqRwv6uU5pDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sbp9/74E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sbp9/74E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DF2C433F1;
	Wed, 24 Jan 2024 10:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706092885;
	bh=aQV5wdtHG6XVbVmskbVq/ID3RemofwlXNGFh3SBPOFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sbp9/74EmRDp6a03JeRwTTam8jTaG48wsugt5Myla2tJqbd4T6N/zlW7E9VAM75xm
	 TM3OkZ+vikJS1XVXlc1VAGxPwj9woEBaE5MMF74f+AMm6+C3UN4VdSNY55avjo83jp
	 FfOz6cIXtbYvEHcmSGb0+1WfbunN0OsegpoEaVrv3kPSzd7/TcKJbvX/LECjbA68Xd
	 aqku1E4zW0G6BfPgfPowyRNoLYEA01rJ7e49CaXAqSgkRNgk+bYlZLLwF5XFk9htOP
	 psQ8P6Vcahpm6VjcU14np7X3uvJkjwJVUx7rdtKQ7xa2J/lAMv1MP0SMxZz9GIf4/b
	 KhZGZwUF+akCw==
Date: Wed, 24 Jan 2024 11:41:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Szuying Chen <chensiying21@gmail.com>,
	"Jesse1_Chang@asmedia.com.tw" <Jesse1_Chang@asmedia.com.tw>,
	"Richard_Hsu@asmedia.com.tw" <Richard_Hsu@asmedia.com.tw>,
	Szuying Chen <Chloe_Chen@asmedia.com.tw>
Cc: Lennert Buytenhek <kernel@wantstofly.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: ASMedia ASM1062 (AHCI) hang after "ahci 0000:28:00.0: Using
 64-bit DMA addresses"
Message-ID: <ZbDpTrt0lU/llRMp@x1-carbon>
References: <ZaZ2PIpEId-rl6jv@wantstofly.org>
 <ZaaQpiW3OOZTSyXw@x1-carbon>
 <ZahDNr97MSPNSHW_@wantstofly.org>
 <ZahaKaV1jlHQ0sUx@x1-carbon>
 <ZbAo_LqpbiGMfTtW@wantstofly.org>
 <ZbDjL0TDnUfzknZS@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbDjL0TDnUfzknZS@x1-carbon>

Hello ASMedia guys,


It seems like ASMedia ASM1061 does not work with recent Linux kernel versions:
https://lore.kernel.org/linux-ide/ZbAo_LqpbiGMfTtW@wantstofly.org/T/#m2e12f7f0060f0f6cbf3fcb9ec8eecc2c1d1b5799

Lennert on the linux-ide mailing list has done some detective work that
strongly suggests that ASMedia ASM1061 ignores the upper 21 bits of all
DMA addresses.


See full analysis here:
https://lore.kernel.org/linux-ide/ZbAo_LqpbiGMfTtW@wantstofly.org/T/#m02d07243492868085b56c6173efe42e814359017

Basically he modifies libahci.c:

--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1667,6 +1667,12 @@ static unsigned int ahci_fill_sg(struct ata_queued_cmd *qc, void *cmd_tbl)
                dma_addr_t addr = sg_dma_address(sg);
                u32 sg_len = sg_dma_len(sg);

+               printk(KERN_INFO "mapping dma_address=%.16lx sg_len=%.8lx dma_dir=%d\n",
+                       (unsigned long)addr, (unsigned long)sg_len, qc->dma_dir);
+
+               if (qc->dma_dir == DMA_TO_DEVICE)
+                       addr |= 0xfffff80000000000;
+
                ahci_sg[si].addr = cpu_to_le32(addr & 0xffffffff);
                ahci_sg[si].addr_hi = cpu_to_le32((addr >> 16) >> 16);
                ahci_sg[si].flags_size = cpu_to_le32(sg_len - 1);

So he force sets all the upper 21 bits in the address sent to the device,
but can still mkfs.btrfs, mount and scrub the filesystem.
This should of course not have worked, and should have resulted in a bunch
of IOMMU page fault errors in the log, but it doesn't.

Can you guys verify that ASMedia ASM1061 only supports 43-bit DMA addresses,
even though it sets AHCI CAP.S64A, which says "Indicates whether the HBA can
access 64-bit data structures." ?


Kind regards,
Niklas
