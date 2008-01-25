From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Thu, 24 Jan 2008 23:01:01 -0500
Message-ID: <47995EFD.8030102@rtr.ca>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com> <4799270D.3010009@rtr.ca> <4799285F.3060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2732 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbYAYEBJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 23:01:09 -0500
In-Reply-To: <4799285F.3060308@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
..
>> Super.  And when I add FIS-based-switching PMP support on top of NCQ,
>> *then* what should it point at?
> 
> If the controller can do FIS-based switching w/o any other restrictions,
> ata_std_qc_defer() can just stay.  If there are restrictions, you need
> to roll your own qc_defer.  sata_sil24 had to.
> 
> For command-based switching, sata_pmp_qc_defer_cmd_switch() can be used.
...

Super!  You've done a great job with this stuff, Tejun!

-ml
 

