Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EF025BF13
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349484; cv=none; b=GIrfCDSfFS1yyUqW/izC3ikh/3BSuGBSPNjHHZJU3v2ArAHlQd7ofadRm6lZnMo8Q3zfdFbEF9Kj/HqRacAYH4+yUivRaAyA5J2muOjv4R10iUe21FwCXyfw/KyyoSgyKdgBMTPnAi09pSy01kOOSV+qTerNj/IXcyqmyphq32A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349484; c=relaxed/simple;
	bh=UQBuaYikUdagkiLezWyuR3dcXabBy/RSBt9pRszL92U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0qH6gyMGDdqisiGjMPOHuy7UzeggyGe0P5VxEFa6qdfH2CPAUTjbsQoXoqBXecIPa/ahx3hcrNm7tVJIp+WUedRK+PUXdyh5zvA+3X8wXlsSKuiOrMMgHcQ07DS/pyGSpOnZ7UXWMqtXsYyxV86/7nbDdMj/yPe9fCvN3BENvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGVXhEzu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGVXhEzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41A8C16AAE;
	Fri,  2 Jan 2026 10:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767349483;
	bh=UQBuaYikUdagkiLezWyuR3dcXabBy/RSBt9pRszL92U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGVXhEzuVA4V+LEbPvSQITV2plOYUTTSUekICBnsyfUvfbfitwX7Iqh6kXdIdKZuD
	 DdyLjGTUJCPGRNZPcEfXeBV+yfvVooOJBOWrWShV0qHqTCo2OKoBVCRmIz6R8VnCcU
	 9CGIxsDXae3ClwzUt3hZM+HR6oEuHM/77L3FSelTDcVqIhxtSBidQlYCT+wSnKYp7r
	 KuPBAwVQmUYN5iSsIImKE422/rRXxIJ3bhpV+fW8z5hjSSxq9zTVnch7JkSSv9felw
	 yI6Dyip7uPhNQcrwJZUQaqjB9peCCvcUwjXqlvdIcslwS+ezyMFNo2FV30V4wKgSHt
	 Ba0cGCuwo6pEw==
Date: Fri, 2 Jan 2026 11:24:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>,
	Xingui Yang <yangxingui@huawei.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v3 2/2] ata: libata-scsi: avoid passthrough command
 starvation
Message-ID: <aVec55qIL_U03pai@ryzen>
References: <20251220002140.148854-1-dlemoal@kernel.org>
 <20251220002140.148854-3-dlemoal@kernel.org>
 <aVUGVo3Oym2IcpPS@ryzen>
 <a5fe5447-a648-4e50-aa3f-841bb87614ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5fe5447-a648-4e50-aa3f-841bb87614ec@kernel.org>

On Fri, Jan 02, 2026 at 09:47:57AM +0900, Damien Le Moal wrote:
> On 12/31/25 20:17, Niklas Cassel wrote:
> 
> You are kind of proving my point here: I feel that is all much more complicated
> than using the libata internal deferred qc work. Also, involving the SCSI layer
> about non-NCQ commands deferral is kind of a layering violation as the
> non-queueable command concept does not exist in SCSI.

Personally, I think my suggestion is much less complicated, as we do not need
to think about when to clear ap->deferred_qc or when to stop the workqueue,
during the special cases like when a reset occurs, or when a NCQ command fails.
I'm a little bit worried that there are some other special cases that we might
be overlooking.

Reusing the method we already use for CDL commands would completely sidestep
these issues, as we are putting the command in the SCSI EH workqueue, which
will requeue the command for us.

I do not see it as a layering violation, as we simply wait for the queue to
drain, then let SCSI EH retry/insert the failed/deferred non-NCQ command in
the normal SCSI queue.

The non-NCQ should be the only command that is failed, but even if there was
a NCQ command that failed as well, we will retry scmd->allowed times anyway,
so the non-NCQ command should eventually be the only command that is retried.


> libata must act as a SATL and the SAT specifications are clear about what a SATL
> implementation can do for non-NCQ commands. Referring to SATA6r01:
> 
> 6.2.5 Commands the SATL queues internally
> If the translation of a SCSI command requires the SATL to send an ATA non-NCQ
> command to the ATA device while one or more ATA commands are active, then the
> SATL shall:
> a) suspend processing of that SCSI command, and:
> 	1) maintain the SCSI command in a task set;
> 	2) resume processing of that SCSI command when the ATA device returns command
> complete for all ATA commands the SATL has previously sent to the ATA device; and
> 	3) after that SCSI command completes, resume processing of other SCSI commands;
> b) return TASK SET FULL status for that SCSI command; or
> c) return BUSY status for that SCSI command.
> 
> What you are proposing does not nicely fit. This patch essentially implements
> option (a). Option (c) is the current code, which causes the issue for
> multi-queue cases (note that AHCI is not affected because it is single queue).
> And option (c) would be mostly equivalent to (b) and cause the same issue as
> that would involve a requeue too.

I think my suggestion would be a)
since by triggering EH, we wait for all commands to complete,
then resume processing of the non-NCQ command.

That said, I know that you had plans to change the processing of CDL commands
to use a workqueue instead of EH, so in the grand scheme of things, if we will
migrate to use a workqueue instead of EH for CDL, perhaps it makes sense if we
also use a workqueue for a deferred non-NCQ command.

Will we be able to use the same workqueue, or will we soon have two different
workqueues?


Kind regards,
Niklas
