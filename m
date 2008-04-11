From: Kurt Roeckx <kurt@roeckx.be>
Subject: Re: [PATCH 2.6.25-rc6] sata_promise: fix hardreset hotplug events,
	take 2
Date: Fri, 11 Apr 2008 23:11:21 +0200
Message-ID: <20080411211121.GA30781@roeckx.be>
References: <200803221421.m2MEL1oY021558@harpo.it.uu.se> <18406.38445.717175.664615@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yergi.telenet-ops.be ([195.130.132.36]:40991 "EHLO
	yergi.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761920AbYDKVLd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 17:11:33 -0400
Received: from wilson.telenet-ops.be (unknown [195.130.132.42])
	by yergi.telenet-ops.be (Postfix) with ESMTP id B81455CA4F9
	for <linux-ide@vger.kernel.org>; Fri, 11 Apr 2008 23:11:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <18406.38445.717175.664615@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

On Sun, Mar 23, 2008 at 06:41:01PM +0100, Mikael Pettersson wrote:
> A Promise SATA controller will signal hotplug events when a hard
> reset (COMRESET) is done on a port. These events aren't masked by
> the driver, and the unexpected interrupts will cause a sequence
> of failed reset attempts util libata's EH finally gives up.

I've tried tried a 2.6.25-rc8 kernel which should contain the patch.
I'm still seeing my problem about the hotplug events.


Kurt

