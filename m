From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Fri, 15 Jul 2011 19:45:56 +0400
Message-ID: <4E2060B4.3090300@ru.mvista.com>
References: <1303673315.5231.9.camel@mulgrave.site> <1305306118.2611.62.camel@mulgrave.site> <4DCED18B.1070801@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39862 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab1GOPrv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2011 11:47:51 -0400
In-Reply-To: <4DCED18B.1070801@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>

Hello.

Jeff Garzik wrote:

>> On Sun, 2011-04-24 at 14:28 -0500, James Bottomley wrote:
>>> currently libata-sff is completely ignoring the enabled/disabled status
>>> of the interfaces.  This is a real problem on parisc because if you
>>> touch a non responding memory area (i.e. a disabled interface) you crash
>>> the box.

>>> Fix by checking the CNTRL bits to see if the port is enabled before
>>> trying to poke it.

>> Ping on this.

>> Since 1/2 is an essential fix to prevent a boot panic on parisc, I can
>> just take them through the parisc tree.

> It's in libata-dev.git#upstream and #NEXT (linux-next) at present.

    I'm wondering about the other drivers that check the channel enable bits in 
their prereset() methods. James has shown that such code would still crash on 
such platforms as PARISC (I suspect many more platfroms which don't silently 
ignore the target aborts in the PCI space like x86 does). I think all such 
drivers should be converted to the early port disable detection scheme used in 
the pata_cmd64x driver (an some others)...

>     Jeff

WBR, Sergei

