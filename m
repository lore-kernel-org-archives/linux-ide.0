From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: make lba_{28,48}_ok() use ATA_MAX_SECTORS{,_LBA48}
Date: Mon, 18 Jul 2016 18:25:50 -0400
Message-ID: <20160718222550.GJ3078@mtj.duckdns.org>
References: <91a6bb6f4c04eb617a49d9a51f261b661c179de0.1468384890.git.tom.ty89@gmail.com>
 <e2abe167a66a18daa44e0fb7bf39f5a8da0f5bf0.1468530378.git.tom.ty89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34040 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbcGRWZy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2016 18:25:54 -0400
Received: by mail-pa0-f67.google.com with SMTP id hh10so39793pac.1
        for <linux-ide@vger.kernel.org>; Mon, 18 Jul 2016 15:25:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e2abe167a66a18daa44e0fb7bf39f5a8da0f5bf0.1468530378.git.tom.ty89@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tom.ty89@gmail.com
Cc: linux-ide@vger.kernel.org

On Fri, Jul 15, 2016 at 05:09:02AM +0800, tom.ty89@gmail.com wrote:
> From: Tom Yan <tom.ty89@gmail.com>
> 
> Since we set ATA_MAX_SECTORS_LBA48 to 65535 to avoid the corner case
> in some drives that commands with "count" set to 0000h (which
> reprsents 65536) does not work as expected, lba_48_ok(), which is
> used for number-of-blocks checking when libata pack commands, should
> use the same limit as well. In fact, there is no reason for the two
> functions not to use the macros anyway.
> 
> Signed-off-by: Tom Yan <tom.ty89@gmail.com>

Applied to libata/for-4.8.

Thanks.

-- 
tejun
