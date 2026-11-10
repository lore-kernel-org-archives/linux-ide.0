Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300097;
	b=SCCwCXdiUIYQE2LO5q04DxXyyA0a/IBDHy+WcwdHA42kHawTOZ08agX5MZ7QRRNE1AZZ
	 qCl9WS9EguX3e7a6kn4JwD6YpWQDAbqPJil9ypeXF4OTYXusXgu1n1PgVVsy1ig3X3LAP
	 K/qCeuWHfC4n9bIhBggZP+QwtIgLXhA38H0NfI0I/BYbo/AjuAQw4gOZDTxcsHi6DrVIg
	 gOASn2AYfZdTSbywwUYwzwoLrL2YvOiBEyCu6wFNIFqH2do4fx5sFaQxZvhe+CafQbQuU
	 hrcqdbJyyejSlJHvaAGONgw8ASpt1zBB622Dw6HFSIOybfUqEzqOqWjv4hhZEF78khQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300097;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=StFoDPIqS5hrk5H7dyooA3aSHFFt/8LJ4+jaEMtL/so=;
	b=AAc2aYNHIP+/DD90iocwZl+DBKX1VBM1vVG2DMeLwRkrD7/xCLY5Izpz6JDAFi300zgQ
	 Bt8Z0D8B796DIonYSFlPBjzXmbb19u09hsGO5THgfzgI6VQgZI6LjnexSsutpBJuKPBg/
	 lPYPjhh0EcOKRrVK26xNMcpSsNOygKXOG42ZOoQbtdJNgw0MgnjJomasv+CLC6sYz/EpG
	 p49Rgq+EkqbZ/dJEinYbf98IfQVZRowm8axz0X1VRVNCV9RCotDVQrfpwn2I2aE+3skff
	 sKX4jj2EW3FAztmWgbzq/z8PWa0RNtMSluLJmUp/XQCM6wg2E3mK4rQufz0UrCUmtsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLxkFaBe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C06606A31C
	for <linux-ide@vger.kernel.org>; Tue, 10 Nov 2026 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BLxkFaBe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3AE1F008A1;
	Tue, 10 Nov 2026 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794300097;
	bh=StFoDPIqS5hrk5H7dyooA3aSHFFt/8LJ4+jaEMtL/so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BLxkFaBeMUoXI7aO8cPuJkN1PmvinZZTQjfiqXAkJXJTEzRKzVoOdt+qPtqt3wCbH
	 CjOd/lCPDy2/fbQMncqVEdC8BnTRZrK+1Z29Fu1Gu/ctuNIHSi/FGPIkV0buj9mgaY
	 Q7kaBtfRpoqTDm9KSyh/lLLvxP5xl++GC71+Su4BrMvDvt/Ewuym2hCyYoyNaJE6Ak
	 204sOZfqLTH4DJ4Q3TwSo5PnBc93oDMv3cU8HRjUUkGaP+kjXfiffB+VhoO8Phubv0
	 3hJkUhEa4ekyX6Q6H/ZfOLNgccxeeeOtG9UTHDtCJlzERxCyK+sFDwMMCTitCzO7co
	 ZrYaEY3hBPSZg==
Date: Tue, 10 Nov 2026 09:41:34 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: reject non-PIO protocols for
 READ/WRITE MULTIPLE
Message-ID: <avLYvtmnedp5FXSX@ryzen>
References: <20261028140432.20489-1-zhaogongyi@bytedance.com>
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Post: <mailto:linux-ide@vger.kernel.org>
List-Help: <mailto:linux-ide+help@vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-ide+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028140432.20489-1-zhaogongyi@bytedance.com>

Hello Zhao,

On Wed, Oct 28, 2026 at 10:04:32PM +0800, Zhao Gongyi wrote:
> From: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>
> 
> The commands recognized by is_multi_taskfile() are ATA READ/WRITE
> MULTIPLE variants, which transfer data using PIO. ata_scsi_pass_thru()
> validates the MULTIPLE_COUNT field for these commands, but accepts any
> protocol selected by the ATA PASS-THROUGH CDB.
> 
> This allows userspace, for example, to combine WRITE MULTIPLE with the
> DMA protocol. With a QEMU PIIX disk, the device enters its PIO data phase
> and waits with DRQ asserted while the host waits for DMA completion. The
> request remains active until the user-selected command timeout. Since
> the disk has a single tag, filesystem writeback and later SG_IO requests
> block behind it.
> 
> Require the protocol to map to ATA_PROT_PIO when is_multi_taskfile()
> recognizes the command. Reject any other protocol as an invalid CDB
> field before issuing the taskfile. Keep the check local to the existing
> READ/WRITE MULTIPLE handling so pass-through behavior for other ATA
> commands is unchanged.
> 
> Fixes: 1dce589c38c3 ("libata passthru: support PIO multi commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>
> ---
> Tested on a QEMU PIIX disk with 16-sector transfers and a multiple count
> of 16:
> 
> - WRITE MULTIPLE with DMA was rejected with ILLEGAL REQUEST/INVALID
>   FIELD IN CDB and a field pointer of 1.
> - READ MULTIPLE with DMA was rejected with the same sense data.
> - WRITE MULTIPLE with PIO data-out completed successfully.
> - READ MULTIPLE with PIO data-in completed successfully and returned the
>   8192 bytes written by the preceding command.
> 
> Both invalid commands completed in less than 1 ms. No ATA timeout or
> hung-task warning was reported, and subsequent I/O remained responsive.
> The modified libata-scsi.o also builds successfully.
> 
>  drivers/ata/libata-scsi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 115b75a313..31d822d78e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3507,6 +3507,11 @@ static unsigned int ata_scsi_pass_thru(struct ata_queued_cmd *qc)
>  	if (is_multi_taskfile(tf)) {
>  		unsigned int multi_count = 1 << (cdb[1] >> 5);
>  
> +		if (tf->protocol != ATA_PROT_PIO) {
> +			fp = 1 + cdb_offset;
> +			goto invalid_fld;
> +		}
> +
>  		if (!dev->multi_count) {
>  			ata_scsi_set_sense(dev, scmd, ABORTED_COMMAND, 0, 0);
>  			return 1;
> 

I'm a bit conflicted about this patch.

There is nothing in SAT specs that requires us to validate the protocol field.
When using normal (non-passthrough commands), the protocol field is initialized
by the regular SCSI to ATA translation done by libata.

For passthrough commands, it comes from the user.

Not only does it come from the user, it requires CAP_SYS_RAWIO:

scsi_cmd_allowed() {
        if (capable(CAP_SYS_RAWIO))
                return true;
    ...


(ATA_12 / ATA_16 / ATA_32 will all return false, so not allowed for a regular
user.)

And... even if the user sends a command with a protocol that is not as per
ACS spec, the command should time out and EH should reset the device.


So... If the user sends a passthrough command with the wrong protocol...
Well, that is on the user, no?
(It also requires CAP_SYS_RAWIO)


If we were to add protocol checks all passthrough commands, then we should
not only check READ/WRITE MULTIPLE, we should check other commands like
WRITE SECTORS (30h) and IDENTIFY DEVICE (ECh) too.

But, I don't think we want that. Damien, thoughts?


Kind regards,
Niklas
