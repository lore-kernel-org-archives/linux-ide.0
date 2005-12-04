From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH/RFC 0/4] libata: move err_mask to ata_queued_cmd (revised)
Date: Sat, 03 Dec 2005 21:01:53 -0500
Message-ID: <43924E11.60500@pobox.com>
References: <437181D5.8070903@tw.ibm.com> <43718400.5000409@tw.ibm.com> <43719670.20708@pobox.com> <4372FD45.8080404@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:40685 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbVLDCB7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Dec 2005 21:01:59 -0500
In-Reply-To: <4372FD45.8080404@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>

Albert Lee wrote:
> Dear all,
> 
> Description:
>   Move the err_mask parameter of the complete functions to ata_queued_cmd.
>   This can make the err_mask more accessible outside the complete functions;
>   also can make the HSM easier to determine and pass err_mask between states.
> 
> patch 1/4: minor patch to pave the road for patch 2 and 3
> patch 2/4: move err_mask to ata_queued_cmd
> patch 3/4: determine the err_mask when the error is found
> patch 4/4: determine the err_mask directly in atapi_packet_task()
> 
> Revised patch against the mainline tree 
> (e4d76e1c0b15590f2ad9bba89426c2520cd22ca6).

These patches look good, and I'm finally ready to apply them to the 
'upstream' branch.

Would you be kind enough to rediff and resend?  Since I waited a while 
(my fault!), the second patch doesn't seem to apply anymore:


[jgarzik@pretzel libata-dev]$ git-applymbox /g/tmp/mbox ~/info/signoff.txt
4 patch(es) to process.

Applying 'libata: minor patch before moving err_mask'

Wrote tree 6db1429964448401102718bb7ebcb2a7b2efae14
Committed: be7766250023702e65fab822ecf6a8b805028036

Applying 'libata: move err_mask to ata_queued_cmd'

error: patch failed: drivers/scsi/libata-core.c:3424
error: drivers/scsi/libata-core.c: patch does not apply
error: patch failed: drivers/scsi/ahci.c:631
error: drivers/scsi/ahci.c: patch does not apply
error: patch failed: drivers/scsi/sata_mv.c:1136
error: drivers/scsi/sata_mv.c: patch does not apply
error: patch failed: drivers/scsi/sata_sil24.c:557
error: drivers/scsi/sata_sil24.c: patch does not apply
