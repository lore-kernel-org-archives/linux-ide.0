From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Tue, 28 Nov 2006 18:22:45 -0500
Message-ID: <456CC4C5.6090003@garzik.org>
References: <456CB72A.3010004@local.se> <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7581 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1757883AbWK1XWw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Nov 2006 18:22:52 -0500
In-Reply-To: <Pine.LNX.4.64.0611281444330.4244@woody.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jonas Lundgren <jonas@local.se>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Linus Torvalds wrote:
> So maybe these _are_ related somehow, and my problem showed up because I 
> actually had concurrent access to my DVD drive (some KDE media daemon 
> checking to see if I inserted a music CD or something?). Jeff, Tejun, is 
> there any reason to believe that the two channels on a PIIX ata controller 
> are somehow "tied together" and it could be problematic for concurrent 
> accesses?


I was sorta wondering in that direction too.  If its in legacy mode 
(PATA and SATA smushed together), that's a possibility.  But native or 
AHCI modes, the channels are pretty independent (which is the nature of 
SATA).

Historical note:  ata_piix is IMO more complicated than ahci, because 
the silicon is emulating the PATA interface using an internal (probably 
huge) state machine, converting PATA behavior to sending/receiving SATA 
packets.  There are classes of problems that just don't exist on ahci, 
simply because we can directly talk to the sata phy, rather than having 
to guess what the emulation state machine is doing.

	Jeff



