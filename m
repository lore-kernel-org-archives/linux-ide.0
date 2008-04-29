From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 2/2 UPDATED] libata-scsi: improve rbuf
 handling for simulated commands
Date: Tue, 29 Apr 2008 02:18:26 -0400
Message-ID: <4816BDB2.7000000@garzik.org>
References: <481587F4.6090006@gmail.com>	<48158826.8070209@gmail.com> <20080428173834Z.tomof@acm.org> <48158F73.7010104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51624 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757AbYD2GSw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 02:18:52 -0400
In-Reply-To: <48158F73.7010104@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-ide@vger.kernel.org, petr@vmware.com

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
> sg_copy_to/from_buffer() behind ata_scsi_rbuf_get/put() interface
> which handles sglist properly.
> 
> This patch is inspired from buffer length check fix patch from Petr
> Vandrovec.
> 
> Updated to use sg_copy_to/from_buffer() as suggested by FUJITA
> Tomonori.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Petr Vandrovec <petr@vmware.com>
> Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> ---
> drivers/ata/libata-scsi.c |  446 

applied 1-2


