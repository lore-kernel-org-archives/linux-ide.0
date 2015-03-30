From: Tejun Heo <tj@kernel.org>
Subject: Re: [patch] sata_dwc_460ex: indent an if statement
Date: Mon, 30 Mar 2015 13:17:16 -0400
Message-ID: <20150330171716.GA9974@htj.duckdns.org>
References: <20150330103025.GA27144@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:36665 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbbC3RRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Mar 2015 13:17:20 -0400
Content-Disposition: inline
In-Reply-To: <20150330103025.GA27144@mwanda>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org

On Mon, Mar 30, 2015 at 01:30:25PM +0300, Dan Carpenter wrote:
> We shuffled some code around in 8b3444852a2b ('sata_dwc_460ex: move to
> generic DMA driver') an accidentally deleted a tab character here.  It
> causes a Smatch warning "if statement not indented".
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to libata/for-4.1.

Thanks.

-- 
tejun
