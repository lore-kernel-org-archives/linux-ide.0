From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: EH progress summary
Date: Mon, 20 Feb 2006 16:27:12 +0800
Message-ID: <43F97D60.7090907@tw.ibm.com>
References: <43F93A33.1020809@gmail.com> <43F979CD.2060307@tw.ibm.com> <43F97BA0.1080905@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:12234 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932232AbWBTI1M
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Feb 2006 03:27:12 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e31.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k1K8RCc7009945
	for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 03:27:12 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k1K8OpA5241548
	for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 01:24:51 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k1K8RB0B010869
	for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 01:27:11 -0700
In-Reply-To: <43F97BA0.1080905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Albert Lee wrote:
> 
>> Hi Tejun:
>>
>>> I think we're half-way through the EH changes. New reset mechanism and
>>> most of config reorganization are in tree. Currently, the patches which
>>> are waiting for your review are...
>>>
>>> [1] libata: rename ata_dev_id_[c_]string()
>>> [2] libata: reorganize ata_dev_identify() (7 patches)
>>> [3] libata: implement and use ata_dev_revalidate() (4 patches)
>>>
>>> Once these revalidation changes make into tree, I'll submit
>>> ata_set_mode() changes (I've submitted the first patchset of this but
>>> Alan had a valid objection. I agreed and dropped that one.[4])
>>>
>>> After ata_set_mode() changes are complete, the real EH changes will be
>>> submitted including error recording (to determine whether speed down is
>>> necessary) and all the recovery actions. 
>>
>>
>>
>> Will PATA speed down be supported?
>> e.g. udma133 => udma100 => udma66 => udma33 => pio ...
>>
> 
> Yeap, sure.
> 

That's great, thanks! :)

Albert

