From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] ahci: imx: use macros to define registers and bits
Date: Tue, 15 Apr 2014 12:03:17 -0400
Message-ID: <20140415160317.GM1863@htj.dyndns.org>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:42778 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbaDOQDX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 12:03:23 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so9828994qaq.29
        for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2014 09:03:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> Comparing to enums, macros are more conventional to be used for
> registers and bits definition.  Let's switch to macros.
> 
> While at it, the names of the registers and bit-fields are updated to
> have proper namespace prefix and match the hardware reference manual.
> 
> No functional change is involved.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Please don't switch to defines.  A lot of libata constants use enums
and they tend to have more advantages anyway.

Thanks.

-- 
tejun
