From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH 2/2] libata-2.6: Ignore interrupt before the ATAPI CDB
 is sent to the device
Date: Tue, 28 Jun 2005 18:05:28 +0800
Message-ID: <42C120E8.2090107@tw.ibm.com>
References: <4271FE02.1080009@tw.ibm.com> <427200B4.4050308@tw.ibm.com> <4287D1E3.9070606@pobox.com> <428877F4.5050405@tw.ibm.com> <42C0BEBC.9080900@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:5096 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261172AbVF1KGO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jun 2005 06:06:14 -0400
In-Reply-To: <42C0BEBC.9080900@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Jens Axboe <axboe@suse.de>, Linux IDE <linux-ide@vger.kernel.org>


> 
> 
> You don't need to ignore the interrupt.  If you follow the host state 
> machine, you need a cycle through INTRQ->check-status states, before 
> proceeding with the rest of the transaction.
> 
>     Jeff
> 

Hi Jeff,

The revised patch is in another thread:
http://marc.theaimsgroup.com/?l=linux-ide&m=111830130223323&w=2

Sorry I messed things up.
I will send you a better organized summary of the pacthes.


Albert


