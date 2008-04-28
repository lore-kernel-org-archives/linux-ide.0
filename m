From: Petr Vandrovec <petr@vmware.com>
Subject: Re: [PATCH #upstream-fixes 2/2] libata-scsi: improve rbuf handling
 for simulated commands
Date: Mon, 28 Apr 2008 01:23:19 -0700
Message-ID: <48158977.60609@vmware.com>
References: <481587F4.6090006@gmail.com> <48158826.8070209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.113.40.141]:47719 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1765733AbYD1IXZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Apr 2008 04:23:25 -0400
In-Reply-To: <48158826.8070209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Buffer length handling in simulated commands is error-prone and full
> of bugs.  There are a number of places where necessary length checks
> are missing and if the output buffer is passed in as sglist, nothing
> works.
> 
> This patch adds a static buffer ata_scsi_rbuf which is sufficiently
> large to handle the larges output from simulated commands (4k
> currently), let all simulte functions write to the buffer and removes
> all length checks as we know that there always is enough buffer space.
> Copying in (for ATAPI inquiry fix up) and out are handled by
> ata_scsi_copy_rbuf() behind ata_scsi_rbuf_get/put() interface and
> sglist is handled properly.
> 
> This patch is inspired from buffer length check fix patch from Petr
> Vandrovec.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Petr Vandrovec <petr@vmware.com>

Looks much better than my lots of ifs.  Thanks.
						Petr

