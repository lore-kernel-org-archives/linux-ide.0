From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: possibly a dumb question about sb600/700
Date: Mon, 12 Nov 2007 15:28:13 +0000
Message-ID: <20071112152813.369372e3@the-village.bc.nu>
References: <47381768.2060803@gmail.com>
	<20071112131640.3bf0073c@the-village.bc.nu>
	<4738542A.5050706@gmail.com>
	<20071112143612.5be65fc8@the-village.bc.nu>
	<473866CE.4010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49857 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751605AbXKLP2n (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Nov 2007 10:28:43 -0500
In-Reply-To: <473866CE.4010407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: conke.hu@gmail.com, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 12 Nov 2007 23:44:30 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Alan Cox wrote:
> >> Alright, then.  I was just worried about the asymmetry.  Oh, this
> >> _reminds me of another problem regarding enable bits.  There's a system
> >> (wyse thin client) with pata_amd controller where the enable bit isn't
> >> set by the BIOS and there's no reliable way to identify the system (no
> >> DMI).  Do you know how important is the enabled bits test for these
> >> controllers?
> > 
> > If we ignore the tests we get more problems with 30 second timeouts on
> > other hardware that has incorrect termination or a port which is simply
> > not wired on the mainboard.
> > 
> > I bet we can identify the Wyse somehow and I'd rather do that even if it
> > means looking for magic strings in the BIOS ROM image.
> 
> Thanks.  I don't have direct access to the machine so I guess they'll
> have to live with temporary workaround for the time being.  :-(

cp biosrom file
strings file
grep product name

not approximate offset

