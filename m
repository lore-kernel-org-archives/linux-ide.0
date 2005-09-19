From: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Subject: Re: UDMA5
Date: Mon, 19 Sep 2005 17:33:48 +0200
Message-ID: <003f01c5bd2f$87bbedc0$1f01a8c0@Ric>
References: <011401c5b2b2$becb3b40$1f01a8c0@Ric> <007301c5b38d$78f3c750$1f01a8c0@Ric> <431F9236.1040801@yahoo.de> <000a01c5b445$f9570520$1f01a8c0@Ric> <431FF0EA.2090006@yahoo.de> <00a601c5b469$3a3cdc40$1f01a8c0@Ric> <43205F0C.10607@yahoo.de> <01da01c5bcfb$3b69cd90$1f01a8c0@Ric> <432E89E8.5090409@yahoo.de> <000a01c5bd2b$cd933ff0$1f01a8c0@Ric> <58cb370e05091908167d941bee@mail.gmail.com>
Reply-To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lisa.usl6.toscana.it ([159.213.44.2]:61125 "EHLO
	lisa.nord.usl6.toscana.it") by vger.kernel.org with ESMTP
	id S932467AbVISPc7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 19 Sep 2005 11:32:59 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com, Riccardo Castellani <r.castellani@usl6.toscana.it>
Cc: Stefan <gentoopower@yahoo.de>, linux-ide@vger.kernel.org

I think it's no kernel problem because after immediately POST stage (before 
that GRUB is loaded) I see hard disk properties where UDMA is set to 2 
value. PIO mode is set to 4.

----- Original Message ----- 
From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
To: "Riccardo Castellani" <r.castellani@usl6.toscana.it>
Cc: "Stefan" <gentoopower@yahoo.de>; <linux-ide@vger.kernel.org>
Sent: Monday, September 19, 2005 5:16 PM
Subject: Re: UDMA5


> On 9/19/05, Riccardo Castellani <r.castellani@usl6.toscana.it> wrote:
>> I run Maxtor MaxPower tool and HD test is ok.
>> I didn't see any settings to change UDMA mode.
>> I tried to run Knoppix live CD into machine and I had the same result: 
>> UDMA
>> 2*
>> I put this disk into another hardware and It worked in UDMA 6 !!!
>> What do you think ?
>
>>>>> Linux version 2.6.12-1.1376_FC3 (bhcompile@tweety.build.redhat.com)
>>>>> (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #1 Fri Aug 26 23:27:26
>>>>> EDT 2005
>
> Try with *vanilla* kernel 2.6.13 or 2.6.14-rc1.
> 

