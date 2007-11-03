From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Bart's efforts?
Date: Sat, 3 Nov 2007 19:23:22 +0100 (MET)
Message-ID: <200711031823.lA3INMCe007081@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:44232 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756259AbXKCSXg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Nov 2007 14:23:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: alan@lxorguk.ukuu.org.uk, greg.freemyer@gmail.com
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
>> 2) pata_pdc202xx_old can't do UDMA on my 440BX PIII box
>
>Bug # ?

No bz # yet, but you and I had a private email conversation about
this on March 13 and 15 this year.

There's been a couple of recent reports to linux-ide with identical
(as far as I can see) issues as I get:
<http://marc.info/?l=linux-ide&m=119152811824641&w=2>
<http://marc.info/?l=linux-ide&m=118890476223188&w=2>
<http://marc.info/?l=linux-ide&m=118855473322630&w=2>

I'll add a bugzilla entry for this next week so it doesn't get lost.

>> 3) pata_legacy doesn't release io/irq combinations for failed
>>    probes, causing conflicts with drivers loaded later on
>
>In my tree it does but I'm still testing some bits.

Good news.

/Mikael
