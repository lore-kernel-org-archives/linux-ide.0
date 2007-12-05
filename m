From: Mark Paulus <mark.paulus@verizonbusiness.com>
Subject: Re: sata_sil issue on 2.6.22
Date: Wed, 05 Dec 2007 07:49:36 -0700
Message-ID: <4756BA80.1020902@verizonbusiness.com>
References: <47434526.7010304@verizonbusiness.com> <474CC29E.8020102@gmail.com>
 <475032AF.6090001@verizonbusiness.com> <4754C15C.1020107@gmail.com>
 <4756B5B2.1010302@verizonbusiness.com> <4756B6D3.9020307@gmail.com>
Reply-To: mark.paulus@verizonbusiness.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------050304060305090703050704
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from omzesmtp04.mci.com ([199.249.17.14]:60178 "EHLO
	omzesmtp04.mci.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbXLEOtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Dec 2007 09:49:31 -0500
Received: from pmismtp01.mcilink.com ([166.37.158.161])
 by firewall.verizonbusiness.com (Iplanet MTA 5.2)
 with ESMTP id <0JSK00906ZUHPU@firewall.verizonbusiness.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:49:29 +0000 (GMT)
Received: from pmismtp01.mcilink.com ([127.0.0.1])
 by pmismtp01.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with SMTP id <0JSK00GQ2ZUGFR@pmismtp01.mcilink.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:49:28 +0000 (GMT)
Received: from [127.0.0.1] ([166.34.133.85])
 by pmismtp01.mcilink.com (iPlanet Messaging Server 5.2 HotFix 2.08 (built Sep
 22 2005)) with ESMTP id <0JSK00H2XZUEQV@pmismtp01.mcilink.com> for
 linux-ide@vger.kernel.org; Wed, 05 Dec 2007 14:49:28 +0000 (GMT)
In-reply-to: <4756B6D3.9020307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------050304060305090703050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Tejun Heo wrote:
> Mark Paulus wrote:
>> Well, I feel foolish. 
>> One problem is that the prebuilt kernel is using an initrd
>> image, so I made your patch changes, and put them into
>> /lib/modules/`uname -r`/kernel/drivers/ata/sata_sil.ko,
>> and guess what, they never got loaded.  Foolishness on my
>> part.
>>
>> Anyway, this time I got to the single boot prompt, where I did
>> a 'rmmod sata_sil', and a 'modprobe sata_sil', and I know
>> it loaded the new version, because you can see the 'sata_sil
>> 0000:02:0b.0: version 2.2b', which I put in
>> to verify what the heck is going on.
>> This machine is pretty slow to compile the kernel, which is
>> why I was trying to short cut the build/install some, but I might try to
>> build the kernel on a faster machine and see if
>> I can get the initrd image rebuilt also.
> 
> This one is good enough, thanks.  It seems the controller is raising
> spurious SATA_IRQ.  I wonder why.  You're using a SATA-PATA bridge,
> right?  What chip are you using?
> 
Yes, I am.  It's a SD-ADSAIDE-S1, with a 
sil3611ct80 chip on board.

My question would be, what makes the 2.6.22 kernel different enough
than the 2.6.18 kernel that this setup is causing problems in .22.
Is .18 masking the problems, or is .22 just looking at things with
tighter tolerences, so it's more sensitive?
-- 
Mark Paulus
2424 Garden of the Gods Rd  | Phone:  v622-5578 / 719-535-5578
0419/117 - LEC Access ; D5-1010   | FAX:    719-535-1665
Colo Springs, CO  80919    | 1800PageMCI / 1406052
AIM : mgpaulus1    /  sametime : mark.paulus


--------------050304060305090703050704
Content-Type: text/x-vcard; charset=utf-8;
 name="mark_paulus.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mark_paulus.vcf"

begin:vcard
fn:Mark Paulus
n:Paulus;Mark
org:MCI;Lec Interfaces / 40419
adr;dom:;;2424 Garden of the Gods Rd;Colorado Springs;CO;80919
email;internet:mark.paulus@verizonbusiness.com
title:Mark Paulus
tel;work:719-535-5578
tel;pager:800-pagemci / 1406052
tel;home:v622-5578
version:2.1
end:vcard


--------------050304060305090703050704--

