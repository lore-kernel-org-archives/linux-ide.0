From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: How to Switch DMA off for only one Harddisk at Kernelboot
Date: Sun, 16 Dec 2007 21:31:17 +0100
Message-ID: <47658B15.5090600@googlemail.com>
References: <4765690C.6010605@j-o-a.de> <47657BA8.3020004@googlemail.com> <47657D79.7090100@j-o-a.de> <47658063.5010707@googlemail.com> <47658235.7050409@j-o-a.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:14727 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbXLPUbW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 16 Dec 2007 15:31:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so207094fga.17
        for <linux-ide@vger.kernel.org>; Sun, 16 Dec 2007 12:31:21 -0800 (PST)
In-Reply-To: <47658235.7050409@j-o-a.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Oliver Joa <oliver@j-o-a.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Oliver Joa wrote:
> Hi,
> 
> Gabriel C wrote:
> 
> [...]
> 
>>>> Also have a look at Documentation/ide.txt.
>>> I read this already. Searching for "nodma" in this document gives only 
>>> one line:
>>>
>>>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
>>>
>>> If the documentation is correct hda=nodma and ideX=nodma should not 
>>> work. I use kernel 2.6.23.1 at the moment.
>> grep nodma Documentation/ide.txt
>>  "hdx=nodma"            : disallow DMA
>>
>> ide=foo_option is for the whole ide sub-system where ideX|hdX=foo_option is just for that HDD.
> 
> 
> /usr/src/linux-2.6.23.1$ grep nodma Documentation/ide.txt
>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
> 
> /usr/src/linux-2.6.21.5$ grep nodma Documentation/ide.txt
>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
> 
> /usr/src/linux-2.6.12# grep nodma Documentation/ide.txt
>   "ide=nodma"            : disable DMA globally for the IDE subsystem.
> 
> Sorry, but I can not find this option, and it does not work. Which 
> kernel do you use?

This is my devel box , running 2.6.24-rc5-git

> 
> Thanks
> 
> Olli
> 

Gabriel
