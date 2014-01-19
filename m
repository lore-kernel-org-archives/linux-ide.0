From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v3 09/13] ARM: sunxi: Add support for Allwinner SUNXi
	SoCs sata to ahci_platform
Date: Sun, 19 Jan 2014 12:22:16 +0000
Message-ID: <20140119122216.GM15937@n2100.arm.linux.org.uk>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com> <1390088935-7193-10-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41706 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752299AbaASMW0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 19 Jan 2014 07:22:26 -0500
Content-Disposition: inline
In-Reply-To: <1390088935-7193-10-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-ide@vger.kernel.org, Oliver Schinagl <oliver@schinagl.nl>, Richard Zhu <Hong-Xing.Zhu@freescale.com>, linux-sunxi@googlegroups.com, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:51AM +0100, Hans de Goede wrote:
> +	timeout = 0x100000;
> +	do {
> +		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
> +	} while (--timeout && (reg_val != 0x2));
> +	if (!timeout) {
> +		dev_err(dev, "PHY power up failed.\n");
> +		return -EIO;
> +	}

This is not a good way to detect failure - there's several things wrong
here.

First, how long does sunxi_getbits() take?  What does that depend on?
Therefore, how long does it take to time out?

Secondly, what if the success condition becomes true at the same time that
a timeout occurs?

So:

	timeout = some_us_value;
	do {
		reg_val = sunxi_getbits(reg_base + AHCI_PHYCS0R, 0x7, 28);
		if (reg_val == 2)
			break;

		timeout--;
		if (timeout == 0) {
			dev_err(dev, "PHY power up failed.\n");
			return -EIO;
		}

		udelay(1);
	} while (1);

is far more predictable.  Same goes for the other loop in this function.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
