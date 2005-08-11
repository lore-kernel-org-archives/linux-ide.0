From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/3] libata-dev: pdc2027x mdelay() problem fix for	power5
 micro-partitioning
Date: Thu, 11 Aug 2005 17:52:39 +0800
Message-ID: <42FB1FE7.2070600@tw.ibm.com>
References: <42F24DBE.0@tw.ibm.com> <42F251C2.8090409@tw.ibm.com>	 <42FAC04F.4060405@pobox.com> <1123749380.20143.12.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:60392 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S932351AbVHKJxP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Aug 2005 05:53:15 -0400
In-Reply-To: <1123749380.20143.12.camel@gaston>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>



Benjamin Herrenschmidt wrote:

> On Wed, 2005-08-10 at 23:04 -0400, Jeff Garzik wrote:
> 
> 
>>mdelay() should be investigated as to why its not working on your 
>>platform.  do_gettimeofday() is -less- granular and accurate than 
>>mdelay(), usually.
> 
> 
> Agreed. mdelay() should have worked.
> 

Understood. Will verify it again on newer kernel.

Thanks,

Albert




