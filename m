From: Tejun Heo <htejun@gmail.com>
Subject: Re: WARNING: at drivers/ata/libata-core.c:5988 ata_qc_issue()
Date: Fri, 25 Jan 2008 08:57:51 +0900
Message-ID: <479925FF.4060501@gmail.com>
References: <4798ACCC.3040104@rtr.ca> <4798AE28.4000408@gmail.com> <4798B526.4020709@rtr.ca> <47992115.6050501@gmail.com> <479924B5.5060202@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:29733 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691AbYAXX55 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jan 2008 18:57:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so449272rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jan 2008 15:57:57 -0800 (PST)
In-Reply-To: <479924B5.5060202@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> Tejun Heo wrote:
>> Mark Lord wrote:
>>> Tejun Heo wrote:
>>>> Mark Lord wrote:
>>>>> Tejun,
> ..
>>>> void ata_qc_issue(struct ata_queued_cmd *qc)
>>>> {
>>>>         struct ata_port *ap = qc->ap;
>>>>         struct ata_link *link = qc->dev->link;
>>>>
>>>>         /* Make sure only one non-NCQ command is outstanding.  The
>>>>          * check is skipped for old EH because it reuses active qc to
>>>>          * request ATAPI sense.
>>>>          */
>>> =         WARN_ON(ap->ops->error_handler &&
>>
>> Hmm... Thanks.  Do you have your ->qc_defer set?
> ..
> 
> Err.. no, never heard of it before (now).
> 
> I suppose I should have it set to the default ?

Yeah, just set it to ata_std_qc_defer().

> sata_mv patch 15/14 forthcoming

:-)

-- 
tejun
