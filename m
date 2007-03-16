From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 11:07:16 -0400
Message-ID: <45FAB2A4.5020205@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com> <45FAACD4.6000709@rtr.ca> <45FAAD11.9010905@rtr.ca> <45FAB092.8020906@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:3061 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbXCPPHS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:07:18 -0400
In-Reply-To: <45FAB092.8020906@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Sergei Shtylyov wrote:
>..
>    Well, those ATA specs have always been quite messy: for example, 
> polling protocol had an unnoticed race for years (device was allowed to 
> clear BSY before asserting INTRQ, so there was no guarantee that the 
> host's reading of the status reg. will actually clear drive's interrupt)...

Hey.. a chap after my own heart!  Been there, done that!

> NOTE 31 - Some ATA-1 devices are not capable of delivering the 8 bit ECC 
> immediately after the word sector data. BIOS and driver developers 
> should use PIO mode 0 for 8 bit ECC accesses.

Exactly.  But we're not really interested so much in the rare ATA1 drive
that fails (the ATA1 Conner unit I have here works fine with this patch).

The idea here is to give us a way to inject errors into (more or less)
current drives (ata6/7 vintages) so we can see what happens when FPDMA
on a SATA drive hits a bad sector, etc..

For which it seems to work rather well.

Cheers 
