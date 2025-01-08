Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4254E335BA
	for <linux-ide@vger.kernel.org>; Wed,  8 Jan 2025 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736345143; cv=none; b=bdVgWGrpuDXS2Sgh+d2yCj0naURK7ioLjSmOGK2MSL1hvMz33boetCkffGc/zWfbsP7+fjsetLzjOlGK5Y6N4MCk3DK6f1vCnONyGwk6Efe9iITED4/+5xAQavMdGz7+/m2JyiJ7KvhPBi8egTpTDWa9So+loFlZOejnXio2ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736345143; c=relaxed/simple;
	bh=K67fmyVdg5U5h9pHbMjK99XTW/14yOOJ0Ry0hsVrXwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJcKfqwaTxOXhgcP4rB9i80FtC6vNqoV/ZDjDEulylSnEUsByj2YPobtR3fyY67RNfuyiPc5lSyS4Z6hC6RP0TJZJFehqqlfBHT5PKResJsTOoxeNRgGb+gKUoWOSjMydqLWWCKCPyhamdswHGpdEcbCN/KGMPFaOD4GNa24Rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OP3t+MI7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OP3t+MI7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA9C4CED3;
	Wed,  8 Jan 2025 14:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736345142;
	bh=K67fmyVdg5U5h9pHbMjK99XTW/14yOOJ0Ry0hsVrXwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OP3t+MI7/S/+912UzJfDHwjG2kt30O7W9Cemc+S6uRBiTQJWb3JvvFDcUkvTsGFqR
	 35yo4+oCzAzst28Et25ejd/RRPCZODG3bGcj0HPwLvf41gP53hJH7CbBIPaUx2xxW4
	 CtdRxZZXQAQQrw4cvhixOIDYLgXoXlIwu3syIchfaiZ1JdDnqa886ASkQmeib6l7ZJ
	 IvzZTTkmacf+3JNHJ58WeLciMRQbhZG8IAJa3Uvt1os1ir2QajZ0CHVW6X09BSzKIs
	 Tr7v7gYX3iQpL8ORXBaPxSfx+mPeMwVBu5AtbnifO1OjOOKhwvpdAKepu7gL7toWOU
	 wiKBAwosxdejQ==
Date: Wed, 8 Jan 2025 15:05:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Philip Pemberton <lists@philpem.me.uk>
Cc: linux-ide@vger.kernel.org
Subject: Re: Zip 100 ATAPI not working, "qc timeout" and "failed to clear
 UNIT ATTENTION"
Message-ID: <Z36GMwr49ihd2nAG@ryzen>
References: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6722ee8-5e21-4169-af59-cbbae9edc02f@philpem.me.uk>

On Wed, Jan 08, 2025 at 12:52:50PM +0000, Philip Pemberton wrote:
> I'm trying to connect an old Iomega Zip 100 ATAPI to a B550-chipset Ryzen
> system, to exchange files with an even older system. The Gigabyte B550 AORUS
> ELITE AX V2 rev1.3 motherboard doesn't have any PATA ports, so I'm using a
> SATA to PATA adapter.
> 
> Sadly it will not work in the B550 system (Kernel 6.8.0-51-generic x86_64,
> Linux Mint 21.3 based on Ubuntu 22.04). When I have the Zip drive connected,
> I get the following in dmesg and the sd device never appears:
> 
> ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: ATAPI: IOMEGA  ZIP 100       ATAPI, 12.A, max PIO3, CDB intr,
> DMADIR
> ata3.00: applying bridge limits
> ata3.00: configured for PIO0
> ata3.00: qc timeout after 5000 msecs (cmd 0xa0)
> ata3.00: failed to clear UNIT ATTENTION (err_mask=0x5)

Since we see that the drive name is printed, the ATAPI IDENTIFY command
succeded (ATA_CMD_ID_ATAPI (0xA1)).

The command that timed out is ATA_CMD_PACKET 0xA0, so a regular ATAPI command.

The UNIT ATTENTION print is just from atapi_eh_clear_ua(), which seems to be
called by ata_eh_recover() unconditionally for ATAPI devices, because they
always need to clear UNIT ATTENTION after a reset:
https://github.com/torvalds/linux/blob/v6.8/drivers/ata/libata-eh.c#L3232-L3234

But the reset is of course only triggered because a command has timed out.


Kind regards,
Niklas
