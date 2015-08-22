From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_arasam_cf: Use devm_clk_get
Date: Sat, 22 Aug 2015 09:37:09 -0700
Message-ID: <20150822163709.GB20768@mtj.duckdns.org>
References: <20150822033450.GA11692@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33672 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795AbbHVQhN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 22 Aug 2015 12:37:13 -0400
Content-Disposition: inline
In-Reply-To: <20150822033450.GA11692@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 22, 2015 at 09:04:50AM +0530, Vaishali Thakkar wrote:
> This patch introduces the use of managed resource function
> devm_clk_get instead of clk_get and removes corresponding call
> to clk_put in the remove function.
> 
> To be compatible with the change various gotos are replaced with
> direct returns, and unneeded label is dropped.
> 
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Applied to libata/for-4.3.

Thanks.

-- 
tejun
