From: Tejun Heo <tj@kernel.org>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Thu, 19 Feb 2009 15:21:38 +0900
Message-ID: <499CFA72.1040905@kernel.org>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>	<49922A2D.508@kernel.org>	<49924F48.4000009@rtr.ca>	<20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>	<49934B20.4060206@rtr.ca>	<49934D24.1050204@garzik.org>	<49935157.6020002@rtr.ca>	<20090211175409.4fb27541@dhcp-100-2-144.bos.redhat.com>	<49944A13.3050105@rtr.ca>	<49944AA9.8040308@rtr.ca>	<4998D9B8.9020309@kernel.org> <20090216163040.194f5389@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42079 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751265AbZBSGVq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Feb 2009 01:21:46 -0500
In-Reply-To: <20090216163040.194f5389@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Chuck Ebbert wrote:
>> Yeap, SD_TIMEOUT should be it.  But I've never personally seen disk
>> flushing taking as long as 30 seconds.  Does it really happen?  It's
>> not like the drive would be doing random seeking.  One full stroke
>> across the platter should be it.  Even with the rotational delay,
>> going over 30 seconds doesn't seem very likely.
> 
> I just noticed that the other drive, a Western Digital, was using 1.5Gbps
> instead of 3.0. So I forced the Samsung to the slower speed and now I
> can't make the timeout happen anymore.

Timeouts are much more likely with the higher transfer speed but it's
kind of strange for flush cache to be affected by it as the command
doesn't have any data to transfer.  :-(

-- 
tejun
