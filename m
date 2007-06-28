From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [PATCH 2.6.22-rc4] libata: SiS180 pata support
Date: Thu, 28 Jun 2007 23:36:12 +0200
Message-ID: <468429CC.5080006@gmx.net>
References: <200706060104.18055.uwe.koziolek@gmx.net> <20070605231912.GW31565@havoc.gtf.org> <468421F9.8070809@gmx.net> <4684257E.5070402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:53607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759994AbXF1VgO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 28 Jun 2007 17:36:14 -0400
In-Reply-To: <4684257E.5070402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
>>>   
>> Jeff,
>> Did you have added  the patch you have  mailed on 06.06. anywhere or is
>> this patch an email only patch. And how to continue?
>
> It's in my mbox queue, should be in my next "run"... :)
>
>     Jeff
>
I have 3 fixes that i want to add on top
- a compilation fix for your fix
- an additional PCI-ID
- a changed handling for SATA-devices in IDE-emulation mode, this fixes
issues for the SiS968

I have submitted these fixes 2 times in a single patch, but i can also
split the three fixes in separate patches
if wanted.

Uwe


