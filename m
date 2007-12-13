From: Patric Karlsson <patric@ce.chalmers.se>
Subject: Re: stable basic 4-port SATA card
Date: Thu, 13 Dec 2007 14:37:14 +0100
Message-ID: <fjrci9$v8o$1@ger.gmane.org>
References: <200711151001.lAFA11wC019059@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:60298 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759290AbXLMNpI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Dec 2007 08:45:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J2oKw-0003BA-9e
	for linux-ide@vger.kernel.org; Thu, 13 Dec 2007 13:42:50 +0000
Received: from lx32.ce.chalmers.se ([129.16.20.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 13:42:50 +0000
Received: from patric by lx32.ce.chalmers.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 13 Dec 2007 13:42:50 +0000
In-Reply-To: <200711151001.lAFA11wC019059@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

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
> 
> /Mikael
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Backporting would be nice, since we're still some ways from a stable 
2.6.24, and I'm not comfortable running -rc kernels in production 
enviroments.

