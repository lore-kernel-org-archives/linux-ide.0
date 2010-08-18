From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RFC] ata: Intel IDE-R support
Date: Wed, 18 Aug 2010 11:03:06 +0100
Message-ID: <20100818110306.03ce2fbc@lxorguk.ukuu.org.uk>
References: <20100810155559.7620.79711.stgit@localhost.localdomain>
	<4C6AB68D.8000102@kernel.org>
	<20100817174257.3691ed68@lxorguk.ukuu.org.uk>
	<4C6AB919.7060203@kernel.org>
	<20100817180158.179e7780@lxorguk.ukuu.org.uk>
	<4C6ABFFA.2000502@kernel.org>
	<20100817192353.3529733c@lxorguk.ukuu.org.uk>
	<4C6B7B72.4090405@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59726 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752638Ab0HRJrt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Aug 2010 05:47:49 -0400
In-Reply-To: <4C6B7B72.4090405@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-ide@vger.kernel.org, jeff@garzik.org

> Sure, the thing is that your patch doesn't mean we don't have to keep
> ata_piix device table up-to-date.  We would still need to be
> maintaining that table whether ata_generic can detect IDE-R by itself

I'm not sure I follow

> or not.  The device ID table in ata_piix is given, and ata_generic
> picking up the rest of intel IDE's wouldn't miss anything.  So, unless
> IDE-R devices need some special treatment, I don't really see how the
> detection code would be useful.

The trend is towards AHCI so the problem goes away for the other bits.

IDE-R is not ata_piix drivable, and lots of the ICH stuff really wants
driving via ata_piix, so having the generic driver grab all intel stuff
isn't as far as I can see going to be safe given a system may load the
ata_generic module but not PIIX then meet a piix by hotplug.

Alan
