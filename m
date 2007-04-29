From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 03/13] libata: separate out ata_dev_reread_id()
Date: Sun, 29 Apr 2007 11:52:12 +0900
Message-ID: <4634085C.3030602@gmail.com>
References: <11772636651116-git-send-email-htejun@gmail.com> <46339841.2030604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:47223 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123AbXD2CxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Apr 2007 22:53:09 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1296376wra
        for <linux-ide@vger.kernel.org>; Sat, 28 Apr 2007 19:53:09 -0700 (PDT)
In-Reply-To: <46339841.2030604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, alan@lxorguk.ukuu.org.uk, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Separate out ata_dev_reread_id() from ata_dev_revalidate().
>> ata_dev_reread_id() reads IDENTIFY page and determines whether the
>> same device is still there.  ata_dev_revalidate() reconfigures after
>> reread completes.  This will be used by ACPI update.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-core.c |   47
>> ++++++++++++++++++++++++++++++++------------
>>  drivers/ata/libata.h      |    3 +-
>>  2 files changed, 36 insertions(+), 14 deletions(-)
> 
> ACK, though I think you'll have to rediff due to a Mark Lord patch

No problem.

-- 
tejun
