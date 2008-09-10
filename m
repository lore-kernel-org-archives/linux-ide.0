From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 00/18] ide: add generic ATA/ATAPI disk driver
Date: Wed, 10 Sep 2008 13:20:44 +0200
Message-ID: <20080910112044.GB10263@gollum.tnic>
References: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:21383 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYIJLVM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Sep 2008 07:21:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2106229fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 10 Sep 2008 04:21:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080907221424.24285.81137.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 08, 2008 at 12:14:24AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> [ Borislav, this is the 'futuristic' stuff that we were talking about. :) ]
> 
> Hi,
> 
> This patch series adds a generic ATA/ATAPI disk driver (ide-gd) replacing
> ide-disk and ide-floppy drivers.  It is achieved by moving the common code
> to ide-gd.c, adding struct ide_disk_ops (which is used to abstract protocol
> specific details) and updating ide-{disk,floppy}.c accordingly.
> 
> The main goal is to make the code more maintainable / easier to extend later.
> As an immediate result we get driver specific debugging support for ATA disks
> and ability for driver specific Power Management for ATAPI devices.  Otherwise
> it is really an initial merge (which means that in the future the code can be
> further unified, struct ide_disk_ops can be made more fine-grained etc.).

Looks cool, ACK with some comments/questions in separate mail. Will test on my
Iomega ZIP drive when I get back.

-- 
Regards/Gruss,
    Boris.
