From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: add host_set->next for legacy two host_sets case,
 take #2
Date: Mon, 12 Jun 2006 22:44:21 +0900
Message-ID: <448D6FB5.6010902@gmail.com>
References: <20060612051727.GD9166@htj.dyndns.org> <448D0FF9.1080605@pobox.com> <20060612101419.GB5751@htj.dyndns.org> <448D6DBF.9010604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:34778 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751954AbWFLNo2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jun 2006 09:44:28 -0400
Received: by py-out-1112.google.com with SMTP id x31so1693380pye
        for <linux-ide@vger.kernel.org>; Mon, 12 Jun 2006 06:44:27 -0700 (PDT)
In-Reply-To: <448D6DBF.9010604@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Albert Lee <albertcc@tw.ibm.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> For a legacy ATA controller, libata registers two separate host sets.
>> There was no connection between the two hosts making it impossible to
>> traverse all ports related to the controller.  This patch adds
>> host_set->next which points to the second host_set and makes
>> ata_host_set_remove() remove all associated host_sets and ports.
>>
>> * On device removal, all ports hanging off the device are properly
>>   detached.  Prior to this patch, ports on the first host_set weren't
>>   detached casuing oops on driver unloading.
>>
>> * On device removal, both host_sets are properly freed
>>
>> This will also be used by new power management code to suspend and
>> resume all ports of a controller.  host_set/port representation will
>> be improved to handle legacy controllers better and this host_set
>> linking will go away with it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Same objection as before:  ata_host_set_remove() should only remove 
> _one_ host_set.  Therefore, that function is ignorant of the linked 
> list, and the caller is the one that is forced to manage the list.

Duh... I must be smoking something.  I thought I moved that loop out of 
that function.  :-(  Will submit again.

-- 
tejun
