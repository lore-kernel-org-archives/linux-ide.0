From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Switching ICH7 to AHCI mode?
Date: Mon, 05 May 2008 10:45:56 +0200
Message-ID: <1209977156.29633.25.camel@pancake>
References: <1209932346.29633.17.camel@pancake.floe.gotdns.org>
	 <481E2FDB.6060903@tomt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:40780
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755353AbYEEIp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 04:45:58 -0400
In-Reply-To: <481E2FDB.6060903@tomt.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andre Tomt <andre@tomt.net>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

> > my wife's ACER Aspire 5550 notebook has a ICH7 controller which is
> > eternally in "legacy" mode - the crippled BIOS is doesn't offer any
> > option to switch it to AHCI mode. It's basically running fine using the
> > ata_piix driver, but it never comes out of resume, only the hard disk
> > LED lights up and stays that way.
> You could try Matthews patch to force-enable AHCI:
> http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff
> Note you might have to remove the #if 0 for some chips. See 
> http://mjg59.livejournal.com/85504.html

Thanks, this does exactly what I was planning to do, and in a cleaner
fashion, too (I had forgotten about what quirks are for). I'll try the
patch later today and post the results.

Yours, Florian
-- 
0666 - Filemode of the Beast

