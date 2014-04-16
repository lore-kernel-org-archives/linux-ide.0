From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 5/5] ahci_imx: add disable for spread-spectrum
Date: Thu, 17 Apr 2014 00:02:26 +0100
Message-ID: <20140416230226.GQ24070@n2100.arm.linux.org.uk>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk> <E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk> <CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com> <20140416225721.GP24070@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:37669 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754282AbaDPXDJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Apr 2014 19:03:09 -0400
Content-Disposition: inline
In-Reply-To: <20140416225721.GP24070@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Shawn Guo <shawn.guo@freescale.com>

On Wed, Apr 16, 2014 at 11:57:21PM +0100, Russell King - ARM Linux wrote:
> On Wed, Apr 16, 2014 at 05:46:47PM -0500, Rob Herring wrote:
> > On Wed, Apr 16, 2014 at 3:43 AM, Russell King
> > <rmk+kernel@arm.linux.org.uk> wrote:
> > > Spread-spectrum doesn't work with Cubox-i hardware, so we have to
> > > disable this feature.  Add a DT property so that platforms can
> > > indicate that this feature should not be enabled.
> > 
> > This is for spread-spectrum tx or rx? Transmit SS is optional to
> > support, but the receiver must support SS. Otherwise random drives
> > won't work which makes for a good user experience. Is this really a
> > board quirk rather than a Si issue?
> 
> No idea.  This bit controls clock generation, and one reason given to
> disable it is if the reference clock being supplied is already spread
> spectrum.  I don't think that applies here.  It doesn't say which
> clock(s) this is applied to - I would guess it's the transmit clock.
> 
> All I know is that with SS enabled, the drive is not detected, and
> SolidRun's original port disables SS.  Disabling SS allows the external
> drive to be detected.
> 
> I have no capability to check the eye pattern, so I've no idea if
> there's a problem with the electrical setup which stops SS from
> working.  All I know is with the parameters I give here (which are
> those which SolidRun's original port uses) and with SS disabled,
> it works.

I'll correct that - it _is_ detected with SS enabled, but things go
awry very quickly with errors, which then result in corrupted IDENTIFY
responses, the link dropping back to 1.5Gbps, more errors and corruption
and eventually the SATA layer gives up and declares the port dead.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
