From: Bruce Allen <ballen@gravity.phys.uwm.edu>
Subject: Re: [PATCH #upstream 1/2] libata: move command post processing to
 __ata_qc_complete()
Date: Wed, 17 Oct 2007 22:55:02 -0500 (CDT)
Message-ID: <Pine.LNX.4.63.0710172253210.2168@butters.phys.uwm.edu>
References: <20071012115631.GA11510@htj.dyndns.org> <470F64D7.9040604@garzik.org>
 <4710C39E.7060503@gmail.com> <4716B579.7070005@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from butters.phys.uwm.edu ([129.89.61.125]:54191 "EHLO
	butters.phys.uwm.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbXJREv6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Oct 2007 00:51:58 -0400
In-Reply-To: <4716B579.7070005@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, andrew@ishiboo.com

>>> BTW, while doing the TEST UNIT READY emulation patch for ATA (recently
>>> withdrawn from libata-dev.git#upstream), I found a problem with the
>>> interface that was difficult to get around:  TEST UNIT READY simulation
>>> code really wants to look at the result TF of CHECK POWER MODE, even if
>>> ATA_ERR is asserted, before determining whether or not to call that
>>> command an error.
>>> 
>>> Maybe the EH scheduling could be moved until after ->complete_fn, to
>>> permit ->complete_fn users to manipulate qc->err_mask etc.?
>> 
>> Yeah, right.  Device error is a special case.  In many cases, devices
>> can operate without any problem after asserting error and for some
>> commands error is used to signal certain conditions.  I think the least
>> intrusive way would be a qc flag - ATA_QCFLAG_ALLOW_DEVERR, maybe.
>> Also, I'm not sure whether EH should kick in when passthru commands fail
>> with a device error.  Maybe libata should just report the error to the
>> issuer and continue operation?
>
> Good point and agreed -- I definitely think passthru commands want device 
> errors immediately.
>
> That vastly increases the utility of passthru to be used in test suites 
> and stuff, where you know a lot of operations should fail, by design. 
> (i.e. intentionally submitting an invalid command, to test that 'command 
> aborted' is returned)

Absolutely!  Speaking as an 'application programmer', much of the utility 
of passthru is lost if the device errors are not immediately returned to 
the caller.

Cheers,
 	Bruce




>
> 	Jeff
>
>
