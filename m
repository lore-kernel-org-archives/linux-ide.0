From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/1] libata: pata_pdc2027x PLL input clock fix
Date: Thu, 16 Aug 2007 15:11:02 -0400
Message-ID: <46C4A146.6090701@garzik.org>
References: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56437 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbXHPTLK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 15:11:10 -0400
In-Reply-To: <200707092304.l69N4Ggd023137@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: albertl@mail.com, alan@lxorguk.ukuu.org.uk, bahadir.balban@gmail.com, dwm@enoyolf.org, linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, sshtylyov@ru.mvista.com

Mikael Pettersson wrote:
> (cc:ing linuxppc-dev)
> 
> On Tue, 26 Jun 2007 13:43:15 +0800, Albert Lee wrote:
>> Recently the PLL input clock of pata_pdc2027x is sometimes detected
>> higer than expected (e.g. 20.027 MHz compared to 16.714 MHz).
>> It seems sometimes the mdelay() function is not as precise as it
>> used to be. Per Alan's advice, HT or power management might affect
>> the precision of mdelay().
>>
>> This patch calls gettimeofday() to mesure the time elapsed and
>> calculate the PLL input clock accordingly.
> 
> Unfortunately this breaks pata_pdc2027x on my PowerMac G3:

Did this ever get resolved?

	Jeff



