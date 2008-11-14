From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] New IDE/block driver for OCTEON SOC Compact Flash interface.
Date: Fri, 14 Nov 2008 13:22:45 +0300
Message-ID: <491D5175.7060207@ru.mvista.com>
References: <491C7F28.2070507@caviumnetworks.com> <491CC0B6.8020400@ru.mvista.com> <491CC6D4.2080604@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:55263 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752960AbYKNKWx (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Nov 2008 05:22:53 -0500
In-Reply-To: <491CC6D4.2080604@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>, linux-ide@vger.kernel.org

Hello

David Daney wrote:

>>> As part of our efforts to get the Cavium OCTEON processor support
>>> merged (see: http://marc.info/?l=linux-mips&m=122600487218824), we
>>> have this CF driver for your consideration.
>>>
>>> Most OCTEON variants have *no* DMA or interrupt support on the CF
>>> interface so a simple bit-banging approach is taken.  Although if 
>>> DMA is
>>> available, we do take advantage of it.
>>>
>>> The register definitions are part of the chip support patch set
>>> mentioned above, and are not included here.
>>>
>>> At this point I would like to get feedback as to whether this is a
>>> good approach for the CF driver, or perhaps generate ideas about other
>>> possible approaches.
>>
>>   It's totally unacceptable for drivers/ide/ as this is 
>> self-containeed driver no using IDE core for anything, so this can 
>> only fit well to drivers/block/.
>
> Not quite true, it is using ide_fix_driveid() and ide_fixstring(), but 
> I get your point.

   Overlooked those. I just saw that it looked very alike the version 
that I've seen -- hidden deep inside arch/mips/ at that time. :-)

> OTOH, CF support via self-contained driver is certainly a waste of 
> code since IDE core and (libata) are here to drive the CF devices as 
> well. What we need is a "normal" IDE or libata (at your option) driver.
>
> I will have to try it to see if the hardware has the necessary support.

   It sure does have the necessary support -- this is a part of CF spec.

> Thanks,
> David Daney

WBR, Sergei


