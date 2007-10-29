From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
Subject: RE: PMP device port link speed issues
Date: Mon, 29 Oct 2007 19:29:48 +0530
Message-ID: <2A6F278C5B66C4459AF4013E77A40CD301003529@zin33exm20.fsl.freescale.net>
References: <472154DF.9050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw02.freescale.net ([192.88.158.103]:38339 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbXJ2N76 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Oct 2007 09:59:58 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l9TDxtwH017066
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 06:59:55 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net [10.232.192.5])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9TDxrX1004212
	for <linux-ide@vger.kernel.org>; Mon, 29 Oct 2007 08:59:54 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <472154DF.9050304@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Kalra Ashish-B00888 <ashish.kalra@freescale.com>

Hello Tejun,

This patch will surely fix my problem, but won't it be better to set
each PMP device port link speed directly to
the host<->PMP link speed, during SATA PMP device configuration in
sata_pmp_attach(), instead of calling 
sata_link_init_spd() for each link. 

The PMP chip should be responsible for matching link speed difference,
but probably there could be issues with
certain PMP chips, as it looks like in our case, where NCQ hangs are
probably caused due to link speed difference.
It should be simpler to handle it in S/W, by limiting PMP device port
link speeds to host<->PMP link speed.

Thanks,
Ashish

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Friday, October 26, 2007 8:16 AM
To: Jeff Garzik
Cc: Kalra Ashish-B00888; IDE/ATA development list
Subject: Re: PMP device port link speed issues

Jeff Garzik wrote:
> Kalra Ashish-B00888 wrote:
>> While testing the "sata_fsl" driver with a Sil3726 based PMP, we had 
>> a specific configuration where the host port to PMP link speed was 
>> 1.5Gbps, while the PMP has configured it's device port(s) link speed 
>> to 3Gbps. This configuration causes NCQ hangs on certain Seagate 
>> drives, probably because of the link speed difference between host 
>> and PMP device & PMP device ports and drives.
>>  
>> Does it makes sense to limit the PMP device port link speeds to the 
>> host port link speed ?
>> I believe currently sata_pmp_attach() is calling sata_link_init_spd()

>> for each PMP device port and thus causing PMP device port link speeds

>> being configured independent of host port link speed. Probably the 
>> PMP device port links should be limited to the host link speed.
> 
> Interesting question.  I'm sure Tejun will chime in, but I'm wondering

> if there is any real use -- even theoretical -- for running downstream

> links faster than the host<->PMP link?

[chiming in]

Probably not but it should also be okay.  The PMP chip is responsible
for matching link speed difference and it's pretty simple to do in SATA.

Kalra, does the following patch fix your NCQ problem?

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c index
8ee56e5..6db2d1e 100644
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
