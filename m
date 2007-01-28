From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC] libata IORDY handling
Date: Sun, 28 Jan 2007 22:00:43 +0300
Message-ID: <45BCF2DB.3090400@ru.mvista.com>
References: <200701282024.17518.sshtylyov@ru.mvista.com>	<45BCEA03.8070901@ru.mvista.com> <20070128190325.7ba9af66@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.155]:16289 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752476AbXA1TAu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 14:00:50 -0500
In-Reply-To: <20070128190325.7ba9af66@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com

Hello.

Alan wrote:

>>    I looked into fixing this but had a feeling that the thing wasn't right 
>>from the very start, including ata_pio_need_iordy().  In my understanding of 
>>the ANSI T13 stadrads, when one issues Set Features subcommand Set Transfer 
>>Mode with sector count register of 0x8 thru 0xC this means that IORDY *must* 
>>be enabled. 

> Yes. It is more complex than the current code handles. That's one reason
> I added ata_pio_need_iordy(), because it would need to change and

    I also meant this function: if IORDY *must* be enabled even for PIO mode 0 
(being set the way liabata sets it, via the mentioned subcommand), what's the 
point of checking if we need to enable IORDY?  The only reason for this 
function as it seems is to check if we can do *without* IORDY still...
    Even if so, we must check if any of these both drives need IORDY to decide 
whether we need to enable IORDY checking on taskfile accesses or not -- which 
this function fails to do...

> hardcoding it would be particularly ugly.

    Yeah, hardcoding is ugly, no doubt about it. This is still a problem with 
both pdc202xx_new and pata_pdc2027x, for example...

> This will matter for supporting some utterly ancient junk.

    Well, SiI680 seemed to me quite well designed. :-)

> Alan

MBR, Sergei
