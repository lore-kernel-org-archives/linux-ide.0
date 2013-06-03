From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] sata_rcar: fix compilation warning in sata_rcar_thaw()
Date: Mon, 3 Jun 2013 13:17:13 -0700
Message-ID: <20130603201713.GA29989@mtj.dyndns.org>
References: <201306032219.59210.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qe0-f46.google.com ([209.85.128.46]:55860 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676Ab3FCURS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jun 2013 16:17:18 -0400
Received: by mail-qe0-f46.google.com with SMTP id w7so1873949qeb.33
        for <linux-ide@vger.kernel.org>; Mon, 03 Jun 2013 13:17:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201306032219.59210.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jun 03, 2013 at 10:19:58PM +0400, Sergei Shtylyov wrote:
> When compiling the driver with gcc 4.8, it gives the following warning:
> 
> drivers/ata/sata_rcar.c: In function `sata_rcar_thaw':
> drivers/ata/sata_rcar.c:183:2: warning: large integer implicitly truncated to
> unsigned type [-Woverflow]
> 
> Fix the warning by explicit cast of the 'unsigned long' value to 'u32'.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied to libata/for-3.11.  Thanks.

-- 
tejun
