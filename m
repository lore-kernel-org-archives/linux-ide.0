From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch] add more device IDs for supporting SB700 (resend)
Date: Fri, 20 Jul 2007 08:07:56 -0400
Message-ID: <46A0A59C.3000001@garzik.org>
References: <c660f0910707160759m384f46b3s310cf833db305cb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49932 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756069AbXGTMIA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 08:08:00 -0400
In-Reply-To: <c660f0910707160759m384f46b3s310cf833db305cb6@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: su henry <henry.su.ati@gmail.com>
Cc: jgarzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, bzolnier <bzolnier@gmail.com>, htejun <htejun@gmail.com>, greg <greg@kroah.com>, henry.su@amd.com

su henry wrote:
> From: henry.su.ati@gmail.com
> The SATA controller device ID is different according to
> the onchip SATA type set in the system BIOS:
> Device                              Device ID
> SATA in IDE mode             0x4390
> SATA in AHCI mode           0x4391
> SATA in non-raid5 driver     0x4392
> SATA in raid5 driver           0x4393
> 
> Although the device ID is different, they use the same AHCI driver
> .The attached file is the patch for adding these device
> IDs for ATI SB700.
> 
> Signed-off-by: henry.su.ati@gmail.com

applied


