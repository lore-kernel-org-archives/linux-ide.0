From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 05/10] libata: implement new EH action ATA_EH_SPINUP
Date: Thu, 15 Jun 2006 00:02:41 +0900
Message-ID: <44902511.2040102@gmail.com>
References: <11501274283970-git-send-email-htejun@gmail.com> <448F63F3.5010909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:47023 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWFNPCt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jun 2006 11:02:49 -0400
Received: by wr-out-0506.google.com with SMTP id i7so155993wra
        for <linux-ide@vger.kernel.org>; Wed, 14 Jun 2006 08:02:48 -0700 (PDT)
In-Reply-To: <448F63F3.5010909@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: lkml@rtr.ca, axboe@suse.de, forrest.zhao@intel.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement new EH action ATA_EH_SPINUP.  This will be used by new PM
>> implementation.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> This patch further reinforces something I've been thinking about, as I 
> watch the EH grow:  these EH actions really should be separated into 
> small, discrete operations.  Then the EH "driver" will push discrete 
> operations onto an execution stack.
> 
> It's always getting tough to follow ata_eh_recover() and ata_eh_reset() 
> 's code through multiple iterations of recovery.  This patch 
> (ata_eh_spinup) also illustrates how difficult it would be if the 
> ordering of these operations ever needed to change.
> 
> So, I'm not NAK'ing the patch, just throwing out a 'caution' sign.  :)
> 
> I've often thought something along the lines of a list of tasks 
> ("eh_op_list"), for when a port is frozen and doing EH:
>     ata_eh_freeze()
>     ata_eh_push(ap, EH_OP_RESET_BUS, ...)
>     ata_eh_push(ap, EH_OP_SPINUP, ...)
>     ata_eh_push(ap, EH_OP_CONFIGURE, ...)
>     ata_eh_push(ap, EH_OP_SET_MODE, ...)
>     ata_eh_run()
>     ata_eh_thaw()
> 
> would be nice.  A discrete operation would handle its own discrete 
> operation, prepend and append other operations to eh_op_list, or 
> optionally cause the engine to fail, and return immediately.

At first, I thought many different controllers would use different EH 
drive routines, so I put all EH operations in separate functions and 
grouped them into several larger steps - currently autopsy, report, 
recover and finish.

In earlier implementation, sil24 and ahci actually had to implement 
their own drive routine calling those ops and doing private things 
in-between, but as EH implementation matures all those are handled by 
feeding proper information into the core EH.  I'm looking at other 
drivers to convert them to new EH but haven't found any driver which the 
current standard EH can't handle.  Although I haven't looked at all 
drivers yet and some of them may indeed need such specialized 
implementation.

I think it boils down to the fact that the core EH is more about ATA 
devices than it's about controllers.  Controllers vary from one another 
but ATA/ATAPI devices are the same old ATA/ATAPI devices whatever the 
controller is.  So, as long as LLD has a way to feed enough information 
to core EH about the state of the attached device && core EH's 
controller interface (freeze, thaw & resets) fits the controller to 
acceptable degree, core EH doesn't have to be different across different 
LLDs.

IMHO, it's best to keep single unified implementation until it begins to 
pick up many special cases to deal with specific LLDs.  I think we're 
still in the safe regarding that.  If we pass that point, I think we 
should start by implementing private drive routines in LLDs before 
making core EH programmable.  After several such tries, the requirements 
for programmable EH would be much clearer and we would be able to do 
much better job of implementing something which is flexible enough but 
still as simple as possible.

To sum up...

* Until now, unified EH seems good enough.  In fact, not a single driver 
needs to go further than calling ata_do_eh() w/ proper callbacks.

* I agree that it would be nice to have programmable EH, but let's do it 
when it's actually needed.  It seems that early implementation of 
complex infrastructure seldom ends up in something pleasant to look at.

Thanks.

-- 
tejun
