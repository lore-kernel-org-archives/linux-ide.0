Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6021662E7
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351639; cv=none; b=A8xjadbp2Ttr+i5LnktPd4cMcC3x50bu7IsXnrE+XZtidrSPAkFzxxbfUoJiDI6It9Iwb5ct6ZoSk1aPnfeZ059IGO7WIhH7BKh/mVc7GuDhicOBtYutvHllwlkRSUu97Z4ctgKcc77LCyaZvachBM2/IiHKZsfXNq1M4vz09Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351639; c=relaxed/simple;
	bh=QSAMYeZ5dL/7SjFzTSnpnvMR04JNWruMaTqANMzY8ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OksDEPUQgoMMpB0LxNh5v+1gV0qt9wJ6cbKnZHbfpXSYAAb2tN5puMxq1KikyTcWKRo0hku+U73GVZdosrz/tUDjowD97hD/fUHXQUqxdSzQlqZ7jfvZ4VChwDQN4Q1jPqgL5bvuV0yOSnD9L3idwZfyArNH3TvNgqJikEXLAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+2sjNM7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+2sjNM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0EDC116B1;
	Fri,  2 Jan 2026 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767351639;
	bh=QSAMYeZ5dL/7SjFzTSnpnvMR04JNWruMaTqANMzY8ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B+2sjNM7vOT0P75Mu+/Ae+vWqSPEB8pENTtQWY9cVJXN09G3GxH17URIRGqcWHvKj
	 H+7yZPjRUwKuT/2MBf/1c7iDa6URFm+FPnJYrpx6bnpYH4ARZKPJKSyyinA1lXFnr1
	 9v5nrq1qj6YzVn0J8Y1KRX9vhax55aN8osIWixMCQf32NAk2fKZg5wD8r/T00svdBi
	 f1r46ApCVnrMl/X21p3RVMANqijnUL1pIcfTGeSbibRTPaFvNSkoMIVHKd2U86TN1b
	 ZjkRYjM+H2G1+af9SbtOHdXeSoBG1Dsxg4U9qE7XrbMf1UQhHfUtKJVI0igNgF75Kq
	 JkfwnWhfvjZlw==
Message-ID: <89d7fc80-4a84-467f-89c5-4e10960a4218@kernel.org>
Date: Fri, 2 Jan 2026 20:00:37 +0900
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
 <a5fe5447-a648-4e50-aa3f-841bb87614ec@kernel.org> <aVec55qIL_U03pai@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aVec55qIL_U03pai@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/26 19:24, Niklas Cassel wrote:
> On Fri, Jan 02, 2026 at 09:47:57AM +0900, Damien Le Moal wrote:
>> On 12/31/25 20:17, Niklas Cassel wrote:
>>
>> You are kind of proving my point here: I feel that is all much more complicated
>> than using the libata internal deferred qc work. Also, involving the SCSI layer
>> about non-NCQ commands deferral is kind of a layering violation as the
>> non-queueable command concept does not exist in SCSI.
> 
> Personally, I think my suggestion is much less complicated, as we do not need
> to think about when to clear ap->deferred_qc or when to stop the workqueue,
> during the special cases like when a reset occurs, or when a NCQ command fails.
> I'm a little bit worried that there are some other special cases that we might
> be overlooking.
> 
> Reusing the method we already use for CDL commands would completely sidestep
> these issues, as we are putting the command in the SCSI EH workqueue, which
> will requeue the command for us.
> 
> I do not see it as a layering violation, as we simply wait for the queue to
> drain, then let SCSI EH retry/insert the failed/deferred non-NCQ command in
> the normal SCSI queue.
> 
> The non-NCQ should be the only command that is failed, but even if there was
> a NCQ command that failed as well, we will retry scmd->allowed times anyway,
> so the non-NCQ command should eventually be the only command that is retried.
> 
> 
>> libata must act as a SATL and the SAT specifications are clear about what a SATL
>> implementation can do for non-NCQ commands. Referring to SATA6r01:
>>
>> 6.2.5 Commands the SATL queues internally
>> If the translation of a SCSI command requires the SATL to send an ATA non-NCQ
>> command to the ATA device while one or more ATA commands are active, then the
>> SATL shall:
>> a) suspend processing of that SCSI command, and:
>> 	1) maintain the SCSI command in a task set;
>> 	2) resume processing of that SCSI command when the ATA device returns command
>> complete for all ATA commands the SATL has previously sent to the ATA device; and
>> 	3) after that SCSI command completes, resume processing of other SCSI commands;
>> b) return TASK SET FULL status for that SCSI command; or
>> c) return BUSY status for that SCSI command.
>>
>> What you are proposing does not nicely fit. This patch essentially implements
>> option (a). Option (c) is the current code, which causes the issue for
>> multi-queue cases (note that AHCI is not affected because it is single queue).
>> And option (c) would be mostly equivalent to (b) and cause the same issue as
>> that would involve a requeue too.
> 
> I think my suggestion would be a)
> since by triggering EH, we wait for all commands to complete,
> then resume processing of the non-NCQ command.
> 
> That said, I know that you had plans to change the processing of CDL commands
> to use a workqueue instead of EH, so in the grand scheme of things, if we will
> migrate to use a workqueue instead of EH for CDL, perhaps it makes sense if we
> also use a workqueue for a deferred non-NCQ command.
> 
> Will we be able to use the same workqueue, or will we soon have two different
> workqueues?

I can try reusing. Let's see how that looks.



-- 
Damien Le Moal
Western Digital Research
