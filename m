From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 11:32:11 -0400
Message-ID: <45FAB87B.3050305@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca> <45FA8D7A.3040504@rtr.ca> <45FAA35C.2090902@ru.mvista.com> <45FAA822.7050208@rtr.ca> <45FAAACE.6000503@ru.mvista.com> <45FAACD4.6000709@rtr.ca> <45FAAD11.9010905@rtr.ca> <45FAB662.2040901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ottawa-hs-64-26-128-89.s-ip.magma.ca ([64.26.128.89]:1072 "EHLO
	mail.rtr.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753536AbXCPPcN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Mar 2007 11:32:13 -0400
In-Reply-To: <45FAB662.2040901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

> I think it only requires the *host* to drop to PIO0 timings.
> In which case it should be achievable w/o libata modification --
> if the driver has to "snoop" command and turn off prefetch,
> why not switch to PIO0 temporarily? 

Because (1) it is not actually necessary in practice,
and (2) see point (1),
and (3) that would only be half of the story,
in that it would need to be turned back on again afterwards,
and (4) not all drivers support PIO mode changes.

Cheers
