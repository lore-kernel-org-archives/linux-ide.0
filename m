From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: imx6 eSATA
Date: Sat, 18 Jan 2014 19:03:37 +0000
Message-ID: <20140118190337.GK15937@n2100.arm.linux.org.uk>
References: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41403 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751352AbaARTDu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 18 Jan 2014 14:03:50 -0500
Content-Disposition: inline
In-Reply-To: <20140118184427.GJ15937@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Sat, Jan 18, 2014 at 06:44:27PM +0000, Russell King - ARM Linux wrote:
> So, I see we have AHCI support for SATA on the iMX6.  Great... but it
> doesn't work on the cubox-i, because the phy settings are wrong.

And another thing.  This is wonderful... really wonderful.

static int imx_ahci_probe(struct platform_device *pdev)
{  
        struct device *dev = &pdev->dev;
...
        ahci_pdev = platform_device_alloc("ahci", -1);
...
        ahci_dev = &ahci_pdev->dev; 
...
        ahci_dev->of_node = dev->of_node;

This is a hanging offence.

Here's a lesson in how DT matching works:

- A device gets declared into the device model.
- The device is offered to each driver in turn via the bus specific
  code to see whether the driver should be bound to the device.
- If there's an of_node present, the DT IDs for the driver are walked
  to compare the device with the driver's DT IDs.  If a match is found,
  the device is passed to the driver probe function.
- If there is no of_node present, and it's a platform device, the bare
  device name is compared the driver name(s) and if it matches the
  probe function is called.

Now, what does this mean for the above monstrosity?  If the driver
model happens to find the ahci_imx driver _before_ the ahci driver
while trying to bind the ahci_dev, it will find that the ahci_dev
has an of_node with a compatible string which matches this driver.
So, imx_ahci_probe() _can_ be called with the ahci_pdev that it
just created.

It doesn't take much to understand what the result will be of that.
It will try to create another ahci device... hopefully this time
erroring out.

This is utterly disgusting.  You must *never* *ever* assign an of_node
from one device to another of the same bus type.  If you need to pass
the of_node to another device, then it _must_ be done outside of the
child device's of_node pointer - in other words, it must be done using
platform data.

Alternatively, turn ahci into a library that both the original ahci
and ahci_imx drivers can use without jumping through these kinds of
games - or in this case, just get rid of that assignment - I can't
see anything in ahci.c which needs the of_node.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
