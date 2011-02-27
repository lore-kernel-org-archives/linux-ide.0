From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Supporting SATA Target mode (or any data transfer w/crossover
 cable) on AHCI
Date: Sun, 27 Feb 2011 09:10:58 -0500
Message-ID: <4D6A5B72.6040600@teksavvy.com>
References: <AANLkTi=mPAjKk0kZTuP-3fyQB8Rm0=mo5GDx9BOC073S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:41479 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751845Ab1B0OLC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Feb 2011 09:11:02 -0500
In-Reply-To: <AANLkTi=mPAjKk0kZTuP-3fyQB8Rm0=mo5GDx9BOC073S@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Aplin <drtune@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11-02-26 10:30 PM, Richard Aplin wrote:
> 
> I'm interested in trying to get generic mobo SATA controllers to run
> in Target mode; there are a few entertaining projects that become
> possible if this can be done.
> 
> Two obvious uses are SATA drive emulation and ultra-high-speed
> motherboard interconnect using bonded SATA3 channels.

Nobody here will argue against it -- it's something that could be
quite useful to all -- eg. homebrew SATA analyzers etc..

It does require specific support in the chipset, though.
And since there's no standard for that, this means the hardware
implementations are all vendor-specific, and somewhat "secret".

The Marvel 7042 PCIe chips implement target mode, and it probably
works on the older 60xx (non-AHCI) chips as well.  The "normal" SATA
driver for these is "sata_mv", but it does not implement target mode.

Both Jens and I have written code to attempt simple transfers
using "target mode", but neither effort had enough reverse-engineering
of the Marvell chips to actually make it work.  They don't exactly
spell out all of the details in their (NDA'd) documentation.

The standalone downloadable "proprietary" Marvell SATA driver,
which has "GPL" labelling, claims to to target mode.  But when I was
poking at it 2-3 years ago, the code therein was incomplete,
and appeared to be missing some secret jiggery to make it all work.

That's probably still the best starting point though.

Cheers
