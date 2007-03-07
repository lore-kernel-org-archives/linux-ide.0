From: "Paul Rolland" <rol@as2917.net>
Subject: RE: 30 second timeout on bootup with Intel ICH7 and AHCI(2.6.21-rc2)
Date: Wed, 7 Mar 2007 17:03:03 +0100
Message-ID: <007201c760d2$191ae4a0$4b00a8c0@donald>
References: <20070306211914.3e983a93@oldman>
Reply-To: <rol@as2917.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tag.witbe.net ([81.88.96.48]:58543 "EHLO tag.witbe.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283AbXCGQDM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 11:03:12 -0500
In-Reply-To: <20070306211914.3e983a93@oldman>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Stephen Hemminger' <shemminger@linux-foundation.org>
Cc: 'Jeff Garzik' <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

> Could it be the additional RAID controller (not used). I turned it
> off in BIOS as well. Maybe if I turned the other ports on, but then
> it would have to probe them.

Yes, that's it !

I tried to use : ata2=noprobe in the boot parameters, but that seems
to be a no-op... Too bad, 'cos' I know for sure I don't want to connect
something on this raid controller, and that would help me gain at least
30s at boot time...

Or maybe the syntax is wrong ?

Regards,
Paul

