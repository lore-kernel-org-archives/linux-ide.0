From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 1/1] libata-scsi: use %*ph to dump small buffers
Date: Mon, 9 May 2016 12:31:15 -0400
Message-ID: <20160509163115.GG7110@mtj.duckdns.org>
References: <1462560040-103475-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:35961 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcEIQbt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 May 2016 12:31:49 -0400
Received: by mail-yw0-f171.google.com with SMTP id o66so291280153ywc.3
        for <linux-ide@vger.kernel.org>; Mon, 09 May 2016 09:31:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462560040-103475-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, May 06, 2016 at 09:40:40PM +0300, Andy Shevchenko wrote:
> Replace custom approach by %*ph specifier to dump small buffers in hex format.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.7.

Thanks.

-- 
tejun
