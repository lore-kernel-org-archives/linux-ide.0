From: Kevin Shanahan <kmshanah@ucwb.org.au>
Subject: Re: libata & scsi error handling
Date: Thu, 19 Aug 2004 21:19:14 +0930
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092916153.2279.17.camel@localhost>
References: <4122771A.4070203@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.ucwb.org.au ([202.45.120.126]:28168 "EHLO mail.ucwb.org.au")
	by vger.kernel.org with ESMTP id S265706AbUHSLrV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Aug 2004 07:47:21 -0400
Received: from [192.168.2.52] (unknown [192.168.2.52])
	by mail.ucwb.org.au (Postfix) with ESMTP id 6F03212B66
	for <linux-ide@vger.kernel.org>; Thu, 19 Aug 2004 21:17:02 +0930 (CST)
In-Reply-To: <4122771A.4070203@wasp.net.au>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Wed, 2004-08-18 at 06:52, Brad Campbell wrote:
> brad@srv:/usr/src$ diff -u temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c 
> linux-2.6.8.1/drivers/scsi/libata-scsi.c
> --- temp/linux-2.6.8.1/drivers/scsi/libata-scsi.c       2004-08-14 14:55:19.000000000 +0400
> +++ linux-2.6.8.1/drivers/scsi/libata-scsi.c    2004-08-18 01:04:11.000000000 +0400
> @@ -213,6 +213,7 @@
> 
>          ap = (struct ata_port *) &host->hostdata[0];
>          ap->ops->eng_timeout(ap);
> +       host->host_failed--;
> 
>          DPRINTK("EXIT\n");
>          return 0;

Thanks for this Brad - great detective work 8)

This got me going again, so the reads do make progress. I'm looking at
what's happening with my dd_rescue trying to read from the disk and it
seems a little strange.

ptrace shows dd_rescue is calling pread to read 512 bytes from a sector
aligned locations. For each pread call I can see, syslog shows the sata
driver attempting to read several sectors (difficult to count, but it's
probably between 8 and 32 - maybe this is readahead?).

Even if the request was longer than one sector, is there any reason not
to abort the entire read request once an unreadable sector is
encountered? pread will just end up returning -1 anyway.

Do other disk drivers (libata, ide or others) behave the same way?

I ask because it has now taken approximately 24 hours for dd_rescue to
read ~250 (bad) sectors from this disk (I hope I'm not getting too far
off topic).

Thanks,
Kevin.


