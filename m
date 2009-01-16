From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2 v1] pata_via.c:  support VX855 and future chips whose
 IDE controller use 0x0571.
Date: Fri, 16 Jan 2009 15:15:27 +0300
Message-ID: <49707A5F.7030109@ru.mvista.com>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC5C6@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:47155 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755102AbZAPMPe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Jan 2009 07:15:34 -0500
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8087EC5C6@exchtp03.taipei.via.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: JosephChan@via.com.tw
Cc: alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org, tj@kernel.org

Hello.

JosephChan@via.com.tw wrote:

>> The patch adds entries for 0xFFFF (is that really right) as a 
>> bridge and
>> 0xC409 - I see nothing for 0x0571.
>>     
>
> PCI_DEVICE_ID_VIA_ANON is used to stand for Unknown South Bridge for VX855
> and future chips, since the pata_via has a southbridge check, which is redundant.

   If it was redundant, it wouldn't have been there...

> If we may VIA has a new SB with new bridge ID which in not in the check list, whose 
> IDE controller is 0x0571. Linux default pata_via can not drive IDE controller of 402, since
> the southbridge check in pata_via can not pass. 
>   
> So we add PCI_DEVICE_ID_VIA_ANON to stand for our future southbridge,
> and this will help to pass southbridge check.
>   

   Why not just add the new and future SB device IDs to the list?

> Is it possible to do this way? And can it be acceptable in kernel policy?
>   

   I doubt it...

MBR, Sergei


