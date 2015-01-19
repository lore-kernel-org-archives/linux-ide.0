From: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] libata: prevent HSM state change race between ISR and
 PIO
Date: Mon, 19 Jan 2015 12:03:23 -0600
Message-ID: <54BD46EB.5080207@redhat.com>
References: <1421684851-14561-1-git-send-email-dmilburn@redhat.com> <20150119174141.GB10570@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbbASSEt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Jan 2015 13:04:49 -0500
In-Reply-To: <20150119174141.GB10570@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

On 01/19/2015 11:41 AM, Tejun Heo wrote:
> On Mon, Jan 19, 2015 at 10:27:31AM -0600, David Milburn wrote:
>>   void ata_sff_flush_pio_task(struct ata_port *ap)
>>   {
>> +	struct Scsi_Host *host = ap->scsi_host;
>> +	unsigned long flags;
>> +
>>   	DPRINTK("ENTER\n");
>>
>>   	cancel_delayed_work_sync(&ap->sff_pio_task);
>> +
>> +	/* prevent racing with ISR's use of ap->hsm_task_state */
>
> Can we have a more descriptive comment please?  lock, assign, unlock
> sequence is pretty unusual, so let's give the full explanation here.
>

Ok, will do.

Thanks,
David

