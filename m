Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8AE482EB
	for <linux-ide@vger.kernel.org>; Fri,  2 Jan 2026 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767316247; cv=none; b=Tl0EsItHUrlcKtjLCRWSFmX2yNp+O05XNeZRLAfD2dvcU7ut6w+TQVmNix1bBfeDcOWpG4HORBIQXwkuxrca0Evc5Sg1aG2PY3CJaA38oyek60xv2QFFwds+VmBKpoSjEJ/zcNgLxfta/EI74Y/e11Rm6iXpQyIYHqXDNHHzFGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767316247; c=relaxed/simple;
	bh=7FZ/LKWD2aFGlg+ax87FPdqvkD4gj4RdceoBGiNmJh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fc985yw7Ef/hdMOGiVNzVh4T9OpqusIKBRMCsoruT+L2yjnjlRK1hgzizl/w7KawdHMS8DAY4cu/EpmpjHXnLO0sRAQciBaAWMrGwrw3H8CkoRMGFA5sHwR4ChWszeg6EWtbBE0py+Wofde4bur/eNH7w945BCq0zd21TwSRDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HirRRe7s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HirRRe7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9CC4CEF7;
	Fri,  2 Jan 2026 01:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767316246;
	bh=7FZ/LKWD2aFGlg+ax87FPdqvkD4gj4RdceoBGiNmJh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HirRRe7sdsCPIzUAhHKTYc/Mr9JWhhUamRIOZk1UyQvy4fBzuwFpGJkqqZEY5JyZ7
	 1henXtR6Jho4FMxptezGRWMLzOEZeLH7In3ZIoJGZIOgSSvcK3aJ1oeEjBzEI3lYFY
	 MwqZM5smNX8wTKJuYRbPUxwuDsX4c80diuIu+XS7x6XriCxzZDDC2eQIICqMRsTwcc
	 DuMVzVckQIB6CcThBo6Szov6nx1YAeT/tsg3m75E7BA4QF6fuofoLdH1IeyrYchRUD
	 ext61Y2HQvKd+ryI3sO2lPurMSXp7Nfg16wtPMTCkTNVV4DuuusX8L8PVt+J9k3mFB
	 FxtKkqWkZYaLQ==
Message-ID: <0b9fb4a6-db2d-488d-a486-74c67709b3a2@kernel.org>
Date: Fri, 2 Jan 2026 10:10:44 +0900
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
 <20251220002140.148854-3-dlemoal@kernel.org> <aVULegmRVY2O-TUC@ryzen>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aVULegmRVY2O-TUC@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/25 20:39, Niklas Cassel wrote:
> On Sat, Dec 20, 2025 at 09:21:40AM +0900, Damien Le Moal wrote:
>> @@ -1702,6 +1779,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>>  	if (!ret)
>>  		return 0;
>>  
>> +	/*
>> +	 * We must defer this qc: if this is not an NCQ command, keep this qc
>> +	 * as a deferred one and wait for all on-going NCQ commands to complete
>> +	 * before issuing it with the deferred qc work.
>> +	 */
>> +	if (!ata_is_ncq(qc->tf.protocol)) {
>> +		ap->deferred_qc = qc;
>> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> 
> Here you save the qc, and you return SCSI_MLQUEUE_DEVICE_BUSY;
> SCSI_MLQUEUE_DEVICE_BUSY will cause the block layer to reinsert the request
> in the queue, so you will get the same request sent to ata_scsi_translate()
> again, even though you have save it. A little ugly IMO.

No it will not cause a requeue in this case because this change:

 	rc = ata_scsi_defer(ap, qc);
-	if (rc)
+	if (rc) {
+		if (qc == ap->deferred_qc)
+			return 0;

ensures that we return "0", thus telling the scsi and block layer that the
command/request was accepted, but we do *not* call ata_qc_issue() for that qc.
It is deferred and will be issued by the deferred qc work once the queue drains.

> It seems like you are relying on the ata_scsi_qc_new() call will give you
> the same *qc as the one you have stored...

No because we will not see that request/command again since we told the scsi
layer that we accepted it (but did not issue it yet, but the scsi layer does not
need to know that).

>>  	rc = ata_scsi_defer(ap, qc);
>> -	if (rc)
>> +	if (rc) {
>> +		if (qc == ap->deferred_qc)
>> +			return 0;
> 
> ...and then you have this code here, to do nothing in that case.

Yes, we do not issue the qc in this case. But the "return 0" tells the scsi
layer that we accepted the command, so as far as scsi is concerned, the command
was "issued".

> But, are we guaranteed that we will always get the same qc?

We will not see the same command again because we told the scsi layer we
accepted it with the above "return 0".

> Have you tried this both with and without mq-deadline?
> And on both ahci and libsas HBAs?

Yes to all.


-- 
Damien Le Moal
Western Digital Research
