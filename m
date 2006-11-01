From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Fun with HPT302N (Rocket Raid 1520 PCI card)
Date: Wed, 01 Nov 2006 16:26:39 +0400
Message-ID: <4548927F.10804@wasp.net.au>
References: <23724.1161684269@redhat.com>  <454869C8.9000103@pobox.com> <1162383443.11965.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:10374 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751353AbWKAM1b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2006 07:27:31 -0500
In-Reply-To: <1162383443.11965.109.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, David Howells <dhowells@redhat.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Mer, 2006-11-01 am 04:32 -0500, ysgrifennodd Jeff Garzik:
>> I think the newer HPTs present a pata_hpt*.c compatible interface, even 
>> though the card is driving SATA devices.
> 
> Some of the cards using HPT3xx chips for SATA are PATA chips with
> bridges so it may well be such a card. I really need to know what
> happens if you plug a drive in.
> 

Here is a complete dmesg from a Rocketraid 1540 (htp37x with bridges) if it helps.
(4 ports, 3 have drives and the 4th exhibits the failure David is seeing)

http://www.nabble.com/2.6.19-rc3-pata_hpt37x-dying-with-%22irq-16:-nobody-cared%22-t2504272.html

I still have this in a machine dedicated for testing if you need more info.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
