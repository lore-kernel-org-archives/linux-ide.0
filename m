From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 9/20] libata: reimplement LLD init_one()'s using new init
 helpers
Date: Tue, 19 Sep 2006 01:41:58 -0400
Message-ID: <450F8326.7090108@pobox.com>
References: <11559779721014-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:28319 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751339AbWISFmQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Sep 2006 01:42:16 -0400
In-Reply-To: <11559779721014-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, mlord@pobox.com, albertcc@tw.ibm.com, uchang@tw.ibm.com, forrest.zhao@intel.com, brking@us.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Reimplement LLD init_one()'s using new init helpers.  LLDs now follow
> the following init model.
> 
> 1. allocate host
> 2. acquire resources and initialize controller and host accordingly
> 3. attach host
> 
> At each step, libata provides comprehensive helpers and helps tracking
> allocated resources.
> 
> The new init model...
> 
> * allows LLD init_one()'s to be more flexible and concentrate on
>   higher-level logic
> 
> * results in code reduction in LLD init_one()'s even with more
>   comments and proper error hanlding
> 
> * makes init_one()'s of different LLDs much more consistent making
>   them easier to understand and harder to mess up
> 
> * makes init/deinit codes more easily shared with other parts by
>   using the same target data structure (host and ap)
> 
> The following bug fixes/behavior changes are introduced by this patch.
> 
> * all LLDs deallocate resources properly on init failure
> 
> * pdev_busy handling made generic.  pdc_adma, sata_sil24, sata_nv,
>   sata_qstor now deals with pdev_busy condition.
> 
> * PDC20619 (PATA) doesn't set ATA_FLAG_SATA for its lower two ports
>   and doesn't initialize scr_addr's.
> 
> * PDC20375/20575 PATA port uses pdc_pata_ops instead of pdc_sata_ops
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Unfortunately, while this patch seems correct, it is also difficult to 
review, and I'm thinking it reflects that another approach may need to 
be considered.

Usually the drivers and API are often change in small chunks, whereas 
this patchset is more along the lines of
1) add new helpers
2) update everything to use new helpers
3) delete old helpers

The previous approach was closer to
* small update to API & drivers
* small update to API & drivers
* small update to API & drivers
...

I recognize that we are changing the LLDD init model, but I bet if you 
think really hard, you could come up with a less-drastic transition path.


