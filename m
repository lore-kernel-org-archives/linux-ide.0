Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12561E487
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767314879; cv=none; b=Q23RuhHxPrkKs7dGIjDezi8m6I2bYJp4knJe8atz87hhE2g7JiJUyg3m99Dy5aPo57+Zs2sbFr7+vTn+K9fRSiAU6IwxFc0jxmKtFKplhA3lsuYHF6z4HiN+guTrbZ8BHtYaqOiALnXYf0jRLUIMTD9wHLzN/8Gwn1qGUl+6biA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767314879; c=relaxed/simple;
	bh=rfjK7t4rWcY3mPdjCwEbSraqOQIxdEzSjwlsjwyootI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEzun4W45PRJxuwlLGtJMEhHgNa5k+jqkGRBXPM/XZR+TucT/a6Fo08R6jXn15izjgrew3HhW6qT1YhHd5v/ND2ndU5I90kPQnns6OsGwj4Vw6dSDlz+6bOonPHLelv6JuyDZqDZfA5q+48heuhKRdgTKpO/0sLYOpwTT07c/Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjHsU4ll; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjHsU4ll"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3BFC4CEF7;
	Fri,  2 Jan 2026 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767314879;
	bh=rfjK7t4rWcY3mPdjCwEbSraqOQIxdEzSjwlsjwyootI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjHsU4llBcZxgq4AHgH74NObILOxslcLLoZHbLytV2g46pPyV5BPwThqGIVkEOYIu
	 kaQ5Rl1jCDM03LG/uQg4EvmFQtjiLwm9cHhd4Ccvw0lvVvKXUTBxDT21PQx/Poy+gR
	 r/7uErrWLYzLNFJuJzOEE07nJBT9hqVSZURyJD/K+H7lGwKF3E/spHoIR0H+cK8qUD
	 oJERHIKdr+wd6XRpYvObXUVtgk7cXZT7wk0AdEmZK/HmYDG3maaJU57ecJ9Dd7wTS8
	 s07sbNIdDpeDUCaEh2rqWtFFGhPylXZrPGMVN8mwA5T/1i6YWuW5RyFLRRiaisq136
	 2uBHk3x9Fy1Ag==
Message-ID: <a5fe5447-a648-4e50-aa3f-841bb87614ec@kernel.org>
Date: Fri, 2 Jan 2026 09:47:57 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
 Xingui Yang <yangxingui@huawei.com>, John Garry <john.g.garry@oracle.com>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org> <aVUGVo3Oym2IcpPS@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aVUGVo3Oym2IcpPS@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 20:17, Niklas Cassel wrote:
>> Implement such forward progress guarantee by limiting requeueing of
>> non-NCQ commands: when a non-NCQ command is received and NCQ commands
>> are in-flight, do not force a requeue of the non-NCQ command by
>> returning SCSI_MLQUEUE_XXX_BUSY in ata_scsi_translate() and instead
>> hold on to the qc using the new deferred_qc field of struct ata_port.
>>
>> This deferred qc will be issued using the work item deferred_qc_work
>> running the function ata_scsi_deferred_qc_work() once all in-flight
>> commands complete, which is checked with the port qc_defer() callback
>> indicating that no further delay is necessary. This check is done using
>> the helper function ata_scsi_schedule_deferred_qc() which is called from
>> ata_scsi_qc_complete(). This thus excludes this mechanism from all
>> internal non-NCQ commands issued by ATA EH.
>>
>> When a port deferred_qc is non NULL, that is, the port has a command
>> waiting for the device queue to drain, the issuing of all incoming
>> commands (both NCQ and non-NCQ) is deferred using the regular busy
>> mechanism. This simplifies the code and also avoids potential denial of
>> service problems if a user issues too many non-NCQ passthrough commands.
> 
> Instead of introducing a workqueue, did you try/consider to do it the same
> way that we handle CDL commands that completed without error:
> https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/ata/libata-core.c#L4971-L4988
> 
> I.e., in qc_defer(), if we try to queue a non-NCQ command while there
> are NCQ commands active, set ATA_PFLAG_EH_PENDING so that we do not
> trigger fast drain (we wait for the active commands to finish),
> and then call ata_qc_schedule_eh() on the non-NCQ qc.

I thought about it but ruled it out so that we do not overload EH with handling
of non-NCQ commands. libata EH is already complicated enough :)

> Sure, for passthrough commands specifically, SCSI will not want to
> retry the command, because scsi_noretry_cmd() will return true:
> https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/scsi/scsi_error.c#L2227
> 
> But this could easily be solved by e.g. modifying scsi_noretry_cmd()
> to add an additional "case DID_REQUEUE: return false;"
> 
> And also set set_host_byte(scmd, DID_REQUEUE); (probably based on a
> new ATA_QCFLAG_DEFER flag or simiar), after we have cleared DID_TIME_OUT
> using set_host_byte(scmd, DID_OK):
> https://github.com/torvalds/linux/blob/v6.19-rc3/drivers/ata/libata-eh.c#L640

You are kind of proving my point here: I feel that is all much more complicated
than using the libata internal deferred qc work. Also, involving the SCSI layer
about non-NCQ commands deferral is kind of a layering violation as the
non-queueable command concept does not exist in SCSI.

> Since this works for CDL commands, I don't see why we shouldn't be able to
> also send a non-NCQ command (if there are NCQ commands active), via SCSI
> EH, so that SCSI itself retries the command, rather than us holding/hiding
> a command from the SCSI queue, by using an additional workqueue in libata.

Sure, we could make that working, but as mentioned above, I feel that is a lot
more complicated.

> (If libata is just a SCSI LLDD, it somehow feels more logical to make use
> of the SCSI queue, rather than to add our own queueing in libata using a
> workqueue.)

libata must act as a SATL and the SAT specifications are clear about what a SATL
implementation can do for non-NCQ commands. Referring to SATA6r01:

6.2.5 Commands the SATL queues internally
If the translation of a SCSI command requires the SATL to send an ATA non-NCQ
command to the ATA device while one or more ATA commands are active, then the
SATL shall:
a) suspend processing of that SCSI command, and:
	1) maintain the SCSI command in a task set;
	2) resume processing of that SCSI command when the ATA device returns command
complete for all ATA commands the SATL has previously sent to the ATA device; and
	3) after that SCSI command completes, resume processing of other SCSI commands;
b) return TASK SET FULL status for that SCSI command; or
c) return BUSY status for that SCSI command.

What you are proposing does not nicely fit. This patch essentially implements
option (a). Option (c) is the current code, which causes the issue for
multi-queue cases (note that AHCI is not affected because it is single queue).
And option (c) would be mostly equivalent to (b) and cause the same issue as
that would involve a requeue too.


-- 
Damien Le Moal
Western Digital Research
