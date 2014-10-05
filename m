From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_imx: Use the SIMPLE_DEV_PM_OPS() macro
Date: Sat, 4 Oct 2014 22:11:11 -0400
Message-ID: <20141005021111.GA8549@htj.dyndns.org>
References: <1412424186-4296-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:34953 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbaJECLO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2014 22:11:14 -0400
Received: by mail-qc0-f176.google.com with SMTP id r5so2657822qcx.35
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2014 19:11:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1412424186-4296-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-ide@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Sat, Oct 04, 2014 at 09:03:06AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using the SIMPLE_DEV_PM_OPS() macro can make the code shorter and cleaner.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to libata/for-3.18.  Care to convert other drivers too?

Thanks.

-- 
tejun
