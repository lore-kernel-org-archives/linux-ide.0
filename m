Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A7E5D8F0
	for <linux-ide@vger.kernel.org>; Tue,  3 Mar 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772534306; cv=none; b=RQ8H1DQup82VcbX8qSJPQE5VTPpOy+X6Z1MAXepw21982sDIYBb6Rq+qWDYpt04N7BiMCd3jGhY4sG+J9A8pm2m8dEb2Pd4PL3INspGX8Rcc3zqbux4gOnR8nKCK6vrtWxfsI3t1sE3t0O/S/c6SZ7Zq2KvPldIxYrdIO12AjtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772534306; c=relaxed/simple;
	bh=3oMhmE86SYRCNlEHWbay4Z9GcF9/yR2peATW0rFKxJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX+lTo54kSd2gjx+H6C2QnfVYUqnyqMZQ+v9x1RVw540fKNRpNhsvxrahQk90P6IsDmaUfTw+34mujF9URiOMpqAeFaDHlP/CYkUeGoaCXVMgkLBDwKw696QLcjByAIHwbQ7zZZTzrAUihBRVIH11CvcJvnYm+kcDwovnViPUDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRSIt+eg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRSIt+eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE63C116C6;
	Tue,  3 Mar 2026 10:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772534306;
	bh=3oMhmE86SYRCNlEHWbay4Z9GcF9/yR2peATW0rFKxJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SRSIt+egPqOmEeasMq0DikLgWDefqANNZErl9jEavsif56f3ZLbT11nzjdFFf2WDk
	 Ir3ENDGmD1ncgGe4X15f9tK8rlb68+h9vvjCtH+FHTi0wN37QyrcCS8I64AKMYDvCF
	 falJS8s2Q5Cj6l45CaDPlU+R5Tf7RCK/4ob83RJ/0BdOczbst6b2f8ftBLoNlyoArp
	 4fpl//mvyF9tqOVd6gaqtDEAy1tsXntsPl21dFhYwYrrGxEA3AHtZ7wGrI1uHkN0wV
	 IkzjJlFcxkDjev/DLrNHmizcBnALWiWgwV/GBFfE86oHUMZj0XpoRizk64SSq/5np2
	 3k36rxqNonMKg==
Message-ID: <35ff2f3a-7bd1-47e3-903e-4a1d22f5e8e9@kernel.org>
Date: Tue, 3 Mar 2026 19:38:23 +0900
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata: cancel pending work after clearing
 deferred_qc
To: Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Igor Pylypiv <ipylypiv@google.com>
Cc: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com,
 linux-ide@vger.kernel.org
References: <20260303100341.362978-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260303100341.362978-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 19:03, Niklas Cassel wrote:
> Syzbot reported a WARN_ON() in ata_scsi_deferred_qc_work(), caused by
> ap->ops->qc_defer() returning non-zero before issuing the deferred qc.
> 
> ata_scsi_schedule_deferred_qc() is called during each command completion.
> This function will check if there is a deferred QC, and if
> ap->ops->qc_defer() returns zero, meaning that it is possible to queue the
> deferred qc at this time (without being deferred), then it will queue the
> work which will issue the deferred qc.
> 
> Once the work get to run, which can potentially be a very long time after
> the work was scheduled, there is a WARN_ON() if ap->ops->qc_defer() returns
> non-zero.
> 
> While we hold the ap->lock both when assigning and clearing deferred_qc,
> and the work itself holds the ap->lock, the code currently does not cancel
> the work after clearing the deferred qc.
> 
> This means that the following scenario can happen:
> 1) One or several NCQ commands are queued.
> 2) A non-NCQ command is queued, gets stored in ap->deferred_qc.
> 3) Last NCQ command gets completed, work is queued to issue the deferred
>    qc.
> 4) Timeout or error happens, ap->deferred_qc is cleared. The queued work is
>    currently NOT canceled.
> 5) Port is reset.
> 6) One or several NCQ commands are queued.
> 7) A non-NCQ command is queued, gets stored in ap->deferred_qc.
> 8) Work is finally run. Yet at this time, there is still NCQ commands in
>    flight.
> 
> The work in 8) really belongs to the non-NCQ command in 2), not to the
> non-NCQ command in 7). The reason why the work is executed when it is not
> supposed to, is because it was never canceled when ap->deferred_qc was
> cleared in 4). Thus, ensure that we always cancel the work after clearing
> ap->deferred_qc.
> 
> Another potential fix would have been to let ata_scsi_deferred_qc_work() do
> nothing if ap->ops->qc_defer() returns non-zero. However, canceling the
> work when clearing ap->deferred_qc seems slightly more logical, as we hold
> the ap->lock when clearing ap->deferred_qc, so we know that the work cannot
> be holding the lock. (The function could be waiting for the lock, but that
> is okay since it will do nothing if ap->deferred_qc is not set.)
> 
> Reported-by: syzbot+bcaf842a1e8ead8dfb89@syzkaller.appspotmail.com
> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note that a followup cleanup, we may want to define a
ata_scsi_cancel_deferred_qc() helper for the pattern:

	ap->deferred_qc = NULL;
	cancel_work(&ap->deferred_qc_work);

to avoid repetitions.

> ---
>  drivers/ata/libata-eh.c   | 1 +
>  drivers/ata/libata-scsi.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index b373cceb95d2..563432400f72 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -659,6 +659,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>  			 */
>  			WARN_ON_ONCE(qc->flags & ATA_QCFLAG_ACTIVE);
>  			ap->deferred_qc = NULL;
> +			cancel_work(&ap->deferred_qc_work);
>  			set_host_byte(scmd, DID_TIME_OUT);
>  			scsi_eh_finish_cmd(scmd, &ap->eh_done_q);
>  		} else if (i < ATA_MAX_QUEUE) {
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index c0dd75a0287c..ad798e5246b4 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1699,6 +1699,7 @@ void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
>  
>  	scmd = qc->scsicmd;
>  	ap->deferred_qc = NULL;
> +	cancel_work(&ap->deferred_qc_work);
>  	ata_qc_free(qc);
>  	scmd->result = (DID_SOFT_ERROR << 16);
>  	scsi_done(scmd);


-- 
Damien Le Moal
Western Digital Research
