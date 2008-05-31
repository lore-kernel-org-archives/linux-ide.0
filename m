From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Sat, 31 May 2008 09:49:09 +0900
Message-ID: <4840A085.2080101@gmail.com>
References: <200803091922.33083.volker.armin.hemmann@tu-clausthal.de> <200805291654.03617.volker.armin.hemmann@tu-clausthal.de> <483F804F.1@gmail.com> <200805301243.39751.volker.armin.hemmann@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:31782 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYEaAtQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 May 2008 20:49:16 -0400
Received: by rv-out-0506.google.com with SMTP id l9so99466rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 30 May 2008 17:49:15 -0700 (PDT)
In-Reply-To: <200805301243.39751.volker.armin.hemmann@tu-clausthal.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
Cc: Peer Chen <pchen@nvidia.com>, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Kuan Luo <kluo@nvidia.com>

Hemmann, Volker Armin wrote:
> On Freitag, 30. Mai 2008, Tejun Heo wrote:
>> Hello,
>>
>> Hemmann, Volker Armin wrote:
>>> -AHCI+nomsi: boots fine. Works fine. But: I still can not enable ncq
>>> -AHCI+msi: the usual. No harddisks found, waiting for the timeouts, then
>>> kernel panic because of missing root.
>>>
>>> -NON-RAID/IDE+msi: works fine. No delays. No NCQ (not surprising since
>>> mobos handbook says that AHCI mode is required).
>>> -NON-RAID/IDE+nomsi: see above.
>> So, sans NCQ, the only remaining issue is MSI, right?  Peer Chen, please
>> lemme know which controllers are affected by this MSI problem and where
>> the problem lies.
> 
> this is correct.
> 
>> The controller is not reporting NCQ capability in its cap register
>> (flags: line contains ncq if the controller is), so NCQ is not enabled.
> 
> ah, I thought all AHCI chipsets support NCQ (and the board's handbook lists it 
> as feature) thanks for the explanation.

It could be that the controller has ahci support but it just forgets to
set the corresponding cap bit.  Peer Chen, Kuan Luo, can you guys please
comment on the 64bit and ncq problems?

Thanks.

-- 
tejun
