From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Adaptec Unknown device 0241 (rev01): Serial ATA II RAID 1420SA
Date: Thu, 28 Sep 2006 07:37:54 -0400
Message-ID: <451BB412.7080104@garzik.org>
References: <8E8F647D7835334B985D069AE964A4F7028FDFEB@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41188 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965323AbWI1LiE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 07:38:04 -0400
In-Reply-To: <8E8F647D7835334B985D069AE964A4F7028FDFEB@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
Cc: linux-ide@vger.kernel.org

Fortier,Vincent [Montreal] wrote:
> Hi all,
> 
> I don't know if it's worth to mention but I have an Adaptec Serial ATA
> II RAID 1420SA quad port which supports RAID 0, 1 and 10.

Note this is "fake RAID" or software RAID.

So, it supports RAID5, RAID6, etc. :)


> I am using it whith a single 160GB HD and it is working properly since
> around 2.6.16 ...

Great!


> The lspci show the device has Unknown:
> 0000:04:0e.0 RAID bus controller: Adaptec: Unknown device 0241 (rev 01)

This should be reported to the pciutils maintainer 
(http://pciids.sf.net/).  This isn't related to the kernel.

	Jeff


