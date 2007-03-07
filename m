From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Libata Pass Through PIO Multi Support
Date: Wed, 7 Mar 2007 14:57:44 -0700
Message-ID: <8202f4270703071357h1020d9bam511891325c4b0117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:34180 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992655AbXCGV5p (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 16:57:45 -0500
Received: by wr-out-0506.google.com with SMTP id 58so514793wri
        for <linux-ide@vger.kernel.org>; Wed, 07 Mar 2007 13:57:44 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>

Hi Folks,

In ata_scsi_pass_thru() function in libata-scsi.c, the following code
is in place:
        if (scsicmd[1] & 0xe0)
                /* PIO multi not supported yet */
                goto invalid_fld;
Could someone explain why the PIO multi is not supported in libata pass through?

As an experiments, I commented out above code and added code to
support Set Multiple Mode. It seems PIO Multi works. But again, there
may be some caveates which I am not aware of.

I use 2.6.18-rc2 and libata 2.00. Above code exists in latest revision
like 2.6.19.2 as well.

Thanks,
Fajun
