From: Tejun Heo <htejun@gmail.com>
Subject: Re: Random libata comments...
Date: Tue, 23 May 2006 08:46:22 +0900
Message-ID: <44724D4E.5010506@gmail.com>
References: <447248B9.6040304@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:25932 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751309AbWEVXqS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 May 2006 19:46:18 -0400
Received: by py-out-1112.google.com with SMTP id z59so1701130pyg
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2006 16:46:17 -0700 (PDT)
In-Reply-To: <447248B9.6040304@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Jeff Garzik wrote:
> 
> * I agree with others that using the "ata_drive_probe_reset" can lead to 
> confusion on the uses of the word "drive".  Replacing that with "do" or 
> something else would be nice.

Will do.

> * As the ata_drive_probe_reset argument list continues to grow, I lean 
> more and more towards moving all those function pointers to struct 
> ata_port_operations.  One of the problems with the drivers/ide layer IMO 
> is that the list of all hooks used is not immediately clear upon first 
> read, whereas with libata it is clear -- with the notable exception of 
> ata_drive_probe_reset().

->error_handler() takes over all of ata_drive_probe_reset() after 
hotplug patchset and all ->probe_reset() related stuff are killed.  The 
same applies to ->error_handler() though.  I agree with you that the 
arguments are ugly, but also there are already too many non-essential 
operations in ata_port_operations.  I was hoping something can be done 
to resolve both issues.

I'm okay with moving reset ops into ata_port_operations but we need to 
do more than that, IMHO.

-- 
tejun
