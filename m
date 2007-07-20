From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/21] libata: add @is_cmd to ata_tf_to_fis()
Date: Fri, 20 Jul 2007 21:18:45 +0900
Message-ID: <46A0A825.9010201@gmail.com>
References: <1184563778203-git-send-email-htejun@gmail.com> <46A0A450.8070003@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:30015 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756374AbXGTMUB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jul 2007 08:20:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so969119wah
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 05:20:01 -0700 (PDT)
In-Reply-To: <46A0A450.8070003@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, Forrest Zhao <forrest.zhao@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Add @is_cmd to ata_tf_to_fis().  This controls bit 7 of the second
>> byte which tells the device whether this H2D FIS is for a command or
>> not.  This cleans up ahci a bit and will be used by PMP.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>> ---
>>  drivers/ata/ahci.c        |   10 ++++------
>>  drivers/ata/libata-core.c |   14 ++++++++------
>>  drivers/ata/sata_qstor.c  |    2 +-
>>  drivers/ata/sata_sil24.c  |    2 +-
>>  include/linux/libata.h    |    3 ++-
>>  5 files changed, 16 insertions(+), 15 deletions(-)
> 
> applied 2-14

Hmmm... Where did patch 1 go?  Did you receive it?

-- 
tejun
