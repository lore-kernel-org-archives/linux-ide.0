From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure
 handling
Date: Mon, 14 Apr 2014 13:50:37 -0400
Message-ID: <20140414175037.GA15249@htj.dyndns.org>
References: <1706948.xQXQIMFS2B@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:61044 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbaDNRul (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Apr 2014 13:50:41 -0400
Content-Disposition: inline
In-Reply-To: <1706948.xQXQIMFS2B@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>, Shiraz Hashim <shiraz.hashim@st.com>, linux-ide@vger.kernel.org, spear-devel@list.st.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Apr 14, 2014 at 06:01:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add missing cf_exit() and clk_put() calls to ata_host_activate()
> failure path.
> 
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
