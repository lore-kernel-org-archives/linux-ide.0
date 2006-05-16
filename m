From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: ata_piix resume from S3 on T43P failed
Date: Tue, 16 May 2006 09:58:27 +0800
Message-ID: <1147744707.7273.76.camel@forrest26.sh.intel.com>
References: <1147334740.7273.38.camel@forrest26.sh.intel.com>
	 <4462F667.3060504@gmail.com>  <44655E40.2090004@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:42604 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751028AbWEPCKJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 15 May 2006 22:10:09 -0400
In-Reply-To: <44655E40.2090004@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Sat, 2006-05-13 at 00:19 -0400, Jeff Garzik wrote:
> Hannes @ SuSE posted an AHCI suspend/resume patch that needs to go in.
> Unfortunately AHCI is a high rate of churn, so it's still in my
> 'Pending' folder :/
> 
> 	Jeff

Jeff,

According to our test, Hannes's patch can't work on our NAPA sdv, I have
reported the problem on 27th, April. The mail archive is at:
http://marc.theaimsgroup.com/?l=linux-ide&m=114612987014369&w=2

And I ported a patch from OpenSUSE to #upstream and posted patch on
30th,April, the mail archive is at:
http://marc.theaimsgroup.com/?l=linux-ide&m=114637600401411&w=2

Will this ported patch be in your pending list?

Thanks,
Forrest
