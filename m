From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1] ata: sata_dwc_460ex: Propagate platform device ID to
 DMA driver
Date: Mon, 13 Nov 2017 12:17:20 -0800
Message-ID: <20171113201720.GN983427@devbig577.frc2.facebook.com>
References: <20171110175937.83792-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55159 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbdKMURY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 13 Nov 2017 15:17:24 -0500
Received: by mail-qt0-f181.google.com with SMTP id c36so14980459qtc.11
        for <linux-ide@vger.kernel.org>; Mon, 13 Nov 2017 12:17:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171110175937.83792-1-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Nov 10, 2017 at 07:59:37PM +0200, Andy Shevchenko wrote:
> Propagate platform device ID to DMA driver to distinguish relationship
> between DMA and SATA instances.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.15.

Thanks.

-- 
tejun
