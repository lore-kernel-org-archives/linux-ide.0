From: "Willy Gardiol" <willy@gardiol.org>
Subject: Re: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 16:21:52 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031230152152.2150.qmail@webmaildomini1.aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.149.128.210] ([62.149.128.210]:23779 "HELO
	webmaildomini1.aruba.it") by vger.kernel.org with SMTP
	id S265800AbTL3PVz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2003 10:21:55 -0500
List-Id: linux-ide@vger.kernel.org
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-ide@vger.kernel.org


no, it is 4.648 kb/sec has it says on top.
It is right, you must check the "block" section, not the "char" section.
Reading char by char is always a pain. 

Indeed 20/24mb/sec is a small figure for your disks, i get up to 35mb/sec 
for one drive and 75mb/sec for raid0. 

Try to connect the disks on the onboard controller of the mainboard and run 
again bonnie, just to check if it is a ocntroller issue. 

Nicklas Bondesson Scrive: 

> This is what I get using bonnie: 
> 
> Is this correct 46.48 MB / sec ? 
> 
> gollum:~# bonnie -s 800 -u root
> Using uid:0, gid:0.
> Writing with putc()...done
> Writing intelligently...done
> Rewriting...done
> Reading with getc()...done
> Reading intelligently...done
> start 'em...done...done...done...
> Create files in sequential order...done.
> Stat files in sequential order...done.
> Delete files in sequential order...done.
> Create files in random order...done.
> Stat files in random order...done.
> Delete files in random order...done.
> Version 1.02b       ------Sequential Output------ --Sequential Input-
> --Random-
>                     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block--
> --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec
> %CP
> gollum         800M  4648  98 19443  37  8422  14  4859  94 24766  17 282.8
> 2
>                     ------Sequential Create------ --------Random
> Create--------
>                     -Create-- --Read--- -Delete-- -Create-- --Read---
> -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
> %CP
>                  16   306  99 +++++ +++ 20985  99   319  99 +++++ +++  1683
> 97
> gollum,800M,4648,98,19443,37,8422,14,4859,94,24766,17,282.8,2,16,306,99,++++
> +,++
> +,20985,99,319,99,+++++,+++,1683,97  
> 
> -----Original Message-----
> From: linux-ide-owner@vger.kernel.org
> [mailto:linux-ide-owner@vger.kernel.org] On Behalf Of Willy Gardiol
> Sent: den 30 december 2003 12:12
> To: Nicklas Bondesson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: IDE-RAID Drive Performance 
> 
> 
> Check you are using 80pin cables... but -X69 would fail if not.
> PCI bus should not be to blame for this, unless your is overloaded (?) like
> heavy network traffic (fast or gigabit ethernet) may steal PCI cycles, but i
> have never seen this happen in pc's...  
> 
> Maybe check your card is not sharing an IRQ, move into another slot, try
> some fixed allocation from BIOS to avoid this...
> But i whouldnt expect too much from this on the speed side (just in case
> some troubles with IRQ sharing).  
> 
> Are you using the new pdc driver? The new one is the one supporting newer
> chipsets like the 20271, i do not know which chip your promise has.  
> 
> Try Bonnie to get some real on-the-road measurement from ypur filesystems... 
> 
> that is the REAL speed you can get from your disks.  
> 
> 
> Nicklas Bondesson Scrive:  
> 
>> Ok, so you currently don't have any suggestions on this? Could it be a 
>> slow PCI slot causing the poor performance? It's an ASUS P2B (rev 
>> 1.04) motherboard with PCI 2.1 enabled in BIOS. 
>> 
>> /Nicke 
>> 
>> -----Original Message-----
>> From: Willy Gardiol [mailto:willy@gardiol.org]
>> Sent: den 30 december 2003 11:58
>> To: Nicklas Bondesson
>> Cc: linux-ide@vger.kernel.org
>> Subject: Re: IDE-RAID Drive Performance 
>> 
>> 
>> Every experience i had with Promise controllers AND linux 2.4.xx where 
>> xx is
>>> 17 has given me troubles both on x86 and sparc architecture with DMA
>> enabled.   
>> 
>> But i do not have enough time to troubleshoot this and i never got 
>> much attention here probably because i do not have any ooops or more 
>> specific data to report! 
>> 
>> Besides that, my maxtor 40gb (dont remember model right now) does 
>> about 40mb/sec instead of yours 25. 
>> 
>> Nicklas Bondesson Scrive:   
>> 
>>> Hi!   
>>> 
>>> I think i'm getting really bad values from my disks. It's two Western 
>>> Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected 
>>> to a Promise TX2000 (PDC20271) card (RAID1 using ataraid). 
>>> 
>>> The disks are setup with hdparm at boot time:   
>>> 
>>> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda /sbin/hdparm -X69 -d1 -u1
>>> -m16 -c3 /dev/hdc 
>>> 
>>> When running hdparm -tT I get the following:   
>>> 
>>> /dev/hda:
>>>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>>>  Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec 
>>> 
>>> /dev/hdc:
>>>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>>>  Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec 
>>> 
>>> Are these normal values? I don't think so. Please advise.   
>>> 
>>> /Nicke 
>>> 
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe linux-ide" 
>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>>> info at  http://vger.kernel.org/majordomo-info.html
>>    
>> 
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html 
> 
 
