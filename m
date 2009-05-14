From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Thu, 14 May 2009 20:36:39 +0400
Message-ID: <4A0C4897.5050207@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <4A08079A.9080803@inov.pt> <4A09A8A1.5070002@ru.mvista.com> <200905121923.08159.bzolnier@gmail.com> <4A0C470B.8040609@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8560 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751101AbZENQgA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 May 2009 12:36:00 -0400
In-Reply-To: <4A0C470B.8040609@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello, I wrote:

>>>>> I'm not sure what you're getting at with "such advices"... :)

>>>>> We need to cast somewhere anyway so we may as well cast from 'void 
>>>>> *' to
>>>>> 'unsigned int' where needed and not the other way around (or rather 
>>>>> from
>>>>> 'unsigned int' to 'struct ide_timing *') -- which would be an ugly 
>>>>> hack
>>>>> and could cause maintainability/portability problems later.

>>>>> BTW it seems like a good occasion to add ide_{get,set}_drivedata() 
>>>>> helpers
>>>>> (ala existing ide_{get,set}_hwifdata() ones) to <linux/ide.h> and 
>>>>> thus make
>>>>> internal IDE API more coherent.

>>>>> [ Yes, I know that we may get away with s/unsigned int/unsigned long/
>>>>>  and casting it to 'struct ide_timing *' for now but it always better
>>>>>  to at least consider more elegant solution first... ]

>>>    Changing a lot of drivers is more elegant than not? Doubt it.

>>>    And don't tell me this patch is "elegant"... :-/

>> Well, it is makes code more coherent and more maintainable...

>> Moreover those inline helpers serve as a part of documentation (though
>> real DocBook documentation would also be nice) for host drivers authors.

>> Either this or we should remove ide_{get,set}_hwifdata() and allow
>> host drivers to poke directly also at hwif->hwif_data...

    Besides, some drivers like siimage.c do poke hwif->hwif_data directly.

>    Seems like a good idea. I'm not sure why these fields should be special.

    While there are a number of 'ide_hwif_t' fields like 'select_data' or 
'config_data' that are being poked directly...

MBR, Sergei
