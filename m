Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9242F5337
	for <linux-ide@vger.kernel.org>; Wed, 24 Jun 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301875; cv=none; b=BxUBBnG68Bbg0bFt/QpGHp5Zg9JTLnzOC8MG3EqFalHluSLF9NnJ5QdiCD2SjKQAh8bwElIcJsEJS5lccfc1Tujvo1Q4asXKXkoLfXaFn9UdPsDz9qwBrhNi+pquMLwidMJjFl8hCV9U5I7C4rwyC5DhmUGGd7GgOiBCBzqqY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301875; c=relaxed/simple;
	bh=2R0zdF40YuJJ76nqItxomwXSfBaOQY7cCr+B4UJGVSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTKYZJqo0pR/9gDwklCfgKug1djsuWOwdCRZfYmUj7agfulslcr8QgFmk55Zqj8aKTW/pq5B7GSwzG4tZtlYQ0IoV+wveAnMk050KqV011zsCS3r5T/Cw6qXLFEJ4zQqV6Q/iWYjg+CPy13aROHJ81C66x7CMUEcvsRRo8rleDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUgkAseL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUgkAseL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786401F000E9;
	Wed, 24 Jun 2026 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782301874;
	bh=KVo3/RssVFEdwUcQfzhxdrr+PUr99x1lpcVfsjxsmbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TUgkAseLZTr8zwegHsXxjPJ9mY+Vl2QD8mHAx9SHO/fjU4wSLt590OJ+GebuaheTV
	 K0MKh9UUKcTPN+AW1U8vmP3X4q4N/WT9UtldHnnIMJNMvoWDhbqDxc2GLT0CkV2O+m
	 Gj4Vn4g/F8PLZW0v6pe1ROhLlCMfcBxdgTR0TCC2XZwh6FPKowJmHM/hCHuehnzRnr
	 ENgq/i0noQJSl7dHW2DCb9bBOtKkjbLULYUxmkkVtLf/5oJRmRBfFWxsmc/XYv+vwd
	 l4ExLSLvwCB9FpYxq5y82Tz+LK+ZRE8h/B369rPJQsMnYydFWR3pyuCIz8ZsiU4dhO
	 DY/fwKGTHsbIg==
Date: Wed, 24 Jun 2026 13:51:10 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] ata: libata-scsi: fix ata_scsi_security_inout_xlat()
 buffer length conversion
Message-ID: <ajvErjEiGUuFm75I@ryzen>
References: <20260624090931.1483644-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624090931.1483644-1-dlemoal@kernel.org>

On Wed, Jun 24, 2026 at 06:09:31PM +0900, Damien Le Moal wrote:
> ata_scsi_security_inout_xlat() converts the SCSI command buffer length
> into the ATA sector size based size by aligning upward the length to 512B.
> That is incorrect as that can lead to specifying a buffer size that is
> larger than the memory allocated for the command buffer, resulting in all
> sorts of possible command failures and/or memory corruptions.
> 
> Ideally, we should bounce the buffer to a large enough size to fit
> the entire SCSI command buffer, but we do not have anything in place to do
> that cleanly. So for now, fix this by converting the command buffer length
> downward with a simple division of the buffer length by ATA_SECT_SIZE.
> 
> Fixes: 818831c8b22f ("libata: implement SECURITY PROTOCOL IN/OUT")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/ata/libata-scsi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index d54ec1631e9a..e78801e7ea8c 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -4330,7 +4330,13 @@ static unsigned int ata_scsi_security_inout_xlat(struct ata_queued_cmd *qc)
>  		}
>  
>  		/* convert to the sector-based ATA addressing */
> -		len = (len + 511) / 512;
> +		if (len) {
> +			len = len / ATA_SECT_SIZE;
> +			if (!len) {
> +				ata_scsi_set_invalid_field(qc->dev, scmd, 6, 0);
> +				return 1;
> +			}
> +		}
>  	}

The code in question is located in the else clause for:
if (cdb[4] & 7) { /* INC_512 */

So this is for INC_512 set to zero.


From SAT6r02, SECURITY PROTOCOL OUT (sending security info to the device),
8.13.1 TRANSFER LENGTH field and INC_512 field:

"""
If the INC_512 bit is set to zero, then:

b) if the TRANSFER LENGTH field is set to a value less than or equal to
01FF_FE00h, the ATA TRANSFER LENGTH field shall be translated from a
number of bytes to a number of padded 512-byte units from the result of
the following calculation:

ATA TRANSFER LENGTH(15:0) = ((transfer length + 511) / 512)

If the length of the final data block is not a multiple of 512 bytes,
then the final data block shall be zero-padded (see SPC-5) to a multiple
of 512 bytes. The ATA trusted send command shall transfer the padded data
for the number of blocks specified by the ATA TRANSFER LENGTH field.
"""

So, at least as per SAT6r06, it says that the buffer for SECURITY PROTOCOL
OUT (as per SPC-5), which we receive from SCSI, when using INC_512 set to
zero, should already be padded with zero bytes to be a multiple of 512.

So if this is not the case, I think the fix should be in SCSI.
I guess we could add code in libata to return an error if INC_512 set to zero,
and scsi_bufflen(scmd) (+ scmd->extra_len ?) is not a multiple of 512.
But to me, for SECURITY PROTOCOL OUT, the current libata code looks correct.




From SAT6r02, SECURITY PROTOCOL IN (retrieving security info from the device),
8.12.1 ALLOCATION LENGTH field:

If the INC_512 bit is set to zero, then:

"""
b) if the ALLOCATION LENGTH field is set to a value less than or equal to
01FF_FE00h, the ATA TRANSFER LENGTH field shall be translated from a
number of bytes to a number of padded 512-byte units from the result of
the following calculation:

ATA TRANSFER LENGTH(15:0) = ((allocation length + 511) / 512)

After completion of the ATA trusted receive command without error,
the data shall be transferred to the SCSI application client up to the
number of bytes specified in the ALLOCATION LENGTH field.
"""

Here is also says that the buffer should be padded, but it does not mention
that it is a requirement of SPC-5.

Looking at the SPC-5 for SECURITY PROTOCOL IN (rx):
"Pad bytes may or may not be appended to meet this length."

So this differs from SPC-5 SECURITY PROTOCOL OUT (tx):
"Pad bytes shall be appended as needed to meet this requirement."


So it seems that (assuming that upper layer is SPC-5 compliant),
libata code is correct for SECURITY PROTOCOL OUT (tx).

For SECURITY PROTOCOL IN (rx), it seems that SAT specification requires the
buffer to be padded, but SPC-5 does not... Lovely...


For your workaround, we should probably ensure that it is only applied for
SECURITY PROTOCOL IN (rx). But... would we not be violating the SAT spec?

If we get a SCSI command with a scsi_bufflen that is not 512 aligned, and we
apply your workaround, we will transfer less than scsi_bufflen to the device
(since you now round down instead of up), but AFAICT, when calling
ata_scsi_qc_complete() + ata_scsi_qc_done(), nowhere do I see that we call
scsi_set_resid(), to indicate that the transfer has been truncated (i.e.
that we did not transfer all scsi_bufflen() number of bytes), so it seems to
me that your workaround would silently truncate the transfer, without informing
the upper layer (SCSI) that the result is truncated.

Tell me if I am missing something.


Kind regards,
Niklas
