From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 3)
Date: Tue, 27 Jan 2009 10:56:29 -0500
Message-ID: <497F2EAD.4080705@rtr.ca>
References: <200901271619.53025.sshtylyov@ru.mvista.com> <20090127133841.2405e649@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:35606 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbZA0P4b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 10:56:31 -0500
In-Reply-To: <20090127133841.2405e649@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Alan Cox wrote:
> On Tue, 27 Jan 2009 17:19:52 +0400
> Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> 
>> When checking for the CFA feature set support, ata_id_is_cfa() tests bit 2 in
>> word 82 of the identify data instead the word 83;  it also checks the ATA/PI
>> version support in the word 80 (which the CompactFlash specifications have as
>> reserved), this having no slightest chance to work on the modern CF cards that
>> don't have 0x848A in the word 0...
>>
>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> Acked-by: Alan Cox <number6@the-village.bc.nu>
..

Any chance you two could figure out this one below?
It *is* a CF card, but doesn't show up as such.

/dev/sda:
044a 3fff 0000 000f 0000 0240 003f 03bc
0000 0000 5052 4554 4543 2020 2020 2020
3031 3233 3541 4545 0002 0002 0004 3230
3038 3038 3035 4346 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8001
0000 0300 0000 0200 0000 0007 3fff 000f
003f 3c4f 00ec 0100 0000 03bc 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0010 0000 700b 400c 4003 0001 0000 0003
207f 0001 0000 0000 fffe 600f 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0009 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
81f4 0000 0000 0092 001b 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
