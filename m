From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Fri, 16 Mar 2007 17:08:02 +0000
Message-ID: <20070316170802.227ff58b@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
	<45FA8D7A.3040504@rtr.ca>
	<45FAA35C.2090902@ru.mvista.com>
	<45FAA822.7050208@rtr.ca>
	<45FAAACE.6000503@ru.mvista.com>
	<45FAACD4.6000709@rtr.ca>
	<45FAAD11.9010905@rtr.ca>
	<45FAB662.2040901@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35822 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965405AbXCPQFp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Mar 2007 12:05:45 -0400
In-Reply-To: <45FAB662.2040901@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

>     I think it only requires the *host* to drop to PIO0 timings.  In which 
> case it should be achievable w/o libata modification -- if the driver has to 
> "snoop" command and turn off prefetch, why not switch to PIO0 temporarily?

This isn't a big issue. Eventually we have to support sending speed
change commands and once we do that the caller will be able to switch to
PIO0 and back again.

Alan
