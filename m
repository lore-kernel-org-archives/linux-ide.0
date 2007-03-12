From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Mon, 12 Mar 2007 19:40:19 -0400
Message-ID: <45F5E4E3.5030709@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	<45F56800.3040104@rtr.ca>	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>	<45F5A523.1080500@rtr.ca>	<20070312221351.6c3db1fa@lxorguk.ukuu.org.uk>	<45F5D2DA.20407@rtr.ca> <20070313000813.183a1364@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4179 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbXCLXkV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 19:40:21 -0400
In-Reply-To: <20070313000813.183a1364@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>
> Umm... someone reported originally getting problems with R/W LONG and PIIX
> but not AHCI and we discussed whether we might need to turn the
> prefetch/postwrite off for it. Would have been about October last year.

Ah, well, yes, they would have problems unless my patch had been applied.
And not only on ata_piix.

> If it works ok then I'll just cross it off the list

It works for me, on a variety of hardware.

Cheers
