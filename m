From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 23:23:20 +0300
Message-ID: <497E1BB8.8010408@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0F76.6020606@ru.mvista.com>	<20090126193550.27eef301@lxorguk.ukuu.org.uk>	<497E12BC.1080809@ru.mvista.com> <20090126195430.3a8aa1ce@lxorguk.ukuu.org.uk> <497E1700.8090206@ru.mvista.com> <497E191A.1040902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4627 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752474AbZAZUWv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:22:51 -0500
In-Reply-To: <497E191A.1040902@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello.

Jeff Garzik wrote:

>>>>>>> +    if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
>>>>>>> +        return 0;
>>>>>>> +    return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;

>>>>>>   Refer to afa_dev_cf_sata() on how it's done in really optimal way.

>>>>> To what ? - there is no ata or afa_dev_cf_sata ?

>>>>    Very funny. Meant to be ata_dev_is_sata(), of course.

>>> We don't have one of those either - do you mean ata_id_is_sata ? If so
>>> then yes that looks like it might be slightly cleaner although its
>>> probably one instruction difference from the .s files.

>>    That extra *if* cost more than instruction I think.

> Either way, this is irrelevant, since this isn't used in any hot path 
> that I am aware of... :)

> Alan just posted a reasonable explanation in the "The logic is this" 
> email, maybe we can reboot the discussion from there?

    Please read all the thread, and you'll see that Alan's CFA patch was 
totally wrong in that part from the very start -- CF devices don't report ATA 
standard support in word 80, that's forbidden (!) by the CF specs since at 
least 2.1.

> Responding to a side point, I don't think its a big deal to combine 
> fixes and improvements into a single patch, if you are dealing with the 
> same few lines of code.

    Not the case here -- the fix is very local, improvements are spread over 
several inlines.

>     Jeff

MBR, Sergei
