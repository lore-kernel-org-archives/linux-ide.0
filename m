From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 1/1] ata: sata_mv: Convert to devm_ioremap_resource()
Date: Mon, 9 Jan 2017 07:43:41 -0500
Message-ID: <20170109124341.GA10904@mtj.duckdns.org>
References: <20170108224922.147261-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33955 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937225AbdAIMnu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jan 2017 07:43:50 -0500
Received: by mail-qk0-f193.google.com with SMTP id e1so15831979qkh.1
        for <linux-ide@vger.kernel.org>; Mon, 09 Jan 2017 04:43:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170108224922.147261-1-andriy.shevchenko@linux.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, linux-ide@vger.kernel.org

On Mon, Jan 09, 2017 at 12:49:22AM +0200, Andy Shevchenko wrote:
> Convert to devm_ioremap_resource() which provides more consistent error
> handling.
> 
> Note that devm_ioremap_resource() provides its own error messages.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
