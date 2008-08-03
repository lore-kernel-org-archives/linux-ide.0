From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Kernel Summit request for Discussion of future of ATA (libata) and
	IDE
Date: Sun, 03 Aug 2008 10:57:35 -0500
Message-ID: <1217779055.4179.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:60775 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756243AbYHCP5m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Aug 2008 11:57:42 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>

Right at the moment, we have two separate subsystems for running IDE
type devices:  driver/ide and drivers/ata.  The claim I've seen is that
drivers/ata can do everything drivers/ide can do plus it does sata.  I
also note that no major distribution seems to enable anything in
drivers/ide anymore, so given this is it time to deprecate drivers/ide?

A counter argument to the above is that not all drivers (particularly
the older ones where hw is scarce) are converted to drivers/ata, so
drivers/ide seems to be needed for some legacy systems (in which case it
can be deprecated but not removed).  I've also noted that some embedded
distributions seem to be using drivers/ide, but I'm not really sure
whether this is inertia or some overriding need.

The proposal is to discuss the future of these two subsystems and arrive
at a consensus what's happening to each going forwards.

James


