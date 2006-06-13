From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/10] libata: implement new Power Management framework
Date: Tue, 13 Jun 2006 18:15:57 +0900
Message-ID: <448E824D.5070707@gmail.com>
References: <11501274293403-git-send-email-htejun@gmail.com>	 <1150186634.7132.34.camel@forrest26.sh.intel.com>	 <448E7EA3.8070707@gmail.com> <1150188880.7132.44.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:22353 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWFMJQD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Jun 2006 05:16:03 -0400
Received: by py-out-1112.google.com with SMTP id x31so60390pye
        for <linux-ide@vger.kernel.org>; Tue, 13 Jun 2006 02:16:03 -0700 (PDT)
In-Reply-To: <1150188880.7132.44.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: jgarzik@pobox.com, lkml@rtr.ca, axboe@suse.de, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Tue, 2006-06-13 at 18:00 +0900, Tejun Heo wrote:
>> If ata_pci_device_suspend/resume() do things incorrect for a 
>> controller(), export ata_host_set_suspend/resume() and call those from 
>> LLD's suspend/resume() routines.
>>
> 
> OK. I'll export them in the upcoming AHCI suspend/resume patches.

Hmmm... sil/sil24 are currently initialize controller before they 
restore power state, which is wrong.  I'll fix that.  Thanks for raising 
the issue.

-- 
tejun
