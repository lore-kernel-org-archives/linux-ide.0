From: James Ray <j.ray@qmul.ac.uk>
Subject: Re: Bug? ahci.c
Date: Tue, 27 Feb 2007 15:56:05 +0000
Message-ID: <45E45495.2020800@qmul.ac.uk>
References: <45B0B7C6.3030206@qmul.ac.uk> <45E44C26.2010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail2.qmul.ac.uk ([138.37.6.6]:63377 "EHLO mail2.qmul.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXB0RE4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 12:04:56 -0500
In-Reply-To: <45E44C26.2010207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> James Ray wrote:
>> Jeff, All,
>> 	We have just started using some new machines with The Intel ESB2
>> chipset in them (PCI Id: 8086:2681) for the SATA Controller.
>> With any kernels above 2.6.15 (as far as I can tell from my testing at
>> least) we are getting problems with them.
>>
>> This is the output I have managed to collect from the server (Its hard
>> to get much more since the system gets more and more unresponsive as
>> these errors progress):
>> <3>ata2.00: exception Emask 0x10 SAct 0x0 SErr 0x80002 action 0x2 frozen
>> <3>ata2.00: (irq_stat 0x08000000, interface fatal error)
>> <3>ata2.00: tag 0 cmd 0x35 Emask 0x10 stat 0x50 err 0x0 (ATA bus error)
>> <6>ata2: soft resetting port
>> <3>ata2: softreset failed (1st FIS failed)
>> <4>ata2: softreset failed, retrying in 5 secs
>> <6>ata2: hard resetting port
>> <4>ata2: port is slow to respond, please be patient
> 
> Can you test 2.6.20.1 and report full dmesg?  Thanks.
> 

I managed to get a response from Jeff on the linux-kernel list which I 
have yet to respond to (sorry!).

This problem was fixed by dodgy NCQ on the disk itself, S/N: 
WMANM2828677 P/N: WD1600JS-60MHB1 (Western Digital 160Gb). If I disabled 
the disk it worked fine, or replaced the disks with Some Seagates it 
worked fine also!

I am running a 2.6.19 at the moment quite happily. Still want me to test 
a 2.6.20.1? I might be able to get a bit of time later on this week.


-- 
James Ray.                          <j.ray@qmul.ac.uk>
Computing Services
Queen Mary, University of London
