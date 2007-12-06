From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 14/14] libata: use PIO for misc ATAPI commands
Date: Thu, 06 Dec 2007 03:03:48 -0800
Message-ID: <4757D714.2000607@vc.cvut.cz>
References: <1196346817387-git-send-email-htejun@gmail.com>	<11963468202627-git-send-email-htejun@gmail.com>	<4755ABB3.6030907@garzik.org>	<4755FB90.50505@gmail.com>	<20071205124713.4d31c5e7@the-village.bc.nu>	<4756A1AE.4010205@gmail.com>	<20071205140119.532c1eb4@the-village.bc.nu>	<4756B415.404@gmail.com> <20071205144649.4bca7a3c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailgw.cvut.cz ([147.32.3.235]:40158 "EHLO mailgw.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbXLFL1J (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Dec 2007 06:27:09 -0500
In-Reply-To: <20071205144649.4bca7a3c@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, liml@rtr.ca, albertl@mail.com, jens.axboe@oracle.com, Mikael Pettersson <mikpe@it.uu.se>

Alan Cox wrote:
>> It eventually has to end up in -rc.  If not for 2.6.25-rc1 is too early,
>> we can put it in #testing and put it into #upstream later.
> 
> Nobody cares about libata git trees. If you want some initial test
> coverage put it in -mm.
> 
>> primarily worried about.  Command type dependent quick fallback might
>> help but ancient controllers are more likely to bring the whole machine
>> down when a DMA transaction goes south.
> 
> Quite the reverse in my experience - the dumber the controller the more
> likely that ATAPI DMA and LBA48 and other stuff just works anyway.

Yes.  FYI, if you'll start sending ATAPI commands with DATA_OUT phase 
using PIO from VM under VMware, it will politely ask you to reconfigure 
OS in the virtual machine to use DMA, and most probably it won't work 
until you really do so...  Windows are sending all these commands using 
DMA, and I believe they do same for majority of DATA_IN commands as well 
(and Windows also set byte count to correct PIO-like value even for DMA 
commands)

Given that very few customers reported this problem in past 8 years, I 
would guess that your attempt to use PIO only will actually exercise 
more untested code in the firmware than DMA code paths.
							Petr

