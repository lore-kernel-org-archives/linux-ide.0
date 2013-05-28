From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] Optimize R-Car SATA driver
Date: Tue, 28 May 2013 09:20:47 +0900
Message-ID: <20130528002047.GA18531@mtj.dyndns.org>
References: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55870 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758270Ab3E1AVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 20:21:00 -0400
Content-Disposition: inline
In-Reply-To: <201305280238.17867.sergei.shtylyov@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, May 28, 2013 at 02:38:17AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 3 patches against the Tejun Heo's 'libata.git' repo's
> 'for-3.11' branch.
>    They deal with some shortcomings in the R-Car SATA driver and generally
> optimize it. I've come up with them while trying to add NCQ support to this
> driver.
> 
> [1/3] sata_rcar: kill superfluous code in sata_rcar_bmdma_fill_sg()
> [2/3] sata_rcar: correct 'sata_rcar_sht'
> [3/3] sata_rcar: add 'base' local variable to some functions

Applied to libata/for-3.11.

Thanks.

-- 
tejun
