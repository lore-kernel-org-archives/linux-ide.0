From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 08 Apr 2010 12:02:37 -0400
Message-ID: <yq17hoix78i.fsf@sermon.lab.mkp.net>
References: <4BBDE620.3040601@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:36955 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574Ab0DHQDa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Apr 2010 12:03:30 -0400
In-Reply-To: <4BBDE620.3040601@gc-web.de> (Alexander Clausen's message of
	"Thu, 08 Apr 2010 16:20:16 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: linux-ide@vger.kernel.org

>>>>> "Alexander" == Alexander Clausen <alex@gc-web.de> writes:

Alexander> Hi, i just bought some WD20EARS harddisk. They are supposed
Alexander> to have 4k physical sector size, right?  My system seems to
Alexander> think they are not:

Alexander> alex@hal:/sys/block/sdb/queue$ cat logical_block_size
Alexander> physical_block_size 512 512 

Alexander> so, who is right?

For unknown reasons these drive report themselves as 512-byte drives
despite using 4096-byte sectors internally.

There really isn't much we can do about devices that don't tell us the
truth.  However, recent fdisk/parted will align on a 1MB boundary by
default which happens do the trick in this particular case (because the
WDC drive is naturally aligned).


Alexander>  1 Primary 0 3907024064 63 3907024065 Linux (83) None
Alexander> alex@hal:~$

Alexander> is that okay for 4k sector size?

No, you should shift the start sector using the fdisk's advanced menu.

-- 
Martin K. Petersen	Oracle Linux Engineering
