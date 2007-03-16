From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 16:38:25 -0400
Message-ID: <45FB0041.8050801@pobox.com>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com> <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca>	<45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com>	<45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com>	<45FAACD4.6000709@rtr.ca> <45FAAD11.9010905@rtr.ca>	<45FAB662.2040901@ru.mvista.com> <20070316170802.227ff58b@lxorguk.ukuu.org.uk> <45FAE7F3.7050201@pobox.com> <45FAFB24.2050800@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:33855 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965910AbXCPUif (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 16:38:35 -0400
In-Reply-To: <45FAFB24.2050800@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Mikael Pettersson <mikpe@it.uu.se>

Mark Lord wrote:
> Jeff Garzik wrote:
>> Alan Cox wrote:
>>>>     I think it only requires the *host* to drop to PIO0 timings.  In 
>>>> which case it should be achievable w/o libata modification -- if the 
>>>> driver has to "snoop" command and turn off prefetch, why not switch 
>>>> to PIO0 temporarily?
>>>
>>> This isn't a big issue. Eventually we have to support sending speed
>>> change commands and once we do that the caller will be able to switch to
>>> PIO0 and back again.
>>
>> We should be pretty close to that.  One of the bigger blockages is 
>> needing to stop (freeze) all ports, before performing an out-of-band 
>> SET FEATURES and related tuning.
> 
> For this particular feature, READ/WRITE LONG,
> none of this is actually necessary in practice on common controllers.
> 
> I've tested ATA1 and newer PATA drives, and various SATA drives
> with these commands without bothering to drop to PIO0,
> and none of them had issues.

I wasn't implying a blockage of your patch, just describing a general 
problem within libata.

	Jeff



