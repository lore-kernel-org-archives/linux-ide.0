Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24068C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 18 Mar 2022 14:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiCROSk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiCROSj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Mar 2022 10:18:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C42BFD61
        for <linux-ide@vger.kernel.org>; Fri, 18 Mar 2022 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647613041; x=1679149041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y38NJg+ltJ0kvX+ObymjDv3Kuiwb41besmBS6FjiiDk=;
  b=G949Gsr2lB4TABDv6kGCSnbRVHRQZFrFBXL1zXG1f//ososlwZ2mCNiR
   QhcF8Gw4SvW1BWI33TBEVMoch8k9uj63HeNFZxtzHOzcAAb6J+OqhQzzO
   hwBev/DbwAs625qzn4/uxUOWy8TpganJg6QtIZevihOz7x4ElpUrH7tz1
   rSuGtNnnkCw23cBnW695z6so8Rbq1aG9zMaYuaWbtrYmoTA8fPvVG8BtP
   G5QstC1WTrQgPDWivn+/DJeCZeoIPpfJAu2SNo+VSn5Go01Z/VKpSD/xH
   4N/0lRSVec1363pkX9gUCZg07jMmBFNPbixdbACbgaUOmi2MOfjPP9i/4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257092311"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="257092311"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:17:20 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="581722062"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 07:17:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVDPE-002Geb-9H;
        Fri, 18 Mar 2022 16:16:40 +0200
Date:   Fri, 18 Mar 2022 16:16:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 1/2] ata: sata_dwc_460ex: Fix crash due to OOB write
Message-ID: <YjSUSJV2FZy1yjN3@smile.fi.intel.com>
References: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba068938e629eb1a8b423a54405233e685cedb78.1647594132.git.chunkeey@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Fri, Mar 18, 2022 at 10:03:11AM +0100, Christian Lamparter wrote:
> the driver uses libata's "tag" values from in various arrays.
> Since the mentioned patch bumped the ATA_TAG_INTERNAL to 32,
> the value of the SATA_DWC_QCMD_MAX needs to be bumped to 33.
> 
> Otherwise ATA_TAG_INTERNAL cause a crash like this:
> 
> | BUG: Kernel NULL pointer dereference at 0x00000000
> | Faulting instruction address: 0xc03ed4b8
> | Oops: Kernel access of bad area, sig: 11 [#1]
> | BE PAGE_SIZE=4K PowerPC 44x Platform
> | CPU: 0 PID: 362 Comm: scsi_eh_1 Not tainted 5.4.163 #0
> | NIP:  c03ed4b8 LR: c03d27e8 CTR: c03ed36c
> | REGS: cfa59950 TRAP: 0300   Not tainted  (5.4.163)
> | MSR:  00021000 <CE,ME>  CR: 42000222  XER: 00000000
> | DEAR: 00000000 ESR: 00000000
> | GPR00: c03d27e8 cfa59a08 cfa55fe0 00000000 0fa46bc0 [...]
> | [..]
> | NIP [c03ed4b8] sata_dwc_qc_issue+0x14c/0x254
> | LR [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | Call Trace:
> | [cfa59a08] [c003f4e0] __cancel_work_timer+0x124/0x194 (unreliable)
> | [cfa59a78] [c03d27e8] ata_qc_issue+0x1c8/0x2dc
> | [cfa59a98] [c03d2b3c] ata_exec_internal_sg+0x240/0x524
> | [cfa59b08] [c03d2e98] ata_exec_internal+0x78/0xe0
> | [cfa59b58] [c03d30fc] ata_read_log_page.part.38+0x1dc/0x204
> | [cfa59bc8] [c03d324c] ata_identify_page_supported+0x68/0x130
> | [...]
> 
> this is because sata_dwc_dma_xfer_complete() NULLs the
> dma_pending's next neighbour "chan" (a *dma_chan struct) in
> this '32' case right here (line ~735):
> > hsdevp->dma_pending[tag] = SATA_DWC_DMA_PENDING_NONE;
> 
> Then the next time, a dma gets issued; dma_dwc_xfer_setup() passes
> the NULL'd hsdevp->chan to the dmaengine_slave_config() which then
> causes the crash.

...

> ticerex said when I've asked him about his real name+email for the patches:
> "Please use my forum nick."
> <https://forum.openwrt.org/t/my-book-live-duo-reboot-loop/122464/14>
> (I know checkpatch.pl complains about that. But what can you do?)

I think Reported-by: is fine to have any kind of reference to the reporter.
I can consider it false positive.

...

> -#define SATA_DWC_QCMD_MAX	32
> +#define SATA_DWC_QCMD_MAX	33

Can't we use 

#define SATA_DWC_QCMD_MAX	(ATA_TAG_INTERNAL + 1)

instead?

-- 
With Best Regards,
Andy Shevchenko


