From: Francois Payette <francoisp@netmosphere.net>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Fri, 18 Feb 2005 11:40:52 -0500
Message-ID: <42161A94.1020404@netmosphere.net>
References: <42111B02.4010805@netmosphere.net> <4211279C.5070205@pobox.com> <421360ED.2040505@netmosphere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from 65.18.135.ptr ([65.18.135.81]:28330 "EHLO isecurit.com")
	by vger.kernel.org with ESMTP id S261399AbVBRQkO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2005 11:40:14 -0500
In-Reply-To: <421360ED.2040505@netmosphere.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Eric Mudama <edmudama@gmail.com>

It seems that the locking problem we were experiencing was related to 
the disparities of drives in a raid 0 array; when we replaced the 
6Y200M0 with another 6B200S0 the problem never reappeared even after 1.8 
TB of io. Thanks a buch to Eric for pointing out the differences; the 
promise card and/or driver must have a problem with the bridge chip on 
that drive when interfacing with another drive that does not have that 
chip. We also tested for performance improvements with

writel(tmp, mmio + PDC_TBG_MODE);

commented out from pdc_host_init, but it does not cause a significant 
difference when benchmarked with bonnie++.

Thanks for your help,
Francois
