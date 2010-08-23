From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_sil boot failure with 2.6.35
Date: Mon, 23 Aug 2010 15:58:24 +0200
Message-ID: <4C727E80.3060402@kernel.org>
References: <4C6EC878020000780001146D@vpn.id2.novell.com> <4C6ED603.9020602@garzik.org> <4C724D3E.50404@kernel.org> <4C728C5E0200007800011887@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37231 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab0HWN5e (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 23 Aug 2010 09:57:34 -0400
In-Reply-To: <4C728C5E0200007800011887@vpn.id2.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Jeff Garzik <jeff@garzik.org>, jgarzik@redhat.com, linux-ide@vger.kernel.org

Hello,

On 08/23/2010 02:57 PM, Jan Beulich wrote:
>>>> On 23.08.10 at 12:28, Tejun Heo <tj@kernel.org> wrote:
>> This apparently is not an isolated case.
>>
>>   https://bugzilla.kernel.org/show_bug.cgi?id=16606 
>>
>> For some reason, the NODEV detection is getting triggered spuriously
>> which is really strange given that that part of code has been *really*
>> stable for very long time now.  Jan, can you please apply the
>> following patch and attach the kernel log?
>>
>>   https://bugzilla.kernel.org/attachment.cgi?id=27513 
> 
> Attached (but I think it doesn't tell more than what I already wrote
> in the original description).

Actually, it gives one more line.

  ata1: ST-ATA: DRQ=0 without device error, dev_stat 0x50

which is _really_ weird.  Hmmm... can you please apply the following
patch and see whether anything changes?

Thanks.

diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 3a4f842..526d58e 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -183,7 +183,7 @@ static struct scsi_host_template sil_sht = {
 };

 static struct ata_port_operations sil_ops = {
-	.inherits		= &ata_bmdma32_port_ops,
+	.inherits		= &ata_bmdma_port_ops,
 	.dev_config		= sil_dev_config,
 	.set_mode		= sil_set_mode,
 	.bmdma_setup            = sil_bmdma_setup,


-- 
tejun
