From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 5/5] ahci_imx: add disable for spread-spectrum
Date: Tue, 17 Jun 2014 10:47:05 +0100
Message-ID: <20140617094705.GD23430@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk> <E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk> <CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com> <20140416225721.GP24070@n2100.arm.linux.org.uk> <20140416230226.GQ24070@n2100.arm.linux.org.uk> <20140606164027.GA22986@n2100.arm.linux.org.uk> <CAL_JsqKmEXcO4rDELiLGZ4kJSEhmSFhJWh5XRjUfj8xNi0eFJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:60271 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751147AbaFQJrP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jun 2014 05:47:15 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKmEXcO4rDELiLGZ4kJSEhmSFhJWh5XRjUfj8xNi0eFJw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 06, 2014 at 02:50:38PM -0500, Rob Herring wrote:
> Yes, they are okay. I'll ack the documentation once that is done.

When someone documents the existing implmentation, then I'll add to
it - I've not really looked into what the differences are between
the compatible strings, so that's something I can't document.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
