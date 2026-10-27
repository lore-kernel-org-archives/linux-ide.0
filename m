Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136153;
	b=YnGixmbjx3Ri0IX8+dwg2ZWHOx/bSY6fcm69b/wUvAZop4hNNKNCmIDAaJsLAPv/7zKD
	 bewimRp5S9xt08iOnhlDcLN3gNotxjTyEgZJoHJsiF9YHL4h96V0MuXFwnRsAh/aqKPrA
	 AESxgsWD72dtoFbYJWZBplGOPU1HDMSdEuiT+GcQPIEoBd9IXEOethAEB6RBX3MHXNW/d
	 HYjkZb0y/nqdsMVhpI/lLs2xI1I+7CC75TMs72OL7adV+UVZJvvtG97jo3aKOp/yQzfU1
	 tsfCqABO+vle65TJLNU5/zYDPp5JnSEwY54JFKcJnlDb/25yOVbWBVFID5cmwHhsawA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136153;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3lNbho5qDbRHvCUA1vzw98v490B5l9D4wNrgRixzNow=;
	b=APee0dwBCz0zx42NyJF7PQt0Z70yBaX7dTfU5Fncte1Sr1KYlo3/f4r2rniaKBYDMFIg
	 LAAKhxp1T2t6ougQXKO1jWDm+TJCaO+/nvX8ZAqYNUKZLQyvZ6h3v89vWsKVFgRr9e9qf
	 ph4o0CQfpGqS/Y8KnueMUduxFwQyAZ+tbectQCDgh6DXVm30AP/Jb/0V24coRuLB0d5ED
	 vF9LK/6cJh5Z4h4WdYoLCCFEwY2Hg199jydDTnk+2+EXNAmyWEiyOQ4Oq6DAEM1ZkLJA5
	 X76k/z0G2PYgn7972KWnEp68x2jztCes62WR4RjsVmAH8ZAbSWJdzhPwqAQaoMplLpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VjuD/LXo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A00606A322;
	Tue, 27 Oct 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjuD/LXo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398161F01825;
	Tue, 27 Oct 2026 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793136152;
	bh=3lNbho5qDbRHvCUA1vzw98v490B5l9D4wNrgRixzNow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VjuD/LXom6aL6v7uQMWiIFxwKR6sWFJ9eDffg8uahxg7Had0uXKIJG0hXGn+TyJ+d
	 HLOU9gx5vCoZdv9Jt0cNFj/ASb/7wvnNQbXEtPuWkQ6mNYcpXXDBRK40eYzYgwbAtE
	 dvBx7uNozPiSdVpGSYf7TpekTVAK+xyala+ZF9P8av56fUHgyus2Fj1jQnTQ4B2wxn
	 L4yC9LzkAW68GF8NzCKG4t7kcfZi+e+lFda3acGfhQfcdDVobUfInRn83YrXpt5kRo
	 /UYAgk4T6AKg3SSwAPiRmkqQNzKhg7m/S5jYGAKOML5x7mza8JTyFFAt0+lEdfK7Pc
	 BKrFBvGrzk9tA==
Date: Tue, 27 Oct 2026 22:22:28 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: dlemoal@kernel.org, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: libata-scsi: reject to-device transfers for
 simulated commands
Message-ID: <auEWFIeX5tZJLXIg@ryzen>
References: <20261027090809.94126-1-zhaogongyi@bytedance.com>
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
In-Reply-To: <20261027090809.94126-1-zhaogongyi@bytedance.com>

Hello Zhao,

