Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865422D1F40
	for <linux-ide@vger.kernel.org>; Fri,  6 Mar 2026 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757157; cv=none; b=u9Z7EMfCUAcHfVCiEwCduUEGvIKGqdnZFniuoOD4WIefj/qakKraAsCpZOzG0V1uubbV9Cn+UG2NoZxPFxhVnPTlEwwZ+ND1Zm/wE5nYHwo+rRn6MbVAjzC73vFphXbl1SX4xoc4Uhw7D9DcP4PO/tSdCi/ctK6tlZMGU8qRib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757157; c=relaxed/simple;
	bh=t7w7ZjQibREQipRpAMngGX4DEONn0hqygBivTiKGog0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foYRGW9ocu+jrDiZu8GeTXiBZqGAsWSStEwclRrfZ5Rve+By/92+2TN2VVi/C5aP5hUd9tLyDo2Zbrb1iqiSuXUn20h/2MG+KEMVSgSHFNjBNv8btupUFjbllv4vlhjnoKhKr8g2hAE1eOPBiV9HChZ97BXGX27nmwoDkyfkU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKCOoiXO; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKCOoiXO"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be06c02f66so1265706eec.1
        for <linux-ide@vger.kernel.org>; Thu, 05 Mar 2026 16:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772757155; x=1773361955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VH8PYyGV0MKElcM6lht9fN4+tHPo3dJBkWwrVATehdU=;
        b=nKCOoiXOxsgnYXA75qqzlxRCW4SbV51P08ZaWrN/cz3Kl6SSvl8DBU/Nj1p/GMWr82
         n+8ulle8vH65aqV8iwUeipfE0xusqk3r6X3GEHlVz0bl7/aGh2D9dG5mliVAZWIE72kq
         F9bIsKgV0VZK8Q+ZVp0G/Ko+/w++yCg/25hc5Of+G7bRi3AD86Qe0/vZ2PIG24hQ419l
         rJNOzzHtpODXQSDRMDStbjdbxzHO+QqxTDuoJN5fKg18CX/PVSQn9PpIRwC3JlU7fsQt
         EkXbTeGgMwacZ39q0gKA3WSrtE2pK6QPTCoi3Q6VHC9Va5ydS2LuZjno5xMIsExBPnfE
         ibMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772757155; x=1773361955;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH8PYyGV0MKElcM6lht9fN4+tHPo3dJBkWwrVATehdU=;
        b=FSGD8bY0Epwh6y5oBpTAwY0Ux/pBMyfqzqi1tKOr/VQqRvggfjGp/UOo0UH8XFC7Ap
         HU3Dxu9Po3E68AWvp6wnJTzPmczNfiRZzHwCj+4nSUB34h6GXjUwpmauoKU9v+UH+2EM
         JuLQ1MaD2jZ8z3zabeZ7S3czgsw+bj8E980bYe64m+91/xE0k0TBL111Xt7cqgdaM5bL
         j2L82Sw0HoX3nX0PH8d/VpBZXFYLcyCs5WkZdes8Y+qIPd22Fqf4ibOXOwHS6fFWI80J
         zv11X1PxDu1KFS2HnDOBv5l7X3UNWCVeeyMCHUPWa1jZ3bemT61n79bXNaB5/79zD90b
         s8aQ==
X-Gm-Message-State: AOJu0Yz5EztdCyamRe6R+M7hXgcVVm8OBWhKvrnBrA8WL9nKhn7CuQ3I
	WYj5xzGJSa/70mn1u9qxQ6fPU4m/K1TBnicEErlBJO0Wop+5Mkz5d7vJgU2Y6GbI
X-Gm-Gg: ATEYQzwqic8VzcUcqpEmfPrTQUrjaOMJQpaMYWxavk8Nbf/ZCUuCc/lzFlAwzDe+mdQ
	Mh16NSiINBkOFK6nKzzdk2/2b8KxfADeG+U8jfjVOxeXSGOb8bOwxffPsdHKQD1wKyIUaKE9HDg
	jJ6MtaqJToNgs2yB/1LviOG+O+68o1Rh+WOMFv+QhbyIVQN/L7W9jAcxlnu1qc5CvHFY0XH4grT
	bAsJ5xkl2JBv6T+B8xEHf1046fF6b1SxnqxfzsK4OcdhWbRZPO3J6APnix4pXiKdPUZm61glYCv
	qsDEBk89/dY1rPhUkh6S/aMS8o31DL0gmOPOVcb6r7npID1/9ZL0AZgLsDjAJnZpEHkX7zHGRrM
	2mcD5uE2ZXmf+YkbeerAmbQ8V3DOKk3R2YKIjcSYPxefPLcrLnDuFrvjohWsIwriAOp2roo97wl
	9rzF6FPfUPY+zlWqXO7M/5m80a1EhMjD2EtldfNlxfIHZJbVxzdIHTcQtIyu0TuGDNnWXugyxI
X-Received: by 2002:a05:7300:ed0b:b0:2bd:d04c:a430 with SMTP id 5a478bee46e88-2be4dfdd7ccmr171317eec.12.1772757154467;
        Thu, 05 Mar 2026 16:32:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be0cc8517dsm10864447eec.30.2026.03.05.16.32.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 16:32:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <68df8235-dc05-41e2-afdd-42f7143e26ec@roeck-us.net>
