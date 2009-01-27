From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa() (take 3)
Date: Tue, 27 Jan 2009 19:21:05 +0300
Message-ID: <497F3471.1070707@ru.mvista.com>
References: <200901271619.53025.sshtylyov@ru.mvista.com> <20090127133841.2405e649@lxorguk.ukuu.org.uk> <497F10D1.5020400@pobox.com> <497F31A0.7010104@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:34587 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753199AbZA0QUg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jan 2009 11:20:36 -0500
In-Reply-To: <497F31A0.7010104@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello, I wrote:

>>>> When checking for the CFA feature set support, ata_id_is_cfa() tests 
>>>> bit 2 in
>>>> word 82 of the identify data instead the word 83;  it also checks 
>>>> the ATA/PI
>>>> version support in the word 80 (which the CompactFlash 
>>>> specifications have as
>>>> reserved), this having no slightest chance to work on the modern CF 
>>>> cards that
>>>> don't have 0x848A in the word 0...

>>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>> Acked-by: Alan Cox <number6@the-village.bc.nu>

>> I'll send it upstream, thanks all!

>    Hold up please, Mark gave us an example that it doesnt recognize 
> because it does report the ATA version in word 80.

    s/it/his card/

MBR, Sergei
