From: Patrizio Bassi <patrizio.bassi@gmail.com>
Subject: Re: libata not working for sis5533
Date: Sun, 09 Sep 2007 13:35:26 +0200
Message-ID: <46E3DA7E.7060709@gmail.com>
References: <46D132C5.5000803@gmail.com> <6bffcb0e0708261627s12e5a9acqef92d0261264a40c@mail.gmail.com> <46D8921E.3010304@gmail.com> <46D89429.7080802@gmail.com> <20070902114032.7dbfb21a@the-village.bc.nu> <Pine.LNX.4.64.0709031957390.24179@fbirervta.pbzchgretzou.qr> <Pine.LNX.4.64.0709061156220.25942@fbirervta.pbzchgretzou.qr> <46E26DAF.9020906@gmail.com> <Pine.LNX.4.64.0709081243050.25942@fbirervta.pbzchgretzou.qr>
Reply-To: patrizio.bassi@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:4519 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbXIILfi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Sep 2007 07:35:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so389998ugc
        for <linux-ide@vger.kernel.org>; Sun, 09 Sep 2007 04:35:37 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709081243050.25942@fbirervta.pbzchgretzou.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Patrizio Bassi ha scritto:
> Jan Engelhardt ha scritto:
>> On Sep 8 2007 11:38, Patrizio Bassi wrote:
>>  
>>> Jan Engelhardt wrote:
>>>    
>>>> I shall give this a spin too, since I happen to have sis5513.
>>>>
>>>> Just booted this fresh ata-enabled system (a matter of mkinitrd).
It has
>>>> not exploded yet.
>>>>      
>>> don't you have the "irq 14" issue?
>>>    
>> No, does not seem so.
>>
>>  
>>> can you post here your .config?
>>>    
>> http://rafb.net/p/vfTX0966.html
>>
>> Maybe it is solved in 2.6.22.3? (I don't remember what your version
>> was.)
>>
>>
>>     Jan
>>  
>
> For Alan, libata devs...hope can help debug...
> this is http://www.patriziobassi.it/downloads/libata_issue.jpg
>
> and this is the relative config i'm using
> http://www.patriziobassi.it/downloads/config
>
> Let me know
>
> Patrizio

more debug:

I tried as suggested with the irqpoll option, i just get a faster panic
as i don't have the 3 xfermode lines...but always impossibile to boot...

Patrizio
