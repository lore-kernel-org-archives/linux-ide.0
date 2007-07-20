From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 17/21] libata: improve SCSI scan failure handling
Date: Fri, 20 Jul 2007 21:28:57 +0900
Message-ID: <46A0AA89.2050502@gmail.com>
References: <11845637801356-git-send-email-htejun@gmail.com> <46A0A9E0.3020002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:38139 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbXGTMaS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 08:30:18 -0400
Received: by nz-out-0506.google.com with SMTP id s18so762470nze
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 05:30:18 -0700 (PDT)
In-Reply-To: <46A0A9E0.3020002@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> SCSI scan may fail due to memory allocation failure even if EH is not
>> in progress.  Due to use of GFP_ATOMIC in SCSI scan path, allocation
>> failure isn't too rare especially while probing multiple devices at
>> once which is the case when a bunch of devices are connected to PMP.
>>
>> This patch moves SCSI scan failure detetion logic from
>> ata_scsi_hotplug() to ata_scsi_scan_host() and implement synchronous
>> scan behavior.  The synchronous path sleeps briefly and repeats SCSI
>> scan if some devices aren't attached properly.  It contains robust
>> retry loop to minimize the chance of device misdetection during boot
>> and falls back to async retry if everything fails.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/libata-core.c |    2 +-
>>  drivers/ata/libata-scsi.c |   63
>> +++++++++++++++++++++++++++++++++-----------
>>  drivers/ata/libata.h      |    2 +-
>>  3 files changed, 49 insertions(+), 18 deletions(-)
> 
> applied 17-21, though this one makes me nervous.  off to test upstream +
> patchset #1...  :)

The proper thing to do is updating SCSI scan code such that it doesn't
fail at nothing (SCSI likes GFP_ATOMIC too much it seems).  Anyways,
we're much safer with this patch but it's ugly as hell.  :-(

-- 
tejun
