From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Thu, 02 Nov 2006 16:24:15 +0000
Message-ID: <1162484655.11965.212.camel@localhost.localdomain>
References: <23724.1161684269@redhat.com>  <454869C8.9000103@pobox.com>
	 <1162383443.11965.109.camel@localhost.localdomain>
	 <4548927F.10804@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6623 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751963AbWKBQ1s (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Nov 2006 11:27:48 -0500
In-Reply-To: <4548927F.10804@wasp.net.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brad Campbell <brad@wasp.net.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org

Ar Mer, 2006-11-01 am 16:26 +0400, ysgrifennodd Brad Campbell:
> Here is a complete dmesg from a Rocketraid 1540 (htp37x with bridges) if it helps.
> (4 ports, 3 have drives and the 4th exhibits the failure David is seeing)
> 
> http://www.nabble.com/2.6.19-rc3-pata_hpt37x-dying-with-%22irq-16:-nobody-cared%22-t2504272.html
> 
> I still have this in a machine dedicated for testing if you need more info.

That one is really very useful. The error handling is leaving some kind
of IRQ status no cleared which in turn brings the house down. I think
there are two different things in the log here - one is the empty port,
the other is some kind of other failure.

With a current -mm kernel can you stick ATA_FLAG_DETECT_POLLING on the
various .flags = ATA_FLAG_SLAVE_POSS|.... lines for each ata_port_info
structure in hpt37x_init_one then see if the identify behaviour is
happier.

That recipe is probably what we need to do for all the PATA chips that
don't have reliable device presence bits.

Alan

