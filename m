From: Moritz Heiber <moe@lunar-linux.org>
Subject: Re: Issues with AHCI and SATAII using JMD360
Date: Sun, 7 May 2006 17:02:15 +0200
Message-ID: <20060507170215.b865bdb3.moe@lunar-linux.org>
References: <20060507043702.052e3f56.moritz-heiber@arcor.de>
	<445DE490.4010005@vip.cybercity.dk>
Reply-To: Moritz Heiber <moe@lunar-linux.org>, linux-ide@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:51432 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932170AbWEGPCR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 May 2006 11:02:17 -0400
In-Reply-To: <445DE490.4010005@vip.cybercity.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mogensv@vip.cybercity.dk
Cc: linux-ide@vger.kernel.org

On Sun, 07 May 2006 14:14:08 +0200
Mogens Valentin <mogensv@vip.cybercity.dk> wrote:

> You could try the config with MS, where AFAIK, it does SATA300 mode.
> You could try skimming forums on ocworkbench.com for info, as this is 
> kindof an asian homeforum, with JCM360 being designed by .tw Jmicron.

No Windows on this computer or anywhere nearby. Besides, I would need
to buy it beforehand ;-)

> Whatever, it may or may not be worth too much trouble. I'm thinking 
> JCM360 may have an unclear future, since AFAIK the later ULi chipsets 
> have native SATA 300 support, and nVidia bought ULi, perhaps to
> produce entry level chipsets (according to press).
> I was very interested in that same board, due to very good test
> results and features, but skipped it for the very JCM360 driver issue.
> Being a dirt cheap board, you could spend on a separate selected SATA 
> interface (to keep for the next board). The mobo certainly has enough 
> PCIx slots for that.

As I just wrote to the mailinglist, the Hitachi disk utilities did the
trick as Hitachi is actually enforcing the 1.5Gbps on the user which
is totally understandable and even a pretty good default given the
technical knowledge of most computer users.
 
> What's you overall experience with the board, WRT
> stability/performance?

I'm very pleased with it actually. All parts of the motherboard are
well supported under Linux. Sound, ethernet, chipset .. you name it.

The only issue I encountered which I wasn't able to fix out of pure
laziness and the availability of an 'easy way out' would be the sound.
Whenever I put a quasi-high load on the ethernet controller (6Mbps or
more) the onboard soundchip would crumble and stop the work. I could
reproduce it even .. without pointers to a possible solution though.

Anyway, I "fixed" that by using my old Zoltrix Nightingale PCI card
(cmipci chip .. pretty good value card .. better than Creative's) and
disabled the onboard sound. I'm sure the issue can be resolved .. if
you were to look into it more thoroughly of course.

Regards,

Moritz

PS: As I just recalled .. I wasn't able to get the sensor chip working
or even gather information about what kind of chip is used on the
motherboard.
