From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] IDE: compile fix for sff_dma_ops
Date: Thu, 21 Aug 2008 16:50:15 -0700
Message-ID: <87y72q6i88.fsf@deeprootsystems.com>
References: <1219353824-31246-1-git-send-email-khilman@deeprootsystems.com>
	<87bpzm7yoi.fsf@deeprootsystems.com> <48ADFA27.2070002@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:37661 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbYHUXuQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Aug 2008 19:50:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so184004rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 21 Aug 2008 16:50:15 -0700 (PDT)
In-Reply-To: <48ADFA27.2070002@ru.mvista.com> (Sergei Shtylyov's message of "Fri\, 22 Aug 2008 03\:28\:39 +0400")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Sergei Shtylyov <sshtylyov@ru.mvista.com> writes:

> Hello.
>
> Kevin Hilman wrote:
>
>>> The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
>>> of BLK_DEV_IDEDMA_PCI.
>> Oops, I sent the wrong version of this patch.  Here's a better version
>> which moves sff_dma_ops into an existing #ifdef block.
>>
>> Kevin
>>
>> From d9c182b5109591b9a28384991bcd820554fad371 Mon Sep 17 00:00:00 2001
>> From: Kevin Hilman <khilman@deeprootsystems.com>
>> Date: Thu, 21 Aug 2008 10:31:44 -0700
>> Subject: [PATCH] IDE: compile fix for sff_dma_ops
>>
>> The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
>> of BLK_DEV_IDEDMA_PCI.
>>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> [...]
>> diff --git a/include/linux/ide.h b/include/linux/ide.h
>> index eb1721c..cf95ca7 100644
>> --- a/include/linux/ide.h
>> +++ b/include/linux/ide.h
>>   
> [...]
>> @@ -1276,6 +1275,7 @@ int ide_dma_test_irq(ide_drive_t *);
>>  extern void ide_dma_lost_irq(ide_drive_t *);
>>  extern void ide_dma_timeout(ide_drive_t *);
>>  extern const struct ide_dma_ops sff_dma_ops;
>> +extern const struct ide_dma_ops sff_dma_ops;
>>  #endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
>
>   Somethiung went wrong again.  Do you see what? :-)
>

Sigh, OK, here's one that actually applies.  Sorry.

Kevin

>From c453ee79a240a9104191e245655ff975c175edcd Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@deeprootsystems.com>
Date: Thu, 21 Aug 2008 10:31:44 -0700
Subject: [PATCH] IDE: compile fix for sff_dma_ops

The sff_dma_ops struct should be wrapped by BLK_DEV_IDEDMA_SFF instead
of BLK_DEV_IDEDMA_PCI.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 include/linux/ide.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/ide.h b/include/linux/ide.h
index 87c12ed..fee4b15 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1111,7 +1111,6 @@ void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
 #ifdef CONFIG_BLK_DEV_IDEDMA_PCI
 int ide_pci_set_master(struct pci_dev *, const char *);
 unsigned long ide_pci_dma_base(ide_hwif_t *, const struct ide_port_info *);
-extern const struct ide_dma_ops sff_dma_ops;
 int ide_pci_check_simplex(ide_hwif_t *, const struct ide_port_info *);
 int ide_hwif_setup_dma(ide_hwif_t *, const struct ide_port_info *);
 #else
@@ -1275,6 +1274,7 @@ extern int __ide_dma_end(ide_drive_t *);
 int ide_dma_test_irq(ide_drive_t *);
 extern void ide_dma_lost_irq(ide_drive_t *);
 extern void ide_dma_timeout(ide_drive_t *);
+extern const struct ide_dma_ops sff_dma_ops;
 #endif /* CONFIG_BLK_DEV_IDEDMA_SFF */
 
 #else
-- 
1.5.6.4


