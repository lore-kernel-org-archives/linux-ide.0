From: Brad Campbell <brad@wasp.net.au>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Mon, 30 Aug 2004 21:35:44 +0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41336570.8090308@wasp.net.au>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wasp.net.au ([203.190.192.17]:43977 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S268658AbUH3RfO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Aug 2004 13:35:14 -0400
In-Reply-To: <200408301531.i7UFVBg29089@ra.tuxdriver.com>
List-Id: linux-ide@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-ide@vger.kernel.org

John W. Linville wrote:
> Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
> supporting SMART w/ unmodified smartctl and smartd userland binaries.
> 
> Not happy w/ loop after failed ata_qc_new_init(), but needed because smartctl
> and smartd did not retry after failure.  Likely need an option to wait for
> available qc?  Also not sure all the error return codes are correct...
> 

YYYYYYYYYYEeeeeeeeeeeeeeeeeeeeeeeeeeehhhhhhhhhhaaaaaaaaaaaaaaaaaaa!!!!!!!!

I know it's a bit kludgy and does not really fit the philosophy of libata but it works and it lets 
me keep an eye on my drives *now*.

Although just for good measure I'll probably unmount and stop my raid arrays before I use it on the 
disks. Whats it like for locking on a busy system?

Regards,
Brad

