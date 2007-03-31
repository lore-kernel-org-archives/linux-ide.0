From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 0/4] libata: Workaround/fixes for ATAPI devices (revised)
Date: Sat, 31 Mar 2007 19:04:15 +0900
Message-ID: <460E321F.2000100@gmail.com>
References: <460E1586.2000603@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.237]:31393 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741AbXCaKEe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 06:04:34 -0400
Received: by wr-out-0506.google.com with SMTP id 76so968374wra
        for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 03:04:22 -0700 (PDT)
In-Reply-To: <460E1586.2000603@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> patch 1/4: Reorder HSM_ST_FIRST
> patch 2/4: Clear tf before doing request sense
> patch 3/4: Limit max sector to 240 for TORiSAN DVD drives
> patch 4/4: Limit ATAPI DMA to R/W commands only for TORiSAN DVD drives
> 
> (patch 2/4 revised per Tejun's advice.)
> 

All four look good to me.  Thanks a lot for tracking this down.

-- 
tejun