On Tue, Oct 27, 2026 at 05:08:09PM +0800, Zhao Gongyi wrote:
> ata_scsi_rbuf_fill() emulates commands that only return data to the
> initiator (INQUIRY, MODE SENSE, READ CAPACITY, REPORT LUNS and
> MAINTENANCE IN).  It builds the reply in a kernel buffer and then copies
> it into the request's scatterlist without looking at the transfer
> direction.
> 
> The scatterlist is built from the user buffer by the passthrough paths
> (bsg/SG_IO), which derive the data direction from the transfer lengths
> supplied by userspace.  A request can therefore carry a data-in command
> while declaring a to-device transfer.  The buffer is then pinned for
> reading only.  In the observed crash, an anonymous VMA covered the
> buffer address, but its page was not populated; the read-only pin
> resolved to the shared zero page.  Copying the reply into that
> scatterlist attempted to write to a read-only kernel page:
> 
>   BUG: unable to handle page fault for address: ffff888005140038
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0003) - permissions violation
>   PGD 7d00067 P4D 7d00067 PUD 7d01067 PMD 80000000050001a1
>   RIP: 0010:memcpy_orig+0x68/0x140
>   Call Trace:
>    sg_copy_buffer+0x1e2/0x250
>    ata_scsi_rbuf_fill+0xe6/0x280
>    __ata_scsi_queuecmd+0x12e4/0x1580
>    scsi_queue_rq+0x1ff7/0x33d0
>    blk_execute_rq+0x1c5/0x390
>    scsi_bsg_sg_io_fn+0x3bc/0xb00
>    bsg_ioctl+0x3ef/0x550
> 
> The faulting address falls inside the kernel rodata mapping and matches
> empty_zero_page (Kernel rodata 05000000-05dc2fff, empty_zero_page at
> physical 0x5140000), which confirms the reply copy attempted to write
> to the shared read-only zero page.
> 
> Even when the pinned page happens to be writable the reply silently
> corrupts the user buffer, since it was not mapped for writing.  Reject
> to-device transfers for these commands with an ILLEGAL REQUEST sense
> instead of copying the reply into them.  This is the same class of
> problem as commit 5da5231bb478 ("libata: if T_LENGTH is zero, dma
> direction should be DMA_NONE"), which rejects inconsistent data
> directions for ATA pass-through commands.
> 
> Reproduced on 7.3.0-rc6 with the syzkaller C reproducer against an
> ata_piix disk (/dev/bsg/0:0:0:0): the unpatched kernel panics on every
> attempt (4/4), while with this change the request completes with CHECK
> CONDITION and the reproducer survives 5/5 runs.
> 
> Standard-length CDBs behave the same way.  A correctly directed 6-byte
> INQUIRY still completes normally, while a 6-byte INQUIRY and a 10-byte
> READ CAPACITY(10) declared as to-device are rejected with CHECK
> CONDITION; on the unpatched kernel those same requests silently write
> the reply into the caller's page (the transfer has to be page aligned to
> take the zero-copy mapping path, otherwise it bounces through a kernel
> buffer and nothing is visible to the caller).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

The Assisted-by tag is deprecated since commit 1e035297ffda ("docs:
remove Assisted-by references").


> Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
> ---
>  drivers/ata/libata-scsi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index b3666519b..8b65b896e 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2009,6 +2009,12 @@ static void ata_scsi_rbuf_fill(struct ata_device *dev, struct scsi_cmnd *cmd,
>  	unsigned long flags;
>  	unsigned int len;
>  
> +	/* A data-out request may contain pages pinned without write access. */
> +	if (cmd->sc_data_direction == DMA_TO_DEVICE) {
> +		ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, 0x24, 0x0);
> +		return;
> +	}
> +

This patch does not compile on mainline.

Please rebase on latest Linus' tree.


The fixed call will be:
ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST, INVALID_FIELD_IN_CDB);



Your patch seems to only patch simulated commands (ata_scsi_rbuf_fill()),
I think you need to patch translated commands too (ata_scsi_translate()),
something like:

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 5cde90f..6fba9da 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -2048,6 +2048,19 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
        if (xlat_func(qc))
                goto done;
 
+       /*
+        * A data-out request may contain pages pinned without write access, so
+        * it must not be issued as a device-to-host transfer. Reject it before
+        * issuing, so that a completion handler never rewrites the buffer.
+        */
+       if (unlikely(cmd->sc_data_direction == DMA_TO_DEVICE &&
+                    ata_is_data(qc->tf.protocol) &&
+                    !(qc->tf.flags & ATA_TFLAG_WRITE))) {
+               ata_scsi_set_sense(dev, cmd, ILLEGAL_REQUEST,
+                                  INVALID_FIELD_IN_CDB);
+               goto done;
+       }
+
        return ata_scsi_qc_issue(ap, qc);



Rejecting before issuing is important because the ZBC IN and GET PHYSICAL
ELEMENT STATUS completions rewrite the buffer even when the drive aborts
the command.


Kind regards,
Niklas
