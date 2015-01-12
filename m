From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1] sata_dwc_460ex: disable compilation on ARM and ARM64
Date: Mon, 12 Jan 2015 08:06:28 -0500
Message-ID: <20150112130628.GW25319@htj.dyndns.org>
References: <1421067464-13725-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:36473 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959AbbALNGb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Jan 2015 08:06:31 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so17790662qcx.12
        for <linux-ide@vger.kernel.org>; Mon, 12 Jan 2015 05:06:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1421067464-13725-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, linux-ide@vger.kernel.org

On Mon, Jan 12, 2015 at 02:57:44PM +0200, Andy Shevchenko wrote:
> For now disable the compilation of the driver on ARM and ARM64. In the future
> we will fix the DMA handling in that driver and re-enable compilation back.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-3.20.

Thanks.

-- 
tejun
