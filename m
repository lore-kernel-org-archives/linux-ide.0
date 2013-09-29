From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [v1] ahci: imx: setup power saving methods
Date: Sun, 29 Sep 2013 15:35:30 +0800
Message-ID: <20130929073528.GE26156@S2101-09.ap.freescale.net>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:20264 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab3I2Hdc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Sep 2013 03:33:32 -0400
Content-Disposition: inline
In-Reply-To: <20130927131441.GA3205@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Richard Zhu <richard.zhuhongxing@gmail.com>, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Richard Zhu <r65037@freescale.com>

On Fri, Sep 27, 2013 at 09:14:41AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 27, 2013 at 04:07:45PM +0800, Richard Zhu wrote:
> > +config AHCI_IMX_PHY_POWER_DOWN_MODE
> > +	bool "Power saving mode when there is no SATA DEV detected on the port"
> > +	depends on AHCI_IMX
> > +	help
> > +	  This option enable the power down mode of the imx ahci when there is
> > +	  no sata device detected on the port, the sata port wouldn't be
> > +	  functional anymore except one system power down, and power up again.
> 
> The last part of the sentence is a bit difficult to understand.  Also,
> I'm not sure whether making this a build option is a good idea.

Agreed.  Why do not we support this unconditionally?

Shawn

