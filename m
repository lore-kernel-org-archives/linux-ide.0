From: Tejun Heo <htejun@gmail.com>
Subject: Re: EH progress summary
Date: Mon, 20 Feb 2006 17:19:44 +0900
Message-ID: <43F97BA0.1080905@gmail.com>
References: <43F93A33.1020809@gmail.com> <43F979CD.2060307@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.182]:18495 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932156AbWBTITr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Feb 2006 03:19:47 -0500
Received: by pproxy.gmail.com with SMTP id i49so1033348pyi
        for <linux-ide@vger.kernel.org>; Mon, 20 Feb 2006 00:19:46 -0800 (PST)
In-Reply-To: <43F979CD.2060307@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jgarzik@pobox.com>, Linux-ide <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Hi Tejun:
> 
>>I think we're half-way through the EH changes. New reset mechanism and
>>most of config reorganization are in tree. Currently, the patches which
>>are waiting for your review are...
>>
>>[1] libata: rename ata_dev_id_[c_]string()
>>[2] libata: reorganize ata_dev_identify() (7 patches)
>>[3] libata: implement and use ata_dev_revalidate() (4 patches)
>>
>>Once these revalidation changes make into tree, I'll submit
>>ata_set_mode() changes (I've submitted the first patchset of this but
>>Alan had a valid objection. I agreed and dropped that one.[4])
>>
>>After ata_set_mode() changes are complete, the real EH changes will be
>>submitted including error recording (to determine whether speed down is
>>necessary) and all the recovery actions. 
> 
> 
> Will PATA speed down be supported?
> e.g. udma133 => udma100 => udma66 => udma33 => pio ...
> 

Yeap, sure.

-- 
tejun
