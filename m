From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/4] libata: Limit ATAPI DMA to R/W commands only for
 TORiSAN DVD drives
Date: Sat, 31 Mar 2007 16:30:23 +0900
Message-ID: <460E0E0F.8050800@gmail.com>
References: <460E08AF.8070900@tw.ibm.com> <460E0D51.70505@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.226]:41972 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXCaHaa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 31 Mar 2007 03:30:30 -0400
Received: by wr-out-0506.google.com with SMTP id 76so943470wra
        for <linux-ide@vger.kernel.org>; Sat, 31 Mar 2007 00:30:30 -0700 (PDT)
In-Reply-To: <460E0D51.70505@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, YUP <yupadmin@gmail.com>, Vlad Codrea <VladCodrea@mail.utexas.edu>, IDE Linux <linux-ide@vger.kernel.org>

Albert Lee wrote:
> patch 4/4:
> 
>   Limit ATAPI DMA to R/W commands only for TORiSAN DRD-N216 DVD-ROM drives
>   (http://bugzilla.kernel.org/show_bug.cgi?id=6710)
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
