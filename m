From: Mark Lord <liml@rtr.ca>
Subject: Re: hdparm ATA Security Options return errors
Date: Wed, 19 Oct 2005 23:10:45 -0400
Message-ID: <43570AB5.6090503@rtr.ca>
References: <S1750797AbVJQQjQ/20051017163916Z+71@vger.kernel.org> <4353DBF1.1060001@gmx.de> <4353E257.5060104@gmx.de> <43540A36.2080404@rtr.ca> <4355FC28.2020704@gmx.de> <4356624A.2000307@rtr.ca> <4356734F.6050303@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:2249 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751648AbVJTDKs
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 Oct 2005 23:10:48 -0400
In-Reply-To: <4356734F.6050303@gmx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: t.schorpp@gmx.de
Cc: linux-ide@vger.kernel.org

thomas schorpp wrote:
>
> vanilla kernel 2.6.13.4
> no security enabled before, no passwort.
> hdparm --security-disable xxxx /dev/hde
> 
> Oct 19 18:15:51 tom1 kernel: hde: status timeout: status=0xd0 { Busy }
> Oct 19 18:15:51 tom1 kernel: ide: failed opcode was: 0xf2
> Oct 19 18:15:51 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT
> Oct 19 18:15:51 tom1 kernel: hde: status error: status=0x00 { }
> Oct 19 18:15:51 tom1 kernel: ide: failed opcode was: 0xf6
> Oct 19 18:15:51 tom1 kernel: hde: no DRQ after issuing MULTWRITE_EXT
> 
> sync problem?

That would be a Linux IDE Driver issue/bug.

Cheers
