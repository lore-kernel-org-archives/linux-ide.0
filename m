From: Walt H <walt_h@lorettotel.net>
Subject: Re: 2.6.19-rc2 - Cable detection problem in pata_amd
Date: Tue, 24 Oct 2006 17:19:55 -0500
Message-ID: <453E918B.4020909@lorettotel.net>
References: <453D5067.9070407@lorettotel.net> <1161698939.22348.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dialup-63-108-131-26.nehp.net ([63.108.131.26]:31421 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S1422718AbWJXWUA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Oct 2006 18:20:00 -0400
In-Reply-To: <1161698939.22348.33.camel@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
> Ar Llu, 2006-10-23 am 18:29 -0500, ysgrifennodd Walt H:
>> On bootup, the pata_amd driver mis-detects the cable connected to the
>> 2nd port on my system as 40 wire and sets UDMA/33 for this drive. Prior
> 
> Can you stick it in bugzilla.kernel.org and assign it to me. Also attach
> an lspci -vxxx. There is a bug or two somewhere in this area still but
> I'm very busy at the moment with other stuff so don't want your report
> to go in one ear and out of the other in a couple of days then get
> forgotten.
> 
> 
> 

Will do.  Bugzilla # is 7411.  Oh, I noticed that I specified kernel
<2.6.19-rc2 in the bugzilla entry, but this occurs in all versions I've
tested, including 2.6.19-rc2.  Thanks,

-Walt

