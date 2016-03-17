From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Thu, 17 Mar 2016 18:36:19 +0100
Message-ID: <31951835.kMFH9CgruZ@wuerfel>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com> <5709817.yQT8N3CaLj@wuerfel> <20160316210713.GI21104@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:57082 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030862AbcCQRgl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Mar 2016 13:36:41 -0400
In-Reply-To: <20160316210713.GI21104@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

On Wednesday 16 March 2016 14:07:13 Tejun Heo wrote:
> Hello, Arnd.
> 
> On Mon, Feb 01, 2016 at 09:14:17PM +0100, Arnd Bergmann wrote:
> >> I am not debating on your AML call recommendation, it sounds like
> >> a good idea however BIOS is already released hence its bit late to
> >> add AML methods for this. I am seeking guidance on what can be
> >> done in the given situation. I thought platform driver is one
> >> option to get this feature enabled in kernel.
> 
> > This is where we really need the ACPI maintainers to explain the
> > general policy for dealing with firmware updates.
> > 
> > I would assume that adding the feature in a later firmware version
> > is a compatible change, and the feature is non-essential (the
> > device will work fine with the generic SATA driver, except
> > the LEDs don't blink), so it's not a big deal, it's just what
> > you get for having the firmware shipped before the driver is
> > reviewed (don't do that).
> 
> So, if it were x86, I'd commit the custom driver without thinking too
> much as ata drivers have always been working around bios issues (there
> often wasn't any other recourse).  If the hardware is already out
> there and it's not too easy to roll out bios updates, from libata
> side, I'm okay with having a custom driver to work around that.  What
> do you think?


It's your call in the end. My main objection is to the fact that
I have suggested a clean implementation for the normal DT based
path that also fixes existing platforms that used to work in the
past and were broken by the (long-ago) move from drivers/ide to
drivers/ata, Brijesh has not implemented that but has instead
continued pushing the hack for the ACPI mode that is still
experimental on ARM64.

	Arnd
