From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Libata Pass Through PIO Multi Support
Date: Wed, 07 Mar 2007 17:33:35 -0500
Message-ID: <45EF3DBF.1010400@garzik.org>
References: <8202f4270703071357h1020d9bam511891325c4b0117@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41324 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992672AbXCGWdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Mar 2007 17:33:38 -0500
In-Reply-To: <8202f4270703071357h1020d9bam511891325c4b0117@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

Fajun Chen wrote:
> Hi Folks,
> 
> In ata_scsi_pass_thru() function in libata-scsi.c, the following code
> is in place:
>        if (scsicmd[1] & 0xe0)
>                /* PIO multi not supported yet */
>                goto invalid_fld;
> Could someone explain why the PIO multi is not supported in libata pass 
> through?

That's just code left over from before we merged Albert Lee's patches 
adding PIO-multi support.  That check should probably just be removed.

	Jeff



