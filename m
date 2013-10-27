From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch v2] sata, highbank: clear whole array in
 highbank_initialize_phys()
Date: Sun, 27 Oct 2013 08:16:58 -0400
Message-ID: <20131027121658.GI14934@mtj.dyndns.org>
References: <20131018084409.GA14256@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:57767 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab3J0MRD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Oct 2013 08:17:03 -0400
Content-Disposition: inline
In-Reply-To: <20131018084409.GA14256@longonot.mountain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Oct 18, 2013 at 11:44:09AM +0300, Dan Carpenter wrote:
> The original code used the wrong parameter to clear tx_atten[].  It
> passed the number of elements instead of sizeof() the array to memset.
> 
> The other potential issue was that cphy_base[] wasn't cleared.  I'm not
> sure if that was a real problem or not, but I have cleared it in my
> patch.
> 
> Instead of using memset(), this patch uses empty initializers as a
> cleanup.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to libata/for-3.13.  I didn't cc stable as it doesn't look
like it caused actual problems.  Reading the code, I'm curious how
port_data[] is supposed to work.  It's a static array used throughout
the driver which is zeroed on each probe(), which doesn't make whole
lot of sense - if I connect a second sata_highbank controller in, the
struct used by the first one will be cleared.  Maybe the whole PHY
thing is supposed to be completely static, but if so, it'd be great if
the code is explicitly structured / explained that way.

Thanks.

-- 
tejun
