From: Sergei Shtylylov <sshtylyov@ru.mvista.com>
Subject: Re: PATCH: libata PATA patches
Date: Wed, 09 Nov 2005 18:23:02 +0300
Message-ID: <43721456.4070205@ru.mvista.com>
References: <1131460386.25192.45.camel@localhost.localdomain> <4371FA47.1070806@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft2.corbina.net ([85.21.88.2]:27528 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751408AbVKIPVM
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 Nov 2005 10:21:12 -0500
In-Reply-To: <4371FA47.1070806@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, I wrote:

> Alan Cox wrote:
> 
>> I've put a new patch versus 2.6.14-mm1 on 
>> http://zeniv.linux.org.uk/~alan/IDE
> 
> 
>    I found somewhat strange that you check for 0xABCDExxx signature in 
> 32-bit PCI config. reg. 0x78 while HighPoint's own drivers read BM reg. 
> 0x90 (i.e. PCI config. 0x70) for that. PCI reg. 0x7A is DPLL precision 
> adjust reg. and 0x7B is the input clock select and IRQ reg., so it'd be 
> quite strange if the BIOS used them for any kind of signature...

    Pardon me for being too hasty. :-)
    I was talking about drivers/scsi/pata_hpt37x.c

WBR, Sergei
