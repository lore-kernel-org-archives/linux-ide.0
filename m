From: Tejun Heo <tj@kernel.org>
Subject: Re: [v4] ahci: imx: setup power saving methods
Date: Tue, 15 Oct 2013 08:47:50 -0400
Message-ID: <20131015124750.GB3141@htj.dyndns.org>
References: <1381805094-14723-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1381805094-14723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:45425 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758274Ab3JOMr5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Oct 2013 08:47:57 -0400
Received: by mail-qc0-f176.google.com with SMTP id t7so5953462qcv.35
        for <linux-ide@vger.kernel.org>; Tue, 15 Oct 2013 05:47:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381805094-14723-2-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Zhu <richard.zhuhongxing@gmail.com>
Cc: shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Tue, Oct 15, 2013 at 10:44:54AM +0800, Richard Zhu wrote:
> From: Richard Zhu <r65037@freescale.com>
> 
> In order to save power consumption amap.
> * Disable sata phy internal pll reference clock when
> sysetem enter into suspend mode, enable it after resume.
> * Setup module parameter used to enable imx ahci test power down
> mode(PDDQ) or not, when there is no device detected on the port
> * minor modifications:
>   - The format of the copyright is changed, because that the
>   original one can't pass fsl internal patch reivew without
>   the character '(c)'.
>   - exports ahci_platform_ops and ahci_error_handler
> 
> NOTE:
> - The hot-plug can't be supported when PDDQ mode is
> ever enabled.
> - module parameter usage how-to:
>   * default: enable PDDQ mode when no device detected.
>   * add "ahci-imx.hotplug=1" into kernel command line if
>   your don't want to enable PDDQ mode when no device
>   detected on the port.
> 
> Signed-off-by: Richard Zhu <r65037@freescale.com>

Applied to libata/for-3.13 with minor modifications.

Thanks.

-- 
tejun
