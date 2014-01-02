From: 'Tejun Heo' <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_samsung_cf: Use devm_ioremap_resource()
Date: Thu, 2 Jan 2014 07:49:24 -0500
Message-ID: <20140102124924.GE11501@htj.dyndns.org>
References: <002901cf0793$fea8dc60$fbfa9520$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:41074 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbaABMt1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jan 2014 07:49:27 -0500
Received: by mail-qc0-f182.google.com with SMTP id e16so13451919qcx.41
        for <linux-ide@vger.kernel.org>; Thu, 02 Jan 2014 04:49:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <002901cf0793$fea8dc60$fbfa9520$%han@samsung.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-ide@vger.kernel.org

On Thu, Jan 02, 2014 at 05:24:03PM +0900, Jingoo Han wrote:
> Use devm_ioremap_resource() in order to make the code simpler,
> and remove redundant return value check of platform_get_resource()
> because the value is checked by devm_ioremap_resource().
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Applied to libata/for-3.14.

Thanks.

-- 
tejun
