From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH #upstream 1/2] libata: move command post processing to
 __ata_qc_complete()
Date: Sat, 13 Oct 2007 22:09:50 +0900
Message-ID: <4710C39E.7060503@gmail.com>
References: <20071012115631.GA11510@htj.dyndns.org> <470F64D7.9040604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:63799 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbXJMNJ6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Oct 2007 09:09:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1025112rvb
        for <linux-ide@vger.kernel.org>; Sat, 13 Oct 2007 06:09:58 -0700 (PDT)
In-Reply-To: <470F64D7.9040604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu, andrew@ishiboo.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Some commands need post-processing after successful completion.  This
>> was done in ata_scsi_qc_complete() till now but command post
>> processing doesn't belong to SAT layer.  Move them to
>> __ata_qc_complete() and, while at it, restructure a bit to ease adding
>> post-processing for other commands.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> BTW, while doing the TEST UNIT READY emulation patch for ATA (recently
> withdrawn from libata-dev.git#upstream), I found a problem with the
> interface that was difficult to get around:  TEST UNIT READY simulation
> code really wants to look at the result TF of CHECK POWER MODE, even if
> ATA_ERR is asserted, before determining whether or not to call that
> command an error.
> 
> Maybe the EH scheduling could be moved until after ->complete_fn, to
> permit ->complete_fn users to manipulate qc->err_mask etc.?

Yeah, right.  Device error is a special case.  In many cases, devices
can operate without any problem after asserting error and for some
commands error is used to signal certain conditions.  I think the least
intrusive way would be a qc flag - ATA_QCFLAG_ALLOW_DEVERR, maybe.
Also, I'm not sure whether EH should kick in when passthru commands fail
with a device error.  Maybe libata should just report the error to the
issuer and continue operation?

-- 
tejun
