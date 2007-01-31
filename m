From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 13/15] ide: fix UDMA/MWDMA/SWDMA masks
Date: Wed, 31 Jan 2007 23:38:08 +0300
Message-ID: <45C0FE30.4000800@ru.mvista.com>
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain>	<20070119003226.14846.87052.sendpatchset@localhost.localdomain>	<45B4FFBD.40507@ru.mvista.com> <20070122184620.1c8b87ac@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:46964 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030446AbXAaUiN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 15:38:13 -0500
In-Reply-To: <20070122184620.1c8b87ac@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Alan wrote:

>>    Ugh, I'm not seeing any *actual* support for MW/SW DMA in this driver... 

> Thats long been broken. Should be correct in the libata driver

    I've looked thru the specs and it seemed to me that ULi hardware is much 
broken PIO wise: their max active time is 8 cycles even on taskfile access 
which gives 240 ns while standard requeires 290 ns for modes 0 thru 2...

    I've also noted that the tuneproc() method in both cmd64x.c and alim15x3.c 
seems to misdo recovery calculation, taking address setup into account -- that 
should be slightly overclocking PIO modes 0/1 (ULi docs don't shed much light 
on how it should be calculated)... Well, this seems fixed in libata drivers.

> Alan

MBR, Sergei
