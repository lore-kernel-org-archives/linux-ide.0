From: Brad Campbell <brad@wasp.net.au>
Subject: Re: Via SATA not working here
Date: Mon, 13 Sep 2004 08:23:23 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <414520BB.3080306@wasp.net.au>
References: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:6622 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S265910AbUIMEXS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Sep 2004 00:23:18 -0400
In-Reply-To: <20040912191542.GO21202@uvt316-2.ruk.cuni.cz>
List-Id: linux-ide@vger.kernel.org
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Michal 'hramrach' Suchanek wrote:
> Hello
> 
> I got a mainboard with a Via SATA controller, a Maxtor UATA 133 drive,
> and an Asus SATA dongle (probably a Marvell chip).
> 
> When I was installing Linux the SATA controller got detected as IDE and
> basically worked. I would see occasional messages about DMA timeout
> while running from the install cd but the installation finished without
> errors.
> 
> After building a 2.6.7 kernel I would get pretty much the same result.
> I get a few messages about DMA timeout at startup and then it runs. But
> I found it would eventually lock up with the hdd led shining steadily.

Could you try it with a 2.6.5 kernel please? There were some changes made between 2.6.5 and 2.6.7 
that may well cause issues with HD's attached to dongles. There have been patches created for this 
by they have not yet made the mainstream kernel.

I'd be interested to see how that pans out.

Regards,
Brad
