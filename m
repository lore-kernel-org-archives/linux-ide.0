From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
Date: Tue, 5 May 2015 09:49:33 -0400
Message-ID: <20150505134933.GM1971@htj.duckdns.org>
References: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36508 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946061AbbEENtg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 09:49:36 -0400
Received: by qgeb100 with SMTP id b100so81137274qge.3
        for <linux-ide@vger.kernel.org>; Tue, 05 May 2015 06:49:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Julian Margetson <runaway@candw.ms>, linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>, linux-ide@vger.kernel.org

On Tue, May 05, 2015 at 12:14:03PM +0300, Andy Shevchenko wrote:
> Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
> user can still compile it.
> 
> Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.1-fixes.

Thanks.

-- 
tejun
