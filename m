From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH, RFT, v4] sata_mv: convert to new EH
Date: Sat, 26 May 2007 17:38:38 -0400
Message-ID: <4658A8DE.80107@garzik.org>
References: <20070225233454.GA31282@havoc.gtf.org>	 <1173158201.3416.8.camel@obelisk.thedillows.org>	 <45ED039E.20608@garzik.org>	 <1173164261.3416.15.camel@obelisk.thedillows.org>	 <4656EB26.40504@garzik.org> <4657A678.8090308@garzik.org>	 <Pine.LNX.4.64.0705252335590.8327@twinlark.arctic.org>	 <46589F15.8080003@garzik.org> <1180213892.19231.6.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36209 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760309AbXEZVin (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 26 May 2007 17:38:43 -0400
In-Reply-To: <1180213892.19231.6.camel@obelisk.thedillows.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dave Dillow <dave@thedillows.org>
Cc: dean gaudet <dean@arctic.org>, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Dave Dillow wrote:
> On Sat, 2007-05-26 at 16:56 -0400, Jeff Garzik wrote:
>> Dave, any chance you could try 2.6.22-rc3 + my v4 patch, on a different 
>> hard drive?  Preferably a non-Maxtor, or at least not another Maxtor 
>> 6L200S0.  If that's a big deal, don't worry about it.  I just want to 
>> rule out buggy firmware and/or bad hard drive in your case.
> 
> It is likely I can come up with at least one, and maybe two if I
> cannibalize my main machine... do you want results under all three
> kernels or just the v4 patch?

Mainly the v4 patch, but an it-works test on 2.6.22-rc3 just for 
sanity's sake would be useful as well.

If you have time, check both new and old drives with SMART
	smartctl -d ata -t long /dev/blahblah

to make sure the extended tests don't find anything wrong.  Extended 
tests usually take 30-90 minutes.  You can access the hard drive while 
the extended test is running, but I/O will be slower for obvious reasons.

	Jeff



