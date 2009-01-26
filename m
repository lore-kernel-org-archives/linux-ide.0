From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide/libata: fix ata_id_is_cfa()
Date: Mon, 26 Jan 2009 23:16:41 +0300
Message-ID: <497E1A29.2020004@ru.mvista.com>
References: <200901231615.38011.sshtylyov@ru.mvista.com>	<497B9EE4.8010807@ru.mvista.com>	<497E0548.80904@ru.mvista.com>	<20090126190801.7d198246@lxorguk.ukuu.org.uk>	<497E0F76.6020606@ru.mvista.com>	<20090126193550.27eef301@lxorguk.ukuu.org.uk>	<497E12BC.1080809@ru.mvista.com> <20090126195430.3a8aa1ce@lxorguk.ukuu.org.uk> <497E1700.8090206@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:4482 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752316AbZAZUQL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jan 2009 15:16:11 -0500
In-Reply-To: <497E1700.8090206@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, gdu@mns.spb.ru

Hello, I wrote:

>>>>>> +    if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
>>>>>> +        return 0;
>>>>>> +    return (id[ATA_ID_MAJOR_VER] & (1 << v)) ? 1 : 0;

>>>>>   Refer to afa_dev_cf_sata() on how it's done in really optimal way.

>>>> To what ? - there is no ata or afa_dev_cf_sata ?

>>>    Very funny. Meant to be ata_dev_is_sata(), of course.

>> We don't have one of those either - do you mean ata_id_is_sata ?

   Sure I have, just got used to its original name, ide_dev_is_sata().

>> If so then yes that looks like it might be slightly cleaner although its
>> probably one instruction difference from the .s files.

>    That extra *if* cost more than instruction I think.

    At least 2 on x86.

>> I'll redo it that way

>    OK, just leave ata_dev_is_cfa() alone and rename the patch.

    Just reposted my patch with better description.

MBR, Sergei
