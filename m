From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 14:49:42 +0300
Message-ID: <497DA356.2090206@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com> <20090125105045.65021406@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:56108 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751318AbZAZLts (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 06:49:48 -0500
In-Reply-To: <20090125105045.65021406@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello.

Alan Cox wrote:

>> bit scan). Note that words 64-127 were marked reserved, and must be set 
>> to 0 since ATA-1. Have your say please -- do I still need to recast the 
>> patch?
>>     
>
> "Must be" but were not.
>   

  Let's see what ATA-3 rev. 7b has to say on this matter:

7.7.38 Words 82-83: Command sets supported

Words 82 and 83 indicate command sets supported. The values 0000h and 
FFFFh in these words indicate
that command set support is not indicated. Bits 4 through 15 of Word 82 
are reserved. Bits 0 through 13 of
Word 83 are reserved. Bit 14 of Word 83 shall be set to one. Bit 15 of 
Word 83 shall be cleared to zero.

   ATA/PI-4 rev. 18 further clarifies:

8.12.45 Words 82-84: Features/command sets supported

Words 82, 83, and 84 shall indicate features/command sets supported. The 
value 0000h or FFFFh was
placed in each of these words by devices prior to ATA-3 and shall be 
interpreted by the host as meaning
that features/command sets supported are not indicated. Bits 1 through 
13 of word 83 and bits 0 through 13
of word 84 are reserved. Bit 14 of word 83 and word 84 shall be set to 
one and bit 15 of word 83 and word
84 shall be cleared to zero to provide indication that the 
features/command sets supported words are valid.

   Since checking bits 14-15 filters out both 0 and 0xFFFF, I don't see 
why we have to check for ATA revision prior to that -- unless we're 
trying to guard against pre ATA-3 values other than 0 or 0xFFFF.

MBR, Sergei


