From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Tue, 22 Jan 2008 11:26:38 +0900
Message-ID: <4795545E.5010908@gmail.com>
References: <4794459C.3090200@gmail.com> <47944913.6000603@gmail.com> <4794CB8B.1070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:36051 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752236AbYAVC0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 21:26:44 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1970463rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 18:26:43 -0800 (PST)
In-Reply-To: <4794CB8B.1070600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Evans <evans02472@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Hello, Thomas.

Thomas Evans wrote:
>> What do you mean by eSata PMP enclosure?  Is it a different PMP device?
>>   
> It is an external PMP box, 5 drive bays - it is the exact same
> manufacturer and is based on the same PMP:
> 0x1095:0x4726 r31, 7 ports, feat 0x1/0x9

Okay.

>>> I can hook the card and storage enclosure to a windows box and can see
>>> the PM and the drives (and the config space).
>>
>> Hmmm.......
>>   
> Yeah - I was perplexed at this point as well ...  I even upgraded the
> BIOS in the card, just hoping ...

Can you install linux on a x86 machine and see whether anything is
different?

> I've attached a few logs - one that references how things looked when it
> all worked.
> I've logs of both the original Norco 4618 card (lspci64.2 and
> dmesg.txt.2) and with the
> newer generic 3124 card (dmesg.txt.newcard lspci.newcard.2).

Hmmm.........

 I'm not so good with deciphering the PCI-isms - maybe I just need a
> shorter cable now!?

I have no idea but trying a shorter cable is definitely an option.

Thanks.

-- 
tejun
