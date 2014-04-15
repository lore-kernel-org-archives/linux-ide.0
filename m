From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] pata_samsung_cf: fix ata_host_activate() failure handling
Date: Tue, 15 Apr 2014 08:49:36 -0400
Message-ID: <20140415124936.GF1863@htj.dyndns.org>
References: <6050762.sdUI3gZZlK@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:64418 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbaDOMtl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Apr 2014 08:49:41 -0400
Content-Disposition: inline
In-Reply-To: <6050762.sdUI3gZZlK@amdc1032>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-ide@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Mon, Mar 31, 2014 at 07:52:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add missing clk_disable() call to ata_host_activate() failure path.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
