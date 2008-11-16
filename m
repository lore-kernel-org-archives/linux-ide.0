From: Alexander Clausen <alex@gc-web.de>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 19:05:13 +0100
Message-ID: <492060D9.20808@gc-web.de>
References: <49202CB0.60507@gc-web.de> <18720.18615.938839.921189@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:55109 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbYKPSFS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 13:05:18 -0500
In-Reply-To: <18720.18615.938839.921189@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> Do you have anything connected to that mobo's VIA SATA ports? If not,
> you could move the disk(s) from the Promise controller to the VIA
> controller just to see how the machine behaves over repeated suspend/resume
> cycles. (I'm not suggesting you move the disks permanently, this would
> just be a data gathering experiment.)

It works fine (~5 cycles tested) with the PCI (non-onboard) controller (VIA VT6421).
Of course I'm still interested in getting suspend to work with the promise chip, so I don't
have to waste money on the addon card (the one used in testing is just borrowed)

Alex
