From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 10/19] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA
Date: Fri, 12 Jan 2007 21:44:57 +0100
Message-ID: <58cb370e0701121244nd38406aod6b5f8b8ca68fe5e@mail.gmail.com>
References: <20070112042621.28794.6937.sendpatchset@localhost.localdomain>
	 <20070112042710.28794.40403.sendpatchset@localhost.localdomain>
	 <45A7E062.3080403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:47908 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030241AbXALUpA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 12 Jan 2007 15:45:00 -0500
Received: by ug-out-1314.google.com with SMTP id 44so887785uga
        for <linux-ide@vger.kernel.org>; Fri, 12 Jan 2007 12:44:58 -0800 (PST)
In-Reply-To: <45A7E062.3080403@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Hi,

On 1/12/07, Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Bartlomiej Zolnierkiewicz wrote:
>
> > [PATCH] trm290: remove redundant CONFIG_BLK_DEV_IDEDMA #ifdef-s
>
>     Nice to see you riding again. :-)

Thanks!

> > In drivers/ide/Kconfig BLK_DEV_TRM290 depends on
> > BLK_DEV_IDEDMA_PCI (on which is BLK_DEV_IDEDMA dependant on).
>
>     I also remember you urging me to get rid of ide_setup_dma() call there. ;-)

Hmm, I seem to have a patch doing this but it depends on unfinished
"struct ide_dma_ops" patch (which folds individual hwif->[ide_]dma*
methods into nice structure)...

Bart
