From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] Small initializer patch for ide-disk.c
Date: Tue, 21 Dec 2004 13:57:55 -0800
Message-ID: <41C89C63.8090708@osdl.org>
References: <20041221202407.GD2725@artsapartment.org>	<41C88F73.2090606@pobox.com> <20041221133056.6a5a3259.akpm@osdl.org> <41C89ADE.1010403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fire.osdl.org ([65.172.181.4]:23451 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261603AbULUV7L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Dec 2004 16:59:11 -0500
In-Reply-To: <41C89ADE.1010403@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, ahaas@airmail.net, B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
> 
>> Jeff Garzik <jgarzik@pobox.com> wrote:
>>
>>> Art Haas wrote:
>>>
>>>> Hi.
>>>>
>>>> This patch adds C99 initializers to the file. It can clearly wait until
>>>> after 2.6.10 is released if you want to send it to Linus.
>>>
>>>
>>> The unpatched version is far more readable and maintainable.
>>>
>>
>>
>> I was thinking the exact opposite ;)
> 
> 
> 
> The problem with this (and similar patches to PCI drivers' struct 
> pci_device_id arrays) is that a single line explodes into 4-5 or more 
> lines, when it is _already_ plainly obvious to the maintainer what each 
> field value represents.
> 
> It uses more space without adding value to the maintainer ("I have to 
> scroll a lot more to see the same information?  Thanks!").
> 
> Once the struct has exploded from one line per entry to bunches, the 
> maintainer is then forced to reverse the damage by creating a macro that 
> allows the data to shrink again.  Why not just avoid the expand-shrink 
> cycle in the first place?  See example below, from drivers/ide/pci/piix.h.
> 
> Of course, Art's patch modifies drivers/ide/*, so Bart's opinion on the 
> subject is far more important than mine.

I like to see the field names listed too.

But the real question to me (other than "will some old-style
initializers be deprecated by gcc in the future?") is
"who will read such initializers?".  I don't think that it
hurts readabiility by/for the maintainer(s) but it does help
readability for the rest of us.  IMHO obviously.

-- 
~Randy
