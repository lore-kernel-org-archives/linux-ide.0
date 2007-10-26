From: Tejun Heo <htejun@gmail.com>
Subject: Re: PMP device port link speed issues
Date: Fri, 26 Oct 2007 11:45:51 +0900
Message-ID: <472154DF.9050304@gmail.com>
References: <2A6F278C5B66C4459AF4013E77A40CD301003114@zin33exm20.fsl.freescale.net> <47206F2F.4020206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:3595 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762950AbXJZCqA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 22:46:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so656929rvb
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 19:45:59 -0700 (PDT)
In-Reply-To: <47206F2F.4020206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kalra Ashish-B00888 <ashish.kalra@freescale.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> Kalra Ashish-B00888 wrote:
>> While testing the "sata_fsl" driver with a Sil3726 based PMP, we had a
>> specific configuration where the host port to PMP link speed was
>> 1.5Gbps, while the PMP has configured it's device port(s) link speed to
>> 3Gbps. This configuration causes NCQ hangs on certain Seagate drives,
>> probably because of the link speed difference between host and PMP
>> device & PMP device ports and drives.
>>  
>> Does it makes sense to limit the PMP device port link speeds to the host
>> port link speed ?  
>> I believe currently sata_pmp_attach() is calling sata_link_init_spd()
>> for each PMP device port and thus causing PMP device port link speeds
>> being configured independent of host port link speed. Probably the PMP
>> device port links should be limited to the host link speed. 
> 
> Interesting question.  I'm sure Tejun will chime in, but I'm wondering
> if there is any real use -- even theoretical -- for running downstream
> links faster than the host<->PMP link?

[chiming in]

Probably not but it should also be okay.  The PMP chip is responsible
for matching link speed difference and it's pretty simple to do in SATA.

Kalra, does the following patch fix your NCQ problem?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8ee56e5..6db2d1e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6517,6 +6517,7 @@ int sata_link_init_spd(struct ata_link *link)
        spd = (scontrol >> 4) & 0xf;
        if (spd)
                link->hw_sata_spd_limit &= (1 << spd) - 1;
+       link->hw_sata_spd_limit = 1;

        link->sata_spd_limit = link->hw_sata_spd_limit;

-- 
tejun
