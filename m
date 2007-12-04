From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ATA ACPI (was Re: Linux 2.6.24-rc4)
Date: Tue, 4 Dec 2007 21:25:08 +0000
Message-ID: <20071204212508.09d604b7@the-village.bc.nu>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
	<8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
	<4755C544.5060909@garzik.org>
	<4755C5B3.1020709@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:41418 "EHLO the-village.bc.nu"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752361AbXLDV3x (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Dec 2007 16:29:53 -0500
In-Reply-To: <4755C5B3.1020709@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org

On Tue, 04 Dec 2007 16:25:07 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> Jeff Garzik wrote:
> > Some BIOS writer probably thought that was a good idea, but maybe not 
> > for Linus.
> 
> er, s/Linus/Linux/

It probably is a good idea - if issued validly to supporting devices. It
stops attackers passwording your disk for amusement.

Is there a reason we give up when a command supplied by ACPI fails rather
than carrying on - which from the above is I assume what xp does ?
