From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] ata: add AMD Seattle platform driver
Date: Thu, 7 Jan 2016 16:56:28 -0600
Message-ID: <20160107225628.GA4213@rob-hp-laptop>
References: <1452200002-31590-1-git-send-email-brijesh.singh@amd.com>
 <4652600.rUhSEOUPkl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58731 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752721AbcAGW4d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Jan 2016 17:56:33 -0500
Content-Disposition: inline
In-Reply-To: <4652600.rUhSEOUPkl@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-ide@vger.kernel.org, galak@codeaurora.org, tj@kernel.org

On Thu, Jan 07, 2016 at 10:25:38PM +0100, Arnd Bergmann wrote:
> On Thursday 07 January 2016 14:53:22 Brijesh Singh wrote:
> > AMD Seattle SATA controller mostly conforms to AHCI interface with some
> > special register to control SGPIO interface. In the case of an AHCI
> > controller, the SGPIO feature is ideally implemented using the
> > "Enclosure Management" register of the AHCI controller, but those
> > registeres are not implemented in the Seattle SoC. Instead SoC
> > (Rev B0 onwards) provides a 32-bit SGPIO control register which should
> > be programmed to control the activity, locate and fault LEDs.

> > +Examples:
> > +        sata0@e0300000 {
> > +		compatible = "amd,seattle-ahci";
> > +		reg = <0x0 0xe0300000 0x0 0xf0000>, <0x0 0xe0000078 0x0 0x1>;
> 
> Looking at the register values, I doubt that the SGPIO is actually part of the
> sata device. More likely, you are pointing in the middle of an actual
> GPIO controller.

SGPIO is really a poor name as it has little to do with GPIO. It's a 
serial protocol to set LED states. Still, I agree this should probably 
be a separate node with perhaps a phandle to syscon.
 
> If so, please implement a GPIO driver for that device, and use the gpio-leds
> driver to drive the LEDs. IIRC there is already a generic way to communicate
> with the LEDs interface from libata, if not you can implement that in order
> to keep the special case out of the platform driver.

There is kernel support for activity LEDs, but the others you want to 
control with ledmon/ledctl utilities rather than LED subsystem. Those 
utilities use an enclosure management sysfs file IIRC. There's no 
kernel support for SGPIO outside of the AHCI enclosure management 
register (at least there wasn't 2 years ago when I last looked). 

Rob
