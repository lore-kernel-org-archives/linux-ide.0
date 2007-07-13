From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFT][PATCH v7] sata_mv: convert to new EH
Date: Fri, 13 Jul 2007 08:36:45 -0400
Message-ID: <469771DD.1010102@rtr.ca>
References: <20070711200538.GA7374@havoc.gtf.org> <Pine.LNX.4.64.0707120212210.25837@twinlark.arctic.org> <46960225.5000502@garzik.org> <Pine.LNX.4.64.0707121140560.29365@twinlark.arctic.org> <loom.20070713T053938-434@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:3215 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbXGMMgr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 08:36:47 -0400
In-Reply-To: <loom.20070713T053938-434@post.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: greg <greg-dated-1184731565.7e0579@lucidsolutions.co.nz>
Cc: linux-ide@vger.kernel.org

greg wrote:
> dean gaudet <dean <at> arctic.org> writes:
>> if you've got any other workload you'd like me to throw at it, 
>> let me know.  
> 
> I've had a few problems with the driver in 2.6.20 (fc6xen x86_64). The machine 
> tended to lock up after a random period of time (from a few minutes upwards), 
> without any messages. Performing a smartctl on all the disks, or leaving smartd 
> running, seemed to speed up the rate at which the crash occurred. What I found 
> was that by moving the sata_mv device onto it's own bus (or a bus with two 
> sata_mv devices), the crashes went away. Are you doing tests with the 
> controller sharing a bus with other devices?
> 
> Is there an merit to my observation that it might be an issue with devices 
> sharing a PCI-X bus?

Dubious.  Just a flakey driver, though it's looking better today.

Cheers
