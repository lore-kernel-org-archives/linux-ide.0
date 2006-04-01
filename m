From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 04/14] libata: clean up constants
Date: Sat, 01 Apr 2006 15:02:05 -0500
Message-ID: <442EDC3D.7000302@pobox.com>
References: <11438885161447-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:47325 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751613AbWDAUCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 15:02:09 -0500
In-Reply-To: <11438885161447-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> * Reorder ATA_DFLAG_* such that feature flags determined by
>   ata_dev_configure() are on lower bits.  Reserve lower eight bits
>   for this purpose and allocate dynamic flags from bit 8.
> 
> * Reorder ATA_FLAG_* such that feature flags determined during driver
>   initiailization are on bits 0:15, dynamic flags on 16:23 and LLDD
>   specific flags on 24:31.
> 
> * Rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED for consistency.
>   (ATA_FLAG_* are always about ports).
> 
> * Kill trailing white space and lower-case an one line comment for
>   consistency.

Separate cleanups and new flags/constants into separate patches, please.

ACK patches 1-4, modulo the above comment.


