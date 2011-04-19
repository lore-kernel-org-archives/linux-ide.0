From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 0/2] fix libata-sff and pata_cmd64x to not crash on boot
 on parisc
Date: Wed, 20 Apr 2011 01:22:54 +0400
Message-ID: <4DADFD2E.9070809@ru.mvista.com>
References: <1303152147.7167.12.camel@mulgrave.site>	<20110418205203.56bbdb14@lxorguk.ukuu.org.uk>	<1303159802.7167.30.camel@mulgrave.site>	<20110418222017.4e77fe05@lxorguk.ukuu.org.uk>	<4DADF798.6010705@ru.mvista.com> <20110419221900.67528a07@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51194 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1DSVYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Apr 2011 17:24:32 -0400
In-Reply-To: <20110419221900.67528a07@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-ide <linux-ide@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>

On 20-04-2011 1:19, Alan Cox wrote:

>>> We can detect the Mobility electronics split bridges at least (and I
>>> suspect they are the only 'common' CMD64x hot plug device indeed possibly
>>> the only one) because the parent bridge of the CMD64x will have a PCI
>>> vendor id of 0x14f2 and a device id 0x0001, 0x0002, or 0x0120.

>>      What's the issue with these brodges anyway? Why the enable bits are not
>> valid for them?

> Good question. I'd assumed because they are hotplugged and so no firmware
> gets to set the bits properly ?

    The bits are strapped off the pins JP3/JP4.

WBR, Sergei
