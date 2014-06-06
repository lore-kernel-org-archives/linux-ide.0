From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC 5/5] ahci_imx: add disable for spread-spectrum
Date: Fri, 6 Jun 2014 14:50:38 -0500
Message-ID: <CAL_JsqKmEXcO4rDELiLGZ4kJSEhmSFhJWh5XRjUfj8xNi0eFJw@mail.gmail.com>
References: <20140416084227.GD24070@n2100.arm.linux.org.uk>
	<E1WaLRa-0002yX-7L@rmk-PC.arm.linux.org.uk>
	<CAL_JsqK_BbhXs0gcn=w=1KPKOD0HZzmYx5zAaS5_z=UvQDPNjw@mail.gmail.com>
	<20140416225721.GP24070@n2100.arm.linux.org.uk>
	<20140416230226.GQ24070@n2100.arm.linux.org.uk>
	<20140606164027.GA22986@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:65237 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbaFFTuj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2014 15:50:39 -0400
In-Reply-To: <20140606164027.GA22986@n2100.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 6, 2014 at 11:40 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Apr 17, 2014 at 12:02:26AM +0100, Russell King - ARM Linux wrote:
>> On Wed, Apr 16, 2014 at 11:57:21PM +0100, Russell King - ARM Linux wrote:
>> > On Wed, Apr 16, 2014 at 05:46:47PM -0500, Rob Herring wrote:
>> > > On Wed, Apr 16, 2014 at 3:43 AM, Russell King
>> > > <rmk+kernel@arm.linux.org.uk> wrote:
>> > > > Spread-spectrum doesn't work with Cubox-i hardware, so we have to
>> > > > disable this feature.  Add a DT property so that platforms can
>> > > > indicate that this feature should not be enabled.
>> > >
>> > > This is for spread-spectrum tx or rx? Transmit SS is optional to
>> > > support, but the receiver must support SS. Otherwise random drives
>> > > won't work which makes for a good user experience. Is this really a
>> > > board quirk rather than a Si issue?
>> >
>> > No idea.  This bit controls clock generation, and one reason given to
>> > disable it is if the reference clock being supplied is already spread
>> > spectrum.  I don't think that applies here.  It doesn't say which
>> > clock(s) this is applied to - I would guess it's the transmit clock.
>> >
>> > All I know is that with SS enabled, the drive is not detected, and
>> > SolidRun's original port disables SS.  Disabling SS allows the external
>> > drive to be detected.
>> >
>> > I have no capability to check the eye pattern, so I've no idea if
>> > there's a problem with the electrical setup which stops SS from
>> > working.  All I know is with the parameters I give here (which are
>> > those which SolidRun's original port uses) and with SS disabled,
>> > it works.
>>
>> I'll correct that - it _is_ detected with SS enabled, but things go
>> awry very quickly with errors, which then result in corrupted IDENTIFY
>> responses, the link dropping back to 1.5Gbps, more errors and corruption
>> and eventually the SATA layer gives up and declares the port dead.
>
> Rob,
>
> Can I take your lack of reply on this as meaning that you don't have
> any objections against these new DT properties for this driver - if
> so, can I have your ack for these properties please?

Yes, they are okay. I'll ack the documentation once that is done.

Rob
