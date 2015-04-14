From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] Remove celleb-only SCC PATA drivers
Date: Tue, 14 Apr 2015 13:10:06 -0400
Message-ID: <20150414171006.GA30337@htj.duckdns.org>
References: <1428989006-5929-1-git-send-email-dja@axtens.net>
 <1428989006-5929-2-git-send-email-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35152 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932964AbbDNRKb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2015 13:10:31 -0400
Content-Disposition: inline
In-Reply-To: <1428989006-5929-2-git-send-email-dja@axtens.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Axtens <dja@axtens.net>
Cc: linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, Valentin Rothberg <valentinrothberg@gmail.com>, mpe@ellerman.id.au, linuxppc-dev@lists.ozlab.org

On Tue, Apr 14, 2015 at 03:23:25PM +1000, Daniel Axtens wrote:
> The SCC PATA interface is only used by celleb.
> celleb has been dropped [1], so drop the drivers.
> 
> [1] http://patchwork.ozlabs.org/patch/451730/
> 
> CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> CC: Tejun Heo <tj@kernel.org>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: linux-ide@vger.kernel.org
> CC: Valentin Rothberg <valentinrothberg@gmail.com>
> CC: mpe@ellerman.id.au
> CC: linuxppc-dev@lists.ozlab.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to libata/for-4.1-fixes w/ Dave's permission.  Will push out
in a week or so.

Thanks.

-- 
tejun
