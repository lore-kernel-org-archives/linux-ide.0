From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/5] sata_sil: new interrupt handler
Date: Tue, 30 May 2006 13:21:20 +0900
Message-ID: <447BC840.9000103@gmail.com>
References: <11488844821123-git-send-email-htejun@gmail.com> <447BC6E9.104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.195]:58517 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWE3EV2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:21:28 -0400
Received: by nz-out-0102.google.com with SMTP id s18so661171nze
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:21:28 -0700 (PDT)
In-Reply-To: <447BC6E9.104@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

>> +        if (!(bmdma2 & SIL_DMA_COMPLETE))
>> +            continue;
> 
> Is this bit asserted even on error?
> 

Yeap.

> 
>> +        sil_host_intr(ap, bmdma2);
>> +        handled = 1;
>> +    }
>> +
>> +    spin_unlock_irq(&host_set->lock);
> 
> use spin_lock() and spin_unlock()

Of course.  What was I on?  :-(

-- 
tejun
