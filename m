From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] ide: move SFF I/O code to ide-io-sff.c
Date: Tue, 20 Jan 2009 00:48:05 +0300
Message-ID: <4974F515.4030304@ru.mvista.com>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>	<20090119130322.24745.76137.sendpatchset@localhost.localdomain>	<49748B95.9080105@ru.mvista.com>	<200901191523.15240.bzolnier@gmail.com>	<49748E43.4030009@ru.mvista.com>	<20090119173701.13fd24c6@lxorguk.ukuu.org.uk>	<4974C030.5020509@ru.mvista.com>	<20090119183607.5ee804e1@lxorguk.ukuu.org.uk>	<4974CA81.1050506@ru.mvista.com>	<20090119184951.35a52184@lxorguk.ukuu.org.uk>	<4974CEC5.9050402@ru.mvista.com> <20090119213101.798fe1cd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:63869 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757218AbZASVsP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 16:48:15 -0500
In-Reply-To: <20090119213101.798fe1cd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan Cox wrote:

>>> I'm afraid you are the one who is wrong. The IDE layer is duplicating a
>>> generic level of indirection with its own code - purely because IDE
>>> pre-dates that core functionality. The whole IDE layer indirection can go
>>> away because Linux has caught up with the needs of the IDE layer.
>>>       
>>     What IDE indirection you're talking about anyway?
>>     
>
> As I said earlier ide_mm_inb etc via the function pointers tf_inb/tf_outb
> etc.
>   

   Ah... at least they don't have additional address checks that 
ioread*()/iowrite*() have...

> Given how small those functions are it might even be worth rolling them
> into two different versions of the functions like ide_tf_read as surely
> it costs more to call them (in size) than to inline the two for those
> functions?
>   

   Indeed.

WBR, Sergei


