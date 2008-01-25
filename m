From: Mark Lord <liml@rtr.ca>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Thu, 24 Jan 2008 19:02:21 -0500
Message-ID: <4799270D.3010009@rtr.ca>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca> <479925FF.4060501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:4739 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbYAYACW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Jan 2008 19:02:22 -0500
In-Reply-To: <479925FF.4060501@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Mark Lord wrote:
>> Tejun Heo wrote:
>>> Mark Lord wrote:
>>>> Tejun Heo wrote:
>>>>> Mark Lord wrote:
>>>>>> Tejun,
>> ..
>>>>> void ata_qc_issue(struct ata_queued_cmd *qc)
>>>>> {
>>>>>         struct ata_port *ap = qc->ap;
>>>>>         struct ata_link *link = qc->dev->link;
>>>>>
>>>>>         /* Make sure only one non-NCQ command is outstanding.  The
>>>>>          * check is skipped for old EH because it reuses active qc to
>>>>>          * request ATAPI sense.
>>>>>          */
>>>> =         WARN_ON(ap->ops->error_handler &&
>>> Hmm... Thanks.  Do you have your ->qc_defer set?
>> ..
>>
>> Err.. no, never heard of it before (now).
>>
>> I suppose I should have it set to the default ?
> 
> Yeah, just set it to ata_std_qc_defer().
..

Super.  And when I add FIS-based-switching PMP support on top of NCQ,
*then* what should it point at?

?
