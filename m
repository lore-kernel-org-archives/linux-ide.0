From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [RFC][PATCH] at91_ide driver
Date: Tue, 27 Jan 2009 18:46:38 +0300
Message-ID: <497F2C5E.9020205@ru.mvista.com>
References: <200901141345.42583.stf_xl@wp.pl> <200901221212.55528.stf_xl@wp.pl> <49786138.20809@ru.mvista.com> <200901221414.39802.stf_xl@wp.pl> <49787929.2010305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:33967 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752508AbZA0PqJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 10:46:09 -0500
In-Reply-To: <49787929.2010305@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, linux-ide@vger.kernel.org

Hello, I wrote:

>>>> Well, we could add #ifdef with diffrent implementation of 
>>>> init_smc_mode(), set_8bit_mode(), etc... 

>>>   No, #ifdef'ery is certainly not an option.

>> Why?

>    It's totally ugly and unacceptable way of doing things. It seems also 
> totally wrong to add support for totally incompatible SMC to this driver 
> (especially with #ifdef's). Another driver should be written if CF 
> support is required.

>> Other option is create some header files and implement and exporting 
>> these
>> functions from processor specific code. This add files dependencies 
>> and spread
>> things across sources, FWIW.

>    I don't think it's feasible as that SMC is just too different.

    Besides, AT91RM9200 code turned out to already be registering a platform 
device called at91_cf -- driver for which I have located in drivers/pcmcia/, 
so apparently they're not interested in True IDE mode support (and have 
overgeneralized the name as well :-).

MBR, Sergei
