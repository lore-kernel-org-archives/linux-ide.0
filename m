From: Tejun Heo <htejun@gmail.com>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 15 Nov 2007 16:58:50 +0900
Message-ID: <473BFC3A.6010006@gmail.com>
References: <e03b90ae0711132239l258677fbk724204998078a952@mail.gmail.com>	 <473BBDBE.7060208@gmail.com> <473BC890.9020902@rtr.ca> <e03b90ae0711142337x7112904ar8673f08a19a6ff19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:15513 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbXKOH7S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 02:59:18 -0500
Received: by wa-out-1112.google.com with SMTP id v27so537644wah
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 23:59:17 -0800 (PST)
In-Reply-To: <e03b90ae0711142337x7112904ar8673f08a19a6ff19@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Breidenbach <jeff@jab.org>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Hancock <hancockr@shaw.ca>, Mikael Pettersson <mikpe@it.uu.se>, Jeff Garzik <jeff@garzik.org>

Jeff Breidenbach wrote:
> Thanks for the excellent rundown.
> 
>> sata_sil24: 3124/3132 chips don't have any outstanding serious
>> problems.  IRQ loss on PCI-X was the only recent serious known
>> problem but it's fixed now.
> 
> I'm still a little confused how to translate this known-good chipset to
> an actual buyable PCI card.  It isn't obvious from basic web searching.

That I don't know either.  I usually magnify the product photograph and
try to read the chip number (I know shapes of several chips so it's
easier for me) or call the manufacturer.  Just ask for the PCI ID and
look it up in linux PCI IDs repository or modinfo result.

-- 
tejun
