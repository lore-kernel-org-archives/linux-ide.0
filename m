From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream] libata: relocate and fix post-command processing
Date: Thu, 25 Oct 2007 18:41:45 +0900
Message-ID: <472064D9.20304@gmail.com>
References: <20071025092244.GJ11853@htj.dyndns.org> <47206407.4030908@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:39681 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440AbXJYJly (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 05:41:54 -0400
Received: by rv-out-0910.google.com with SMTP id k20so423353rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 02:41:53 -0700 (PDT)
In-Reply-To: <47206407.4030908@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, andrew.m.paprocki@gmail.com, ballen@gravity.phys.uwm.edu

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some commands need post-processing after successful completion.  This
>> was done in ata_scsi_qc_complete() till now but this has the following
>> problems.
>>
>> * Post-command processing gets executed when qc is completed from EH.
>>   Some qc's are retried from EH with zero err_mask and thus triggers
>>   unnecessary/incorrect post-command processing.
>>
>> * Command post processing doesn't belong to SAT layer.
>>
>> * Link-wide revalidation was scheduled where device revalidation
>>   suffices.
>>
>> This patch moves post-command processing to success completion path of
>> ata_qc_complete() which is travelled iff the command is going to be
>> completed without passing through EH and updates post-command
>> processing such that device-specific action is used.  While at it,
>> restructure code a bit for readability.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> applied
> 
> now if only I had a way for the SAT to issue CHECK POWER MODE (used in 
> TEST UNIT READY translation), and inspect qc->err_mask before EH gets 
> its hands on it...  :)

Yeah, yeah, SAT error pass-through is coming.  :-)

-- 
tejun
