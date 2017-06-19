From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_octeon_cf: make of_device_ids const.
Date: Mon, 19 Jun 2017 14:04:56 -0400
Message-ID: <20170619180456.GC12062@htj.duckdns.org>
References: <dd1977ad60634797aeb04d3785bafffa0ec53026.1497613944.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f176.google.com ([209.85.213.176]:32929 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdFSSE7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jun 2017 14:04:59 -0400
Content-Disposition: inline
In-Reply-To: <dd1977ad60634797aeb04d3785bafffa0ec53026.1497613944.git.arvind.yadav.cs@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 16, 2017 at 05:24:41PM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>     465	    696	      4	   1165	    48d	drivers/ata/pata_octeon_cf.o
> 
> File size after constify octeon_cf_match.
>    text	   data	    bss	    dec	    hex	filename
>     865	    280	      4	   1149	    47d	drivers/ata/pata_octeon_cf.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
