From: "Willy Gardiol" <willy@gardiol.org>
Subject: Re: IDE-RAID Drive Performance
Date: Tue, 30 Dec 2003 11:57:33 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20031230105733.28287.qmail@webmaildomini2.aruba.it>
References: <S265746AbTL3Klr/20031230104147Z+18382@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [62.149.128.211] ([62.149.128.211]:31388 "HELO
	webmaildomini2.aruba.it") by vger.kernel.org with SMTP
	id S265744AbTL3K5g (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Dec 2003 05:57:36 -0500
In-Reply-To: <S265746AbTL3Klr/20031230104147Z+18382@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: linux-ide@vger.kernel.org


Every experience i had with Promise controllers AND linux 2.4.xx
where xx is > 17 has given me troubles both on x86 and sparc architecture 
with DMA enabled. 

But i do not have enough time to troubleshoot this and i never got much 
attention here probably because i do not have any ooops or more specific 
data to report! 

Besides that, my maxtor 40gb (dont remember model right now) does about 
40mb/sec instead of yours 25. 

Nicklas Bondesson Scrive: 

> Hi! 
> 
> I think i'm getting really bad values from my disks. It's two Western
> Digital WD800JB-00DUA3 (Special Edition 8 MB cache) disks connected to a
> Promise TX2000 (PDC20271) card (RAID1 using ataraid). 
> 
> The disks are setup with hdparm at boot time: 
> 
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hda
> /sbin/hdparm -X69 -d1 -u1 -m16 -c3 /dev/hdc 
> 
> When running hdparm -tT I get the following: 
> 
> /dev/hda:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>  Timing buffered disk reads:  64 MB in  2.46 seconds = 26.02 MB/sec 
> 
> /dev/hdc:
>  Timing buffer-cache reads:   128 MB in  1.13 seconds =113.27 MB/sec
>  Timing buffered disk reads:  64 MB in  2.47 seconds = 25.91 MB/sec 
> 
> Are these normal values? I don't think so. Please advise. 
> 
> /Nicke 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
 
