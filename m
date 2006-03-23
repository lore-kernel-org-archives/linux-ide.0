From: Tejun Heo <htejun@gmail.com>
Subject: Re: Gigabyte i-Ram cards
Date: Thu, 23 Mar 2006 19:50:13 +0900
Message-ID: <44227D65.9000204@gmail.com>
References: <441F63E6.2090204@garzik.org> <44214F92.1080901@eventmonitor.com> <4421DDE2.60502@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.181]:50205 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932391AbWCWWFk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Mar 2006 17:05:40 -0500
Received: by pproxy.gmail.com with SMTP id w49so506430pyg
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 14:05:40 -0800 (PST)
In-Reply-To: <4421DDE2.60502@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bryan Fink <bfink@eventmonitor.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Bryan Fink wrote:
>> Jeff Garzik wrote:
>>
>>> I'm impressed.  I ordered one to help debug BZ#6163, but I think 
>>> these cards will help expose bugs in libata due to their high speed.  
>>> With these cards, we can push more data through libata than would 
>>> normally be possible with a standard disk drive.
>>
>>
>>
>> Hi.  I tried to respond on this topic about a week ago, but I haven't 
>> seen my response show up on any of the mirrors, so I think it must 
>> have not made it through.
>>
>> Anyway, I just wanted to add that I am also fiddling with the Gigabyte 
>> i-Ram.  I haven't tried modifying and recompiling the kernel yet, but 
>> I did have some success another way:
>>
>> My desktop is a Dell Dimension 5150.  In the BIOS, I can set the "SATA 
>> Operation" to either "SATA" or "RAID".  If I set it to RAID, linux 
>> will see the i-RAM just fine (under Ubuntu 5.10 Live CD).  It loads 
>> ahci, and just takes off.  If I have the setting on SATA, then linux 
>> does not load ahci, and does not talk to the i-RAM.
>>
>> Of note is also the fact that Windows has no issue with talking to the 
>> i-RAM when my system is in SATA-mode.
>>
>> So, I guess the question is, are Windows and my BIOS ignoring this 
>> "invalid" feature query reply, or are the prodding the card in some 
>> way other than how linux does, which makes the card respond properly?
> 
> Your description seems to imply this is a BIOS+driver issue, not 
> anything related to the gigabyte card.
> 
> Intel ICH boards can be driven using either the ata_piix or the ahci 
> driver, depending on BIOS mode.  Most likely, when you switched to SATA 
> mode in BIOS, it started programming the motherboard to boot in 
> IDE-compatible mode (ata_piix) rather than SATA FIS mode (ahci).
> 

Hello, Bryan, Jeff.

iRam is not detected if the controller is configured as legacy mode 
because then ata_piix got attached and it checks diagnostic code which 
iRam fails to report properly. On the other hand, if you configure it as 
AHCI (or RAID), the ahci driver gets attached which accidentally doesn't 
check the diagnostic code, so the iRam is detected normally and can be 
used. sata_sil24 also doesn't check the diagnostic code, so iRam would 
work with sil24 too.

Well, apparently, BIOS and Windows driver don't check the diagnostic 
code and that's probably why gigabyte missed it. I'm voting for joining 
the crowd and ignoring it (with a warning). We have plenty of other 
mechanisms to verify attached devices and giving users an opportunity to 
try seemingly failing device isn't a bad idea.

-- 
tejun

