From: Tejun Heo <htejun@gmail.com>
Subject: Re: ahci_softreset prevents acpi_power_off
Date: Sat, 13 Jan 2007 10:12:10 +0900
Message-ID: <45A831EA.50601@gmail.com>
References: <200701111231.26819.faik@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:37078 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161192AbXAMBMS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 20:12:18 -0500
Received: by wr-out-0506.google.com with SMTP id 70so827137wra
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 17:12:17 -0800 (PST)
In-Reply-To: <200701111231.26819.faik@pardus.org.tr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Faik Uygur <faik@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hello,

Faik Uygur wrote:
> We have a Sony PCG-6H1M laptop. It started failing to poweroff with our switch 
> from 2.6.16 stable series kernels to 2.6.18 stable series. Rebooting works.
> 
> While searching for the cause, I have found these reported bug reports in the 
> kernel bugzilla which may be related to this bug:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=6982
> http://bugzilla.kernel.org/show_bug.cgi?id=7447

Seems mostly unrelated.

> According to git bisect, this is the first bad commit:
> 
> 4658f79bec0b51222e769e328c2923f39f3bda77 is first bad commit
> commit 4658f79bec0b51222e769e328c2923f39f3bda77
> Author: Tejun Heo <htejun@gmail.com>
> Date:   Wed Mar 22 21:07:03 2006 +0900
> 
>     [PATCH] ahci: add softreset
> 
>     Now that libata is smart enought to handle both soft and hard resets,
>     add softreset method.
> 
>     Signed-off-by: Tejun Heo <htejun@gmail.com>
>     Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> :040000 040000 ba0a16d0ef82b6577bb61cfb18e6d9df9ee0984e 
> d0fc78d8f9bbe238f98ac8964562a33e64b30605 M      drivers
> 
> With v2.6.20-rc4 from git, it is still failing to poweroff. By not compiling 
> CONFIG_SCSI_SATA_AHCI, it successfully powers off.
> 
> Also with CONFIG_SCSI_SATA_AHCI, reverting this patch manually by setting 
> softreset to NULL in ata_do_eh calls in ahci.c makes the machine poweroff.

Wow, this is one of the most amazing error report.  ahci softreset
preventing system halt?

> I have attached the dmesg output with defined ATA_DEBUG, ATA_VERBOSE_DEBUG
> if it helps. Also you may find lspci output attached. 
> 
> Please let me know if anything else is needed.

Does everything else work okay?  Can you access devices attached to
ahci?  What happens when you try to shutdown?  If possible, please post
dmesg of shutting down.  You can store it easily using netconsole
(Documentation/networking/netconsole.txt).

Thanks.

-- 
tejun
