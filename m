From: "Willy Gardiol" <willy@gardiol.org>
Subject: Re: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 12:12:06 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031230111206.1335.qmail@webmaildomini2.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.149.128.211] ([62.149.128.211]:55968 "HELO
	webmaildomini2.aruba.it") by vger.kernel.org with SMTP
	id S265742AbTL3LMJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2003 06:12:09 -0500
List-Id: linux-ide@vger.kernel.org
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-ide@vger.kernel.org


Check you are using 80pin cables... but -X69 would fail if not.
PCI bus should not be to blame for this, unless your is overloaded (?) like 
heavy network traffic (fast or gigabit ethernet) may steal PCI cycles, but i 
have never seen this happen in pc's... 

Maybe check your card is not sharing an IRQ, move into another slot, try 
some fixed allocation from BIOS to avoid this...
But i whouldnt expect too much from this on the speed side (just in case 
some troubles with IRQ sharing). 

Are you using the new pdc driver? The new one is the one supporting newer 
chipsets like the 20271, i do not know which chip your promise has. 

Try Bonnie to get some real on-the-road measurement from ypur filesystems... 
that is the REAL speed you can get from your disks. 


Nicklas Bondesson Scrive: 

> Ok, so you currently don't have any suggestions on this? Could it be a slow
> PCI slot causing the poor performance? It's an ASUS P2B (rev 1.04)
> motherboard with PCI 2.1 enabled in BIOS. 
> 
> /Nicke  
> 
> -----Original Message-----
> From: Willy Gardiol [mailto:willy@gardiol.org] 
> Sent: den 30 december 2003 11:58
> To: Nicklas Bondesson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: IDE-RAID Drive Performance 
> 
> 
> Every experience i had with Promise controllers AND linux 2.4.xx where xx is
>> 17 has given me troubles both on x86 and sparc architecture with DMA
> enabled.  
> 
> But i do not have enough time to troubleshoot this and i never got much
> attention here probably because i do not have any ooops or more specific
> data to report!  
> 
> Besides that, my maxtor 40gb (dont remember model right now) does about
> 40mb/sec instead of yours 25.  
> 
> Nicklas Bondesson Scrive:  
> 
>> Hi!  
>> 
>> I think i'm getting really bad values from my disks. It's two Western 
>> Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to 
>> a Promise TX2000 (PDC20271) card (RAID1 using ataraid). 
>> 
>> The disks are setup with hdparm at boot time:  
>> 
>> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda /sbin/hdparm -X69 -d1 -u1 
>> -m16 -c3 /dev/hdc 
>> 
>> When running hdparm -tT I get the following:  
>> 
>> /dev/hda:
>>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>>  Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec 
>> 
>> /dev/hdc:
>>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>>  Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec 
>> 
>> Are these normal values? I don't think so. Please advise.  
>> 
>> /Nicke 
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-ide" 
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>   
> 
 
