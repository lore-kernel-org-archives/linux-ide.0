From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Mon, 19 Jan 2009 18:20:49 +0300
Message-ID: <49749A51.3000504@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <200901161603.03699.stf_xl@wp.pl> <4970A8FF.4080404@ru.mvista.com> <200901191251.25880.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:54665 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751433AbZASPUU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 10:20:20 -0500
In-Reply-To: <200901191251.25880.stf_xl@wp.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, ddaney@caviumnetworks.com

Hello.

Stanislaw Gruszka wrote:

>>>I use t9 for calculating memory controller settings, but maybe it is
>>>unneeded, pata_at91 don't use this value.

>>    You mean pata_at32? It might have been that this detail was missed...

> Yes at32 of course. Now I'm trying to figure out difference between settings
> in at32 and my code. They differ, so one driver (I suspect my) is probably 
> wrong.

    I'm going to post the deatiled review af your patch RSN. I've even got so 
far as to reading Atmel's dataheets (well, it wasn't for the first time as I 
had some experience with their AVR8 mictocotrollers :-).

> Stanislaw Gruszka

MBR, Sergei
