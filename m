From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 11/14] libata-hp-prep: make ops->tf_read() optional
Date: Tue, 23 May 2006 09:04:18 -0700
Message-ID: <44733282.1010509@gmail.com>
References: <11480445844029-git-send-email-htejun@gmail.com> <446DE034.6030103@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:56034 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932418AbWEWVzr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 23 May 2006 17:55:47 -0400
Received: by nz-out-0102.google.com with SMTP id 8so1673597nzo
        for <linux-ide@vger.kernel.org>; Tue, 23 May 2006 14:55:47 -0700 (PDT)
In-Reply-To: <446DE034.6030103@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Not all controllers have single TF image and ops->tf_read() is
>> inappropriate for them.  Newly implemented hotplug probing will allow
>> drivers for such controllers to get rid of ops->tf_read() completely.
>> Make ops->tf_read() optional in core layer.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> NAK.
> 
> At the present time, the controller model expects to be able to obtain 
> correct values from the shadow registers.  For FIS-based controllers, 
> this may imply that the driver needs to maintain an accurate shadow 
> register image, if the chip doesn't automatically supply one.
> 
> I think this is a quite reasonable expectation, given that ATA continues 
> to have specifically defined shadow register outputs, and even in the 
> face of NCQ, we have defined states where the shadow registers are 
> available.
> 
> On this basis, attempts to make ->check_status() optional are also NAK'd.

The reasons why I did this are...

* For controllers which don't maintain shadow register image, the cached 
value gets out of sync easily and cause malfunction.  In some cases, the 
only way is to fake safe values.

* With generic TF access, LLDs cannot determine when TF will be accessed 
and why.  It must try to keep TF as up-to-date as possible.  e.g. sil24 
skips TF loading after a qc completion, this makes the cached TF go out 
of sync, which can easily cause problems depending on the previous 
cached value and how it will be used later.

* With PM, on both AHCI and sil24, each port's TF image must be 
cached/faked.  I think this would be true for many controllers.

* libata is heading toward high-level ops.  At least, that's the plan. 
With high-level qc_issue/complete interface, there's no reason for 
libata-core layer to access TF directly.

Currently, for FIS-based controllers, the only places where libata-core 
layer accesses TF are...

* waiting for !BSY.  This is often broken (cache TF gets out of sync, 
uncleared previous FIS value...)

* loading qc->result_tf when ATA_QCFLAG_RESULT_TF is set or the qc 
failed.  As noted above, I think it's best done in LLD completion routine.

I'll drop this and related patches from hotplug series, but I really 
don't want to cache/fake TFs for all ports of PM.  The cached values 
wouldn't be accurate, sometimes values will have to be faked to bypass 
TF accesses, and all those should be implemented in LLDs.

Thanks.

-- 
tejun

