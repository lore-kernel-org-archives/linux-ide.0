From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] pata_imx: Use devm_ioremap_resource() to simplify
 code
Date: Tue, 18 Feb 2014 17:41:01 -0500
Message-ID: <20140218224101.GF31892@mtj.dyndns.org>
References: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:35710 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbaBRWlI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Feb 2014 17:41:08 -0500
Received: by mail-qc0-f182.google.com with SMTP id c9so26813629qcz.13
        for <linux-ide@vger.kernel.org>; Tue, 18 Feb 2014 14:41:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1392674757-1788-1-git-send-email-festevam@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-ide@vger.kernel.org, sergei.shtylyov@cogentembedded.com, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Feb 17, 2014 at 07:05:56PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using devm_ioremap_resource() can lead to code simplication, as we don't need
> to explicitily check for error returned by platform_get_resource().
> 
> Also, no need to print an error message when devm_ioremap_resource() fails,
> as the OOM code code will shout loudly on such condition.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied 1-2 to libata/for-3.15.

Thanks.

-- 
tejun
