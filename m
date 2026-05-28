Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201513382CD
	for <linux-ide@vger.kernel.org>; Thu, 28 May 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997726; cv=none; b=T4ZGeEO0DPoxLA4UTCZKscMTZY0LpQek2MqTw/L20WvSG3Qe4iNMNJ0VLtpBUTYWg0eiMwy8dcM2F8/Cn2oBpExMMDAyGGZCa2LNJZLpC13HcuJr2ptUTJbM7BxQu5D4b2PgKuyEoOZ6DhQ+PfV4paKecYo5dgKZNsJropkoE4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997726; c=relaxed/simple;
	bh=FyU2dFYLXdQ54PbkDb+FayrfzP69ThYJOfmTgD1j1fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR3gd3A5uWtHfyjSr7awngk5/5itI2jxZ6kcXN2XkHK1X3yq5qOKWujdpg5Jv/DMdM/nlVcLELFML3hsluKkFtHNDz6K81rpX8Cj9XoyYSSg6tQvf5ABHk4XJBbbii+zUg/xTqY55/QsA+Wu+vWIOEZ91lv6b22fyNzCMEqpDsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xPVpda5i; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xPVpda5i"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRH9S3vq3zlfvpG;
	Thu, 28 May 2026 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779997721; x=1782589722; bh=2ecuiHlv6oCJD6lxzH5U1U22
	wwNwWynGlTPxdg07RvQ=; b=xPVpda5iTujHQ3PWVJ4MpGnzP1NH5gD7Tv8ojEGj
	9YI8fy7DqKKBhKqCbuxS12BiyWdPFj5UyIAuGCvRelgzaeIGwXaC4h3xJtIh/ApH
	r0FLUFYIb4rltzOOXn5AAiljTSog1VRpfj+HsfqiUbHUKgrcEBRnEinFr+62nRvw
	qSOrhbS/LmprwAI6kpvhatoFwQMOAsbJ9dOYREv+uhbj/dzq11IDTL4rFCfgkv+Z
	GH3RWqUwCFdP3JOCmK60uVYR2tX33/mFWBX+BRX+ojImIgu51N2ssU8d4FK6KK1r
	OPtuN2qoEo+E8Bc9e5xjAyVpvf+jktZdP3XqktDCysG9Og==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FqHpy-tPGGa0; Thu, 28 May 2026 19:48:41 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH9N0G4nzlfl8N;
	Thu, 28 May 2026 19:48:39 +0000 (UTC)
Message-ID: <7609af7a-7861-4d47-9344-f1c2b1ce21e3@acm.org>
Date: Thu, 28 May 2026 12:48:39 -0700
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ata: libata-scsi: Remove lockdep_assert_held() in
 ata_scsi_translate()
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-ide@vger.kernel.org
References: <20260528172855.703631-5-cassel@kernel.org>
 <20260528172855.703631-6-cassel@kernel.org>
 <b4023c30-881b-4bac-9543-b14646c8d49c@acm.org> <ahiBY8mcOV2wfOEU@ryzen>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ahiBY8mcOV2wfOEU@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/28/26 10:54 AM, Niklas Cassel wrote:
> On Thu, May 28, 2026 at 10:33:30AM -0700, Bart Van Assche wrote:
>> On 5/28/26 10:28 AM, Niklas Cassel wrote:
>>> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
>>> index 6733f2b14521..8bfd3ffd8b89 100644
>>> --- a/drivers/ata/libata-scsi.c
>>> +++ b/drivers/ata/libata-scsi.c
>>> @@ -1852,8 +1852,6 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>>>    	struct ata_port *ap = dev->link->ap;
>>>    	struct ata_queued_cmd *qc;
>>> -	lockdep_assert_held(ap->lock);
>>> -
>>>    	/*
>>>    	 * ata_scsi_qc_new() calls scsi_done(cmd) in case of failure. So we
>>>    	 * have nothing further to do when allocating a qc fails.
>>
>> This patch removes a useful runtime check. I think it is better to
>> add the following annotation to ata_scsi_translate() if the goal is
>> to make the compiler check that all callers hold ap->lock:
>>
>> __must_hold(dev->link->ap->lock)
> 
> Well, this runtime check was added in 2025-12-17. We did not have it before
> then, so it is a very recent check.
> 
> As you can see in patch 2/3, I opted to add a "struct ata_port *ap" parameter
> to ata_scsi_translate() in order for the context to be provided all the way
> from the function taking the lock (e.g. ata_scsi_queuecmd()) to ata_qc_issue().
> 
> So I guess you mean __must_hold(ap->lock) in ata_scsi_translate() ?
> This series already does have that.
> 
> 
> As you know lockdep_assert_held() does a __assume_ctx_lock().
> What I don't like about this is that, if the lockdep_assert_held() is there,
> you can even remove the __must_hold(ap->lock) from from ata_scsi_translate(),
> and we will still not get a build error...
> 
> If I remove the lockdep_assert_held() and I don't have a __must_hold(ap->lock)
> annotation on ata_scsi_translate(), then I get a build error.
> 
> So I wanted to remove it such that we don't have any "fake assumptions".
> There is no need for any assumptions, since Clang will be able to verify the
> call chain all the way from ata_scsi_queuecmd() to ata_qc_issue().
> 
> (I'm kind of starting to see why you wanted to remove the __assume_ctx_lock()
> from lockdep_assert_held().)
> 
> I guess my take is that, lockdep_assert_held() is nice since it will do
> runtime checking... but if we can do context analysis without any assumption
> (uninterrupted by any __assume_ctx_lock()), then is seems like context analysis
> is better in every way.
> 
> 
> If we really want to do runtime verification, and runtime verification only,
> perhaps we can add a new macro that explicitly does not call __assume_ctx_lock().
> Something like lockdep_assert_held_no_assume_ctx_lock() :)

Please note that what I wrote is a suggestion only. If you want to 
proceed with this patch that's fine with me.

Thanks,

Bart.
