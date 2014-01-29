From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_imx: Check the return value from
 clk_prepare_enable()
Date: Wed, 29 Jan 2014 13:16:11 -0500
Message-ID: <20140129181611.GK30842@htj.dyndns.org>
References: <1390686383-13790-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:38191 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaA2SQP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Jan 2014 13:16:15 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so3330712qcx.35
        for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2014 10:16:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1390686383-13790-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Jan 25, 2014 at 07:46:23PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> clk_prepare_enable() may fail, so let's check its return value and propagate it
> in the case of error.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to libata/for-3.14-fixes.

Thanks.

-- 
tejun