Date: Thu, 5 Mar 2026 16:32:32 -0800
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-eh: correctly handle deferred qc
 timeouts
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20260220221439.533771-1-dlemoal@kernel.org>
 <20260220221439.533771-2-dlemoal@kernel.org>
 <ea6cdec5-cbd6-4387-9995-cbbfda978155@roeck-us.net>
 <8011c682-7fc6-4cab-b142-d05fd3b09de0@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <8011c682-7fc6-4cab-b142-d05fd3b09de0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 15:59, Damien Le Moal wrote:
> On 3/6/26 02:59, Guenter Roeck wrote:
>> Hi,
>>
>> On Sat, Feb 21, 2026 at 07:14:38AM +0900, Damien Le Moal wrote:
>>> A deferred qc may timeout while waiting for the device queue to drain
>>> to be submitted. In such case, since the qc is not active,
>>> ata_scsi_cmd_error_handler() ends up calling scsi_eh_finish_cmd(),
>>> which frees the qc. But as the port deferred_qc field still references
>>> this finished/freed qc, the deferred qc work may eventually attempt to
>>> call ata_qc_issue() against this invalid qc, leading to errors such as
>>> reported by UBSAN (syzbot run):
>>>
>>> UBSAN: shift-out-of-bounds in drivers/ata/libata-core.c:5166:24
>>> shift exponent 4210818301 is too large for 64-bit type 'long long unsigned int'
>>> ...
>>> Call Trace:
>>>   <TASK>
>>>   __dump_stack lib/dump_stack.c:94 [inline]
>>>   dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>>>   ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>>>   __ubsan_handle_shift_out_of_bounds+0x279/0x2a0 lib/ubsan.c:494
>>>   ata_qc_issue.cold+0x38/0x9f drivers/ata/libata-core.c:5166
>>>   ata_scsi_deferred_qc_work+0x154/0x1f0 drivers/ata/libata-scsi.c:1679
>>>   process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
>>>   process_scheduled_works kernel/workqueue.c:3358 [inline]
>>>   worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
>>>   kthread+0x370/0x450 kernel/kthread.c:467
>>>   ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>   </TASK>
>>>
>>> Fix this by checking if the qc of a timed out SCSI command is a deferred
>>> one, and in such case, clear the port deferred_qc field and finish the
>>> SCSI command with DID_TIME_OUT.
>>>
>>> Reported-by: syzbot+1f77b8ca15336fff21ff@syzkaller.appspotmail.com
>>> Fixes: 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Igor Pylypiv <ipylypiv@google.com>
>>> ---
>>>   drivers/ata/libata-eh.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
>>> index 72a22b6c9682..b373cceb95d2 100644
>>> --- a/drivers/ata/libata-eh.c
>>> +++ b/drivers/ata/libata-eh.c
>>> @@ -640,12 +640,28 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
>>>   		set_host_byte(scmd, DID_OK);
>>>   
>>>   		ata_qc_for_each_raw(ap, qc, i) {
>>> -			if (qc->flags & ATA_QCFLAG_ACTIVE &&
>>> -			    qc->scsicmd == scmd)
>>> +			if (qc->scsicmd != scmd)
>>> +				continue;
>>> +			if ((qc->flags & ATA_QCFLAG_ACTIVE) ||
>>> +			    qc == ap->deferred_qc)
>>>   				break;
>>>   		}
>>>   
>>> -		if (i < ATA_MAX_QUEUE) {
>>> +		if (qc == ap->deferred_qc) {
>>
>> An experimental AI code review agent tagged this patch with the following
>> comment.
> 
> Thanks for that.
> 
>>    If the `ata_qc_for_each_raw()` loop finishes without finding a matching `scmd`,
>>    `qc` will hold a pointer to the last element examined (`i == ATA_MAX_QUEUE`).
>>    If this last element happens to be `ap->deferred_qc`, the condition
>>    `qc == ap->deferred_qc` evaluates to true despite the loop not breaking on a
>>    match.
>>
>>    Could this mistakenly intercept a command that completed normally after a SCSI
>>    timeout, returning a timeout error instead of success? Would this also
>>    incorrectly clear `ap->deferred_qc`, dropping the deferred command?
>>    Should we verify that the loop actually found a match, for instance by checking
>>    `if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc)`?
> 
> Yeah. Something like this. But that condition cannot actually happen. i ==
> ATA_MAX_QUEUE correspond to internal QCs, and these never go through the
> deferred path.
> 

Pardon my ignorance, but doesn't i == ATA_MAX_QUEUE mean that qc points
to the _previously_ examined qc, i.e., the one associated with i ==
ATA_MAX_QUEUE - 1 ? Are you saying that this qc will always always be
internal and never match ap->deferred_qc ?

>> It does seem to be a real problem to me, but I don't know the code well
>> enough to be sure. Please take a look and let me know if the problem is
>> real. If so, I'll be happy to submit a patch to fix it. If not, please let
>> me know what the agent is missing.
> 
> See above. That is not a real problem, but it would still be good to check. I
> think your change is fine. Car to send a proper patch ?
> 

I can try, but if the AI analysis is missing the point I don't really know
how to describe/explain it. Can you give me some guidance ?

Thanks,
Guenter

