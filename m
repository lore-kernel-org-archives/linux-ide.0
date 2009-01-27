From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 3)
Date: Tue, 27 Jan 2009 08:49:05 -0500
Message-ID: <497F10D1.5020400@pobox.com>
References: <200901271619.53025.sshtylyov@ru.mvista.com> <20090127133841.2405e649@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56725 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175AbZA0NtU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 08:49:20 -0500
In-Reply-To: <20090127133841.2405e649@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

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

I'll send it upstream, thanks all!


