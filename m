From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: imx6 eSATA
Date: Sun, 19 Jan 2014 12:27:50 +0800
Message-ID: <20140119042746.GA22423@S2101-09.ap.freescale.net>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
 <20140118190337.GK15937@n2100.arm.linux.org.uk>
 <20140118211119.GA6618@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:30516
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751860AbaASE1x (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jan 2014 23:27:53 -0500
Content-Disposition: inline
In-Reply-To: <20140118211119.GA6618@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Sat, Jan 18, 2014 at 09:11:19PM +0000, Russell King - ARM Linux wrote:
> Sigh.  You can't get rid of the of_node there because it's needed
> for clk_get() inside ahci_platform.c.  So, I think ahci_platform needs
> to become yet another library, and thereby avoid creating a child
> platform device.

Yes, you're right.  This has been discussed for a while [1].

Shawn

[1] http://thread.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/4835/focus=4909

