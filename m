From: Andre Tomt <andre@tomt.net>
Subject: Re: Switching ICH7 to ACPI mode?
Date: Sun, 04 May 2008 23:51:23 +0200
Message-ID: <481E2FDB.6060903@tomt.net>
References: <1209932346.29633.17.camel@pancake.floe.gotdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.ugh.no ([80.239.42.168]:46156 "EHLO mail1.ugh.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128AbYEDWMv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 4 May 2008 18:12:51 -0400
In-Reply-To: <1209932346.29633.17.camel@pancake.floe.gotdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Florian Echtler wrote:
> Hello Jeff,
> 
> my wife's ACER Aspire 5550 notebook has a ICH7 controller which is
> eternally in "legacy" mode - the crippled BIOS is doesn't offer any
> option to switch it to AHCI mode. It's basically running fine using the
> ata_piix driver, but it never comes out of resume, only the hard disk
> LED lights up and stays that way.

You could try Matthews patch to force-enable AHCI:
http://www.codon.org.uk/~mjg59/tmp/ahci_quirk_cleanup.diff

Note you might have to remove the #if 0 for some chips. See 
http://mjg59.livejournal.com/85504.html
