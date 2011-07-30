From: "tj@kernel.org" <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Sat, 30 Jul 2011 14:54:56 +0200
Message-ID: <20110730125456.GN2622@htj.dyndns.org>
References: <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
 <20110721090022.GF3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
 <20110722095037.GJ2622@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59253 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1G3MzC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jul 2011 08:55:02 -0400
Received: by fxh19 with SMTP id 19so3076437fxh.19
        for <linux-ide@vger.kernel.org>; Sat, 30 Jul 2011 05:55:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Derry Bryson <derry@high-rely.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On Fri, Jul 22, 2011 at 07:34:37PM +0000, Derry Bryson wrote:
> I did some testing with a PMP board containing a Sil3726 with firmware
> Version 1.0124 and a PMP/Raid board with a JMicron 393 configured as
> PMP only.  I am connecting to a Sil3124 esata pci controller.  
> 
> The Sil3726 board acted the same as the previous Sil3726 board with the 1.0114
> firmware.
> 
> The JMicron board worked much better.  It works properly with a stock 
> kernel and does not fail the IDENTIFY after hotplugging and does
> not require retries.  It seems to wait for the drive to spin up before
> doing anything so it works properly the first time without retries or
> hard resets.

Interesting, that's the behavior I see w/ my 3726 but all my PMPs are
very old, so I guess it has changed since then.  A bit too lazy to
hook it up to windows machine to check firmware version ATM. :)

> The only problem I saw was that it seemed to not work at all a
> couple of times if not powered up/connected before booting Linux.
> Couldn't see it at all, even after several power cycles and
> unplugging/pluggin esata cable.  I need to test this more as it is
> inconsistent and may have to do with the Sil3124 controller rather
> than the JMicron PMP.

How did that go?

Thanks.

-- 
tejun
