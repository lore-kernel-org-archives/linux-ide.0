From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 2/2] sata_dwc_460ex: re-use hsdev->dev instead of
 dwc_dev
Date: Tue, 24 Mar 2015 13:51:16 -0400
Message-ID: <20150324175116.GL3880@htj.duckdns.org>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1425415282-3750-3-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34501 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbbCXRvX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Mar 2015 13:51:23 -0400
Received: by qgep97 with SMTP id p97so750704qge.1
        for <linux-ide@vger.kernel.org>; Tue, 24 Mar 2015 10:51:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1425415282-3750-3-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

On Tue, Mar 03, 2015 at 10:41:22PM +0200, Andy Shevchenko wrote:
> This patch re-uses hsdev->dev which is allocated on heap. Therefore, the
> private structure, which is global variable, is reduced by one field.
> 
> In one case ap->dev is used and there it seems to be right decision.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied 1-2 to libata/for-4.1.

Thanks.

-- 
tejun
