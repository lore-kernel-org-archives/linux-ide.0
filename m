From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI: using bios after linux
Date: Tue, 23 Oct 2007 17:26:11 +0900
Message-ID: <471DB023.4040505@gmail.com>
References: <482039.11674.qm@web32910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:33642 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbXJWI0V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 04:26:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1422256rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 01:26:20 -0700 (PDT)
In-Reply-To: <482039.11674.qm@web32910.mail.mud.yahoo.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Xiang Xu <xuxiang_ins@yahoo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, msundius@u1.netgate.com, msundius@sundius.com, linux-ide@vger.kernel.org

Xiang Xu wrote:
>>> 3) related to #1 above, we want to be invisable.
>> so we're not looking to
>>> switch from AHCI (to legacy), we are looking to
>> continue in whatever mode
>>> the BIOS started in. Thus we just want BIOS to be
>> able to handle int13 calls
>>> after the Linux AHCI driver has run (this works
>> when BIOS is setup in 
>>> legacy mode initially).
>> So load the ata_piix driver and not the AHCI one and
>> I think it'll work
>> out ?
>>
> 
> Just want to add some background info here, our
> product will be deployed on thousands of boxes, so
> it's not advisable for our product to require the
> users to change the default setting of BIOS from AHCI
> to Normal mode. I am just thinking wild here so please
> bear with me, but I am wandering if there is a way to
> load the ata_piix driver with BIOS setting to AHCI
> mode? Any pointer will be greatly appreciated.

The only sensible way to maintain BIOS setting would be to not load
native drivers at all and make BIOS calls for disk IO (from the IO
driver, switch to real mode, make BIOS call, exit real mode, return
data).  That will be extremely gloss but should be doable in principle.
 You don't need high performance IO, right?

-- 
tejun
