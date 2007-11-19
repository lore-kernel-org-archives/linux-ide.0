From: Tejun Heo <htejun@gmail.com>
Subject: Re: stable basic 4-port SATA card
Date: Mon, 19 Nov 2007 16:25:02 +0900
Message-ID: <47413A4E.5070604@gmail.com>
References: <200711151001.lAFA11wC019059@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:21779 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbXKSHZK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Nov 2007 02:25:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1346749rvb
        for <linux-ide@vger.kernel.org>; Sun, 18 Nov 2007 23:25:09 -0800 (PST)
In-Reply-To: <200711151001.lAFA11wC019059@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: jeff@jab.org, alan@lxorguk.ukuu.org.uk, hancockr@shaw.ca, jeff@garzik.org, liml@rtr.ca, linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> On Thu, 15 Nov 2007 12:32:14 +0900, Tejun Heo wrote:
>> * sata_promise: Generally works okay; however there are still some
>> problems with recent 3Gbps chips. (Mikael, please pitch in)
> 
> Right, 2nd-gen 3Gbps chips have had "intermittent" issues,
> which we hope are cured by the recent ASIC bug workaround,
> but it will take a while for that fix to propagate out.
> To speed up that process I'm considering backporting the fix
> to 2.6.23 and 2.6.22.
> 
> NCQ and PMP are supported in the hardware and in the vendor's
> driver, but not yet in sata_promise. My intention is to add
> NCQ soon, but there's no time-plan yet for this.

Thanks all.  I'll incorporate the info here into linux-ata.org when it
gets wikified.

-- 
tejun
