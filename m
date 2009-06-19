From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA: link online but device misclassified
Date: Fri, 19 Jun 2009 13:00:09 +0900
Message-ID: <4A3B0D49.8070802@gmail.com>
References: <cfa4e840906101715r56b643f4tab58e1c859d119ba@mail.gmail.com>	 <4A308798.6060803@gmail.com>	 <cfa4e840906110231u4e90eb22wbeb2d4e748c5624a@mail.gmail.com>	 <1244746872.3998.88.camel@mulgrave.site>	 <cfa4e840906111232i52decee3mf9ab2d0abcaa78d9@mail.gmail.com>	 <cfa4e840906160759m31db333cr555104ca0e3c6255@mail.gmail.com>	 <cfa4e840906160803h3364ac8aqfd78405dbcc512df@mail.gmail.com> <1245165697.3965.40.camel@mulgrave.site> <4A3AEC08.4060507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:44084 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbZFSEFW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Jun 2009 00:05:22 -0400
Received: by pxi27 with SMTP id 27so1508883pxi.33
        for <linux-ide@vger.kernel.org>; Thu, 18 Jun 2009 21:05:24 -0700 (PDT)
In-Reply-To: <4A3AEC08.4060507@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Marc Bowes <marcbowes@gmail.com>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> On 06/16/2009 09:21 AM, James Bottomley wrote:
>> On Tue, 2009-06-16 at 17:03 +0200, Marc Bowes wrote:
>>> Sorry to bother, but this is really bugging me! I can't seem to find
>>> anybody
>>> else with the same problem. What steps should I be taking to figure this
>>> out? I'm thinking I should be trying other kernel versions and/or
>>> plugging
>>> drives in different places. I don't think the motherboard is faulty,
>>> and I
>>> seem to be getting good speeds (~70mbs) to all four drives.
>>
>> Well, those are on the AHCI built in controller. The one with the slow
>> response is the empty JMicron 20360/20363.  But why this should be so,
>> I've no idea ... it looks like the AHCI driver can't tell the phys are
>> empty for some reason, which could be due to many things.
> 
> I would suspect it's a hardware problem that we can't do much about..
> For some reason the controller is reporting the SATA link is online at
> 3Gbps when there's actually nothing connected. We try to repeatedly
> reset the "device" as it doesn't respond properly, until we finally give
> up.
> 
> Can you disable that JMicron controller in the BIOS somehow?

It could be some storage controller hanging off there.  Some revisions
of SIMG PMPs operating in raid mode keep the link online while failing
to respond to reset if the downstream ports are empty.  Marc, which
motherboard are you using?  Can you please post the output of
dmidecode?

Thanks.

-- 
tejun
