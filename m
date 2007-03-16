From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 10:15:46 -0400
Message-ID: <45FAA692.8080507@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca> <20070316150129.5bd65c9d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:3215 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbXCPOPt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 10:15:49 -0400
In-Reply-To: <20070316150129.5bd65c9d@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> The fussy bit is that these commands require a non-standard
>> sector size, usually 520 bytes instead of 512.
> 
> Do we always know the worst case here as this breaks my pending patch to
> use bounce buffers for PIO so we transfer with IRQ enabled and I need to
> know the correct new worst case size.

Ugh.  The drives default to 520 bytes (always),
but can specify a different, preferred, length in
the IDENTIFY data.  A SETFEATURES command is required
to change the setting from the default of 520.

In practice, I only ever use 520, because (1) it always works,
and (2) I'm only trying to corrupt drives, not write correct stuff. ;)

So we could modify the patch to limit it to a specific maximum,
or always require exactly 520 bytes without any hardship.

???

Cheers
