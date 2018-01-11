From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: Use usleep_range() in ahci_start_port()
Date: Thu, 11 Jan 2018 10:11:17 -0800
Message-ID: <20180111181117.GL3460072@devbig577.frc2.facebook.com>
References: <20180111125551.61877-1-mika.westerberg@linux.intel.com>
 <20180111125551.61877-2-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43972 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeAKSL1 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Jan 2018 13:11:27 -0500
Received: by mail-qk0-f195.google.com with SMTP id a5so2615446qkg.10
        for <linux-ide@vger.kernel.org>; Thu, 11 Jan 2018 10:11:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180111125551.61877-2-mika.westerberg@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 11, 2018 at 03:55:51PM +0300, Mika Westerberg wrote:
> Using msleep(1) may actually sleep much longer than 1 msecs (~20 msecs)
> which unnecessarily slows down system startup. Avoid that and use
> usleep_range() instead.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Heh, I'm not sure.  How big of a problem is this?

Thanks.

-- 
tejun
