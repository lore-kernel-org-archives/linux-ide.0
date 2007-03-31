From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/4] libata: Workaround/fixes for ATAPI devices (revised)
Date: Sat, 31 Mar 2007 15:57:26 +0200
Message-ID: <200703311557.26949.bzolnier@gmail.com>
References: <460E1586.2000603@tw.ibm.com> <460E321F.2000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:21085 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbXCaNs7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 09:48:59 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1082957uga
        for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 06:48:58 -0700 (PDT)
In-Reply-To: <460E321F.2000100@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertl@mail.com, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>


On Saturday 31 March 2007, Tejun Heo wrote:
> Albert Lee wrote:
> > patch 1/4: Reorder HSM_ST_FIRST
> > patch 2/4: Clear tf before doing request sense
> > patch 3/4: Limit max sector to 240 for TORiSAN DVD drives
> > patch 4/4: Limit ATAPI DMA to R/W commands only for TORiSAN DVD drives
> > 
> > (patch 2/4 revised per Tejun's advice.)
> > 
> 
> All four look good to me.  Thanks a lot for tracking this down.

Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Special thanks for fixing implicit libata vs drivers/ide regressions
(patch 2/4 and 3/4).

Bart
