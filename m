From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AHCI should try to claim all AHCI controllers
Date: Wed, 01 Nov 2006 12:23:03 +0000
Message-ID: <1162383783.11965.116.camel@localhost.localdomain>
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
	 <45482BA7.6070904@pobox.com>
	 <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1720 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946843AbWKAMTd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Nov 2006 07:19:33 -0500
In-Reply-To: <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

Ar Maw, 2006-10-31 am 21:22 -0800, ysgrifennodd Linus Torvalds:
> (We had the same issue with "PCI IDE controller". Some PCI IDE controllers 
> are clearly exactly that from a programming interface standpoint, but 
> because they support RAID in hardware, they claim to be RAID controllers, 
> since that is more "glamorous". Gaah ;^).

Actually its far uglier than that. With one exception they don't support
hardware raid mode, they use the RAID class tag to stop other OS drivers
grabbing the interface or seeing it directly as un-raided software raid.

Alan
