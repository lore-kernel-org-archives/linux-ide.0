From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCH] libata: automatically use DMADIR if drive/bridge requires
 it
Date: Fri, 22 Feb 2008 18:09:42 +0800
Message-ID: <47BE9F66.5040404@tw.ibm.com>
References: <47B9D64C.3000705@rtr.ca> <47B9F05A.1060207@rtr.ca> <47BC6100.9020906@pobox.com> <47BC7727.1090508@rtr.ca> <47BCFD4E.4070100@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:54344 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYBVKKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2008 05:10:15 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1MA9ex1006255
	for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 05:09:40 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m1MA9tZa171556
	for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 03:10:01 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m1MA9sVR031449
	for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2008 03:09:55 -0700
In-Reply-To: <47BCFD4E.4070100@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Ricardo Salveti de Araujo <rsalveti@br.ibm.com>

Tejun Heo wrote:
> Back in 2.6.17-rc2, a libata module parameter was added for atapi_dmadir.
> 
> That's nice, but most SATA devices which need it will tell us about it
> in their IDENTIFY PACKET response, as bit-15 of word-62 of the
> returned data (as per ATA7, ATA8 specifications).
> 
> So for those which specify it, we should automatically use the DMADIR bit.
> Otherwise, disc writing will fail by default on many SATA-ATAPI drives.
> 
> This patch adds ATA_DFLAG_DMADIR and make ata_dev_configure() set it
> if atapi_dmadir is set or identify data indicates DMADIR is necessary.
> atapi_xlat() is converted to check ATA_DFLAG_DMADIR before setting
> DMADIR.
> 
> Original patch is from Mark Lord.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Mark Lord <mlord@pobox.com>
> ---
> I don't have a bridge which sets DMADIR but so only checked atapi_dmadir
> parameter.  Thanks.
> 

The patch looks good. However, it seems there is no realworld IDE-to-SATA
bridge that requires DMADIR and also mangles IDENTIFY PACKET bit-15 of
word-62 to indicate its presence.

>From the previous test of the IDE-to-SATA bridges, only the Sil 3611
requires the host software to hint on ATAPI DMADIR. But Sil 3611 doesn't
mangle IDENTIFY PACKET word-62:
http://www.spinics.net/lists/linux-ide/msg01514.html

Maybe we could use ata_dev_knobble() instead? i.e. If it's an ATAPI
device && ata_dev_knobble() then we turn on DMADIR (regardless the
bridge chip used since setting DMADIR won't hurt those don't need it.)
--
albert

