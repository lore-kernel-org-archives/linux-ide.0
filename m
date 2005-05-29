From: Michael Thonke <iogl64nx@gmail.com>
Subject: Re: Playing with SATA NCQ
Date: Sun, 29 May 2005 23:49:54 +0200
Message-ID: <429A3902.8030109@gmail.com>
References: <20050526140058.GR1419@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.205]:9166 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261451AbVE2VuB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 May 2005 17:50:01 -0400
Received: by wproxy.gmail.com with SMTP id 68so1441155wri
        for <linux-ide@vger.kernel.org>; Sun, 29 May 2005 14:50:01 -0700 (PDT)
In-Reply-To: <20050526140058.GR1419@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

sometimes when I boot the kernel is unable to get the correct geometrie
of my Samsung drives.

Can only provide this message the kernel prints:

    getblk();invalid blocksize 166869779 hardsect: 512

That's everthing I've got.

When it boot correctly I get this for the drives:

    SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sda: drive cache: write back
    SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sda: drive cache: write back
     sda: sda1 sda2 < sda5 >
    Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
    SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
    Losing some ticks... checking if CPU frequency changed.
    SCSI device sdb: drive cache: write back
    SCSI device sdb: 312581808 512-byte hdwr sectors (160042 MB)
    SCSI device sdb: drive cache: write back
     sdb: sdb1 sdb2 < sdb5 sdb6 >

If you need further infos let me now.

Greets
    Michael

