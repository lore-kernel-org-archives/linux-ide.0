Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20126F2A7
	for <linux-ide@vger.kernel.org>; Wed, 31 Dec 2025 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767179869; cv=none; b=n/I5KPPVf91KEmFO27FJYbgFwRQ84yL4qFxUe8pgihTb6CRJtQL/WAx7V3K3w21LNg3Zfi8Td/RP4+Rg1MOuVHSwh7OjvXk1slayCRx4CsKS86eWTJDSlWILtIeLmBzVgmbu6IDNXhak5LLj9dtTtGF3kgKn5bqLIXq6F7Bn8Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767179869; c=relaxed/simple;
	bh=77I7z5jU3jYmYNc9y9hM5bDujMy8Qf3CMM7Ll16aH4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN7NyTvH2gEmZ107WPG3xDGyqrAnJtUXujdF4op2QUTgPmMbw00Bu9NsX0uHE4FP/jAjqnWD7EcPCo4vJRbLYT4dzfurkZPrC3KnKBpQ5tm1w+iPZd/SCALrZoF6of2MbU6hdihu0fAFqroMbhGuxnLEPOsueSlcOkQJXuA1of8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftT/0doi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftT/0doi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26AC113D0;
	Wed, 31 Dec 2025 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767179867;
	bh=77I7z5jU3jYmYNc9y9hM5bDujMy8Qf3CMM7Ll16aH4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ftT/0doiCNwXy4cl/JXYmzhpRukoujxGppfOmCZ+oRP1gCJ/mMGAYqLCRO6jd8fqQ
	 vrEXocMjTC4FW6U23mu5loGR/+gfnAlZjtu0B10Zt4Kq/P8eoczrjxPtCFoK++ZwBR
	 OW2Y+jMVWxmSYVDBSA5kHbX+Cyky3RMMxPn2A5nx2DSkFg3tHn8hzoNVM0im/czPE6
	 LQJQwIAWq05iEj4bCxYoneBL21supLEHLzeLLAmRs15yPSAeApjNoI2z6Nc8RCqogU
	 sqn8XXUQoKyQU08zyCfHD9eA0hBSh9bSjx/IUWjxcOI5Nxa1w8/UhIj9Vodu6J7l39
	 W/jfxpAnYvHXQ==
Date: Wed, 31 Dec 2025 12:17:42 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aVUGVo3Oym2IcpPS@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220002140.148854-3-dlemoal@kernel.org>

On Sat, Dec 20, 2025 at 09:21:40AM +0900, Damien Le Moal wrote:
> When a non-NCQ passthrough command is issued while NCQ commands are

Same as cover letter:
s/non-NCQ passthrough command/non-NCQ command/


> being executed, ata_scsi_defer() indicates to ata_scsi_translate() that
> ata_qc_issue() should not be called for the passthrough command, and

s/passthrough//


> instead returns SCSI_MLQUEUE_XXX_BUSY to defer the command execution.
> This command deferring is correct and as mandated by the ACS
> specifications since NCQ and non-NCQ commands cannot be mixed.
> 
> However, in the case of a host adapter using multiple submission queues,
> when the target device is under a constant load of NCQ read or write

s/NCQ read or write commands/NCQ commands/

There are other NCQ commands, such as NCQ SEND and NCQ RECEIVE.
E.g. a user could saturate the queue by doing a NCQ encapsulated READ LOG
DMA EXT.


> commands, there are no guarantees that requeueing the non-NCQ command
> will lead to it not being deferred again repeatedly, since other
> submission queues can constantly issue NCQ commands from different CPUs
> ahead of the non-NCQ command. This can lead to very long delays for the
> execution of non-NCQ passthrough commands, and even complete starvation
> in the worst case scenario.
> 
> Since the block layer and the SCSI layer do not distinguish between
> queuable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT

s/queuable/queueable/


> implementation must ensure forward progress for non-NCQ commands in the
> presence of NCQ command traffic. This is similar to what SAS HBAs with a
> hardware/firmware based implementation do.
> 
> Implement such forward progress guarantee by limiting requeueing of
> non-NCQ commands: when a non-NCQ command is received and NCQ commands
> are in-flight, do not force a requeue of the non-NCQ command by
> returning SCSI_MLQUEUE_XXX_BUSY in ata_scsi_translate() and instead
> hold on to the qc using the new deferred_qc field of struct ata_port.
> 
> This deferred qc will be issued using the work item deferred_qc_work
> running the function ata_scsi_deferred_qc_work() once all in-flight
> commands complete, which is checked with the port qc_defer() callback
> indicating that no further delay is necessary. This check is done using
> the helper function ata_scsi_schedule_deferred_qc() which is called from
> ata_scsi_qc_complete(). This thus excludes this mechanism from all
> internal non-NCQ commands issued by ATA EH.
> 
> When a port deferred_qc is non NULL, that is, the port has a command
> waiting for the device queue to drain, the issuing of all incoming
> commands (both NCQ and non-NCQ) is deferred using the regular busy
> mechanism. This simplifies the code and also avoids potential denial of
> service problems if a user issues too many non-NCQ passthrough commands.

Instead of introducing a workqueue, did you try/consider to do it the same
way that we handle CDL commands that completed without error:
https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/ata/libata-core.c#L4971-L4988

I.e., in qc_defer(), if we try to queue a non-NCQ command while there
are NCQ commands active, set ATA_PFLAG_EH_PENDING so that we do not
trigger fast drain (we wait for the active commands to finish),
and then call ata_qc_schedule_eh() on the non-NCQ qc.

Sure, for passthrough commands specifically, SCSI will not want to
retry the command, because scsi_noretry_cmd() will return true:
https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/scsi/scsi_error.c#L2227

But this could easily be solved by e.g. modifying scsi_noretry_cmd()
to add an additional "case DID_REQUEUE: return false;"

And also set set_host_byte(scmd, DID_REQUEUE); (probably based on a
new ATA_QCFLAG_DEFER flag or simiar), after we have cleared DID_TIME_OUT
using set_host_byte(scmd, DID_OK):
https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/ata/libata-eh.c#L640

Since this works for CDL commands, I don't see why we shouldn't be able to
also send a non-NCQ command (if there are NCQ commands active), via SCSI
EH, so that SCSI itself retries the command, rather than us holding/hiding
a command from the SCSI queue, by using an additional workqueue in libata.

(If libata is just a SCSI LLDD, it somehow feels more logical to make use
of the SCSI queue, rather than to add our own queueing in libata using a
workqueue.)


Kind regards,
Niklas
