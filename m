From: Jason Cribbins <jason.cribbins@mgmservers.com>
Subject: Re: VIA VT8251 on Asus A8V-MV
Date: Mon, 21 Nov 2005 21:03:34 -0500
Message-ID: <43827C76.3000703@mgmservers.com>
References: <43808DAC.9030806@mgmservers.com> <20051121235516.GA8515@midnight.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from kyle.mgmservers.net ([63.246.146.180]:53201 "EHLO
	kyle.mgmservers.net") by vger.kernel.org with ESMTP id S932343AbVKVCDU
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Nov 2005 21:03:20 -0500
In-Reply-To: <20051121235516.GA8515@midnight.suse.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

Can you explain the situation in the following URL?
http://forums.viaarena.com/messageview.aspx?catid=28&threadid=68455&STARTPAGE=1

Also as I try to install fedora it reports that it is unable to find any 
installed HDs.  I have found an OpenBSD patch that does get it to work 
there but nothing for Linux that works as of right now.
My BIOS has the controller set to SATA mode right now and its not 
visible.  Even if I set it to RAID mode or AHCI modes I get the same 
result using fedora core4 and what ever kernel comes bundled with their 
installer.

Vojtech Pavlik wrote:

>On Sun, Nov 20, 2005 at 09:52:28AM -0500, Jason Cribbins wrote:
>
>  
>
>>I was wondering if its possible to find someone to create a driver 
>>support for the Via VT8251 South Bridge chipset which appears to have 
>>been around for about a year now.  I am unable to get any form of Linux 
>>to see my HDs connected to that on board controller.  Although I have 
>>successfully used it in non-raid mode on FreeBSD.  I need this for 
>>fedora if possible.
>>
>>Is something like this possible?  And if so would it cost anything?
>>    
>>
> 
>The vt8251 is supported for quite some time by the IDE driver and its
>vt82cxxx.c chipset driver.
>
>  
>

