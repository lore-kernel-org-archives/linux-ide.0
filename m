From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] libata: share PIO limits among devices sharing a channel
Date: Thu, 25 Jan 2007 17:54:57 +0300
Message-ID: <45B8C4C1.4010402@ru.mvista.com>
References: <20070125112947.GC8606@htj.dyndns.org>	<20070125123030.3093fb32@localhost.localdomain>	<45B8BDBC.20609@ru.mvista.com> <20070125145125.698d3a08@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:1350 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965278AbXAYOy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 09:54:58 -0500
In-Reply-To: <20070125145125.698d3a08@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello.

Alan wrote:

>>    Not really, at least not all drivers.  Namely, hpt366.c (still) doesn't 
>>merge 8-bit timings (maybe this is handled in hardware but the datasheets 
>>don't tell about it then) -- I need to look at fixing this... Well, it was 

> I've never been able to find out - but HPT's own drivers don't seem to do
> it under any OS so I assume its ok.

    From their drivers/BIOSes/chips I can only assume their engeneers' serious 
brain damage and incompetence. :-)
    Well, Linux driver was hardly better.

> The timing stuff should be pretty
> much the same for both ide and libata as libata lifted most of the rather
> nice ide-timing stuff directly from the old IDE layer.

    Yeah, pata_hpt3*.c still have the same issues as the old hpt366 driver, 
namely changing PIO timings when setting DMA modes.

> Alan

WBR, Sergei
