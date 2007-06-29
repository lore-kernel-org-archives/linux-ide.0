From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Fri, 29 Jun 2007 06:57:25 -0400
Message-ID: <4684E595.8030404@garzik.org>
References: <200706060104.18055.uwe.koziolek@gmx.net> <20070605231912.GW31565@havoc.gtf.org> <468421F9.8070809@gmx.net> <4684257E.5070402@garzik.org> <468429CC.5080006@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56188 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911AbXF2K53 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 29 Jun 2007 06:57:29 -0400
In-Reply-To: <468429CC.5080006@gmx.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Uwe Koziolek <uwe.koziolek@gmx.net>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Uwe Koziolek wrote:
> Jeff Garzik wrote:
>>>>   
>>> Jeff,
>>> Did you have added  the patch you have  mailed on 06.06. anywhere or is
>>> this patch an email only patch. And how to continue?
>> It's in my mbox queue, should be in my next "run"... :)
>>
>>     Jeff
>>
> I have 3 fixes that i want to add on top
> - a compilation fix for your fix
> - an additional PCI-ID
> - a changed handling for SATA-devices in IDE-emulation mode, this fixes
> issues for the SiS968
> 
> I have submitted these fixes 2 times in a single patch, but i can also
> split the three fixes in separate patches
> if wanted.

Easiest for me would be three separate patches (after which I can 
combine the first with the existing patch in my mbox).

	Jeff



