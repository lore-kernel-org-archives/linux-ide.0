From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 02 Jul 2007 15:20:58 -0400
Message-ID: <4689501A.9030409@garzik.org>
References: <200706302110.20766.bzolnier@gmail.com>	<46891CD4.7020703@ru.mvista.com>	<200707021956.32844.bzolnier@gmail.com>	<46893D42.9070603@garzik.org> <20070702202231.33ffe36e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53865 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753282AbXGBTVB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Jul 2007 15:21:01 -0400
In-Reply-To: <20070702202231.33ffe36e@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I am not ready to trust that pata_ali works as well as alim15x3 in all 
>> cases.  Someone should test e.g. Alpha AXP systems with IDE (use 
>> alim15x3) to make sure all is well.
> 
> My pata_ali is reported to do so. I don't know if yours does because my

Good to hear, thanks for the info.  Maybe we can get Al to give my old 
DS10 a try with pata_ali...

	Jeff



