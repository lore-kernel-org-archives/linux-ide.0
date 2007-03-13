From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: fix native mode disabled port handling
Date: Tue, 13 Mar 2007 17:06:35 +0900
Message-ID: <45F65B8B.5080806@gmail.com>
References: <20070309104335.GD32687@htj.dyndns.org> <45F17706.9040402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.180]:32468 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932987AbXCMIGq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 13 Mar 2007 04:06:46 -0400
Received: by py-out-1112.google.com with SMTP id a29so551648pyi
        for <linux-ide@vger.kernel.org>; Tue, 13 Mar 2007 01:06:45 -0700 (PDT)
In-Reply-To: <45F17706.9040402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Disabled port handling in ata_pci_init_native_mode() is slightly
>> broken in that it may end up using the wrong port_info.  This patch
>> updates it such that disables ports are made dummy as done in the
>> legacy and other cases.
>>
>> While at it, fix indentation in ata_resources_present().
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-sff.c |   62
>> ++++++++++++++++++++++++++--------------------
>>  1 files changed, 35 insertions(+), 27 deletions(-)
> 
> what's the extent of the breakage here?
> 
> I would rather push this into #upstream

Yeap, this is for #upstream.  The breakage is theoretical as none hits
the path yet.

Thanks.

-- 
tejun
