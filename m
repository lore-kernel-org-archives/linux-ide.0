From: Tejun Heo <htejun@gmail.com>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
Date: Thu, 10 Feb 2005 09:52:25 +0900
Message-ID: <420AB049.4040705@gmail.com>
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl>	 <4206F2E5.7020501@gmail.com>	 <200502070959.54973.bzolnier@elka.pw.edu.pl>	 <420AA476.1040406@gmail.com> <58cb370e050209162437808733@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.205]:40843 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261996AbVBJAwc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2005 19:52:32 -0500
Received: by wproxy.gmail.com with SMTP id 68so36742wri
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2005 16:52:31 -0800 (PST)
In-Reply-To: <58cb370e050209162437808733@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>


  Okay, another quick question.

  To fix the io_32bit race problem in ide_taskfile_ioctl() (and later 
ide_cmd_ioctl() too), it seems simplest to mark the taskfile with 
something like ATA_TFLAG_IO_16BIT flag and use the flag in task_in_intr().

  However, ATA_TFLAG_* are used by libata, and I think that, although 
sharing hardware constants is good if the hardware is similar, sharing 
driver-specific flags isn't such a good idea.  So, what do you think?

  1. Add ATA_TFLAG_IO_16BIT to ata.h
  2. Make ide's own set of task flags, maybe IDE_TFLAG_* (including
     IDE_TFLAG_LBA48)

-- 
tejun

