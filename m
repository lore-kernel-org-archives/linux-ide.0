From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 06 Dec 2007 20:10:08 +0900
Message-ID: <4757D890.6030009@gmail.com>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<4755ABB3.6030907@garzik.org>	<4755FB90.50505@gmail.com>	<20071205124713.4d31c5e7@the-village.bc.nu>	<4756A1AE.4010205@gmail.com>	<20071205140119.532c1eb4@the-village.bc.nu>	<4756B415.404@gmail.com> <20071205144649.4bca7a3c@the-village.bc.nu> <4757D714.2000607@vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:56188 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbXLFLKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2007 06:10:15 -0500
Received: by wa-out-1112.google.com with SMTP id v27so443600wah
        for <linux-ide@vger.kernel.org>; Thu, 06 Dec 2007 03:10:14 -0800 (PST)
In-Reply-To: <4757D714.2000607@vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

Petr Vandrovec wrote:
> Alan Cox wrote:
>>> It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
>>> we can put it in #testing and put it into #upstream later.
>>
>> Nobody cares about libata git trees. If you want some initial test
>> coverage put it in -mm.
>>
>>> primarily worried about.  Command type dependent quick fallback might
>>> help but ancient controllers are more likely to bring the whole machine
>>> down when a DMA transaction goes south.
>>
>> Quite the reverse in my experience - the dumber the controller the more
>> likely that ATAPI DMA and LBA48 and other stuff just works anyway.
> 
> Yes.  FYI, if you'll start sending ATAPI commands with DATA_OUT phase
> using PIO from VM under VMware, it will politely ask you to reconfigure
> OS in the virtual machine to use DMA, and most probably it won't work
> until you really do so...  Windows are sending all these commands using
> DMA, and I believe they do same for majority of DATA_IN commands as well
> (and Windows also set byte count to correct PIO-like value even for DMA
> commands)

There are few DATA OUT commands and most of them are sector (2k)
aligned.  We use DMA for them.  The same goes for sector aligned DATA IN
commands and READ CD but what you say is inconsistent with what I've
seen from SATA bus trace.  Windows was using PIO for all misc DATA IN
commands - such as REQUEST SENSE, GET CONFIGURATION, MODE SENSE, etc...

And, libata will set byte count to PIO-like value for DMA from 2.6.25 if
not from 24.

Thanks.

-- 
tejun
