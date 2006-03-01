From: Tejun Heo <htejun@gmail.com>
Subject: regarding sata_sil errata
Date: Wed, 1 Mar 2006 14:25:40 +0900
Message-ID: <20060301052540.GA20926@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:52687 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932170AbWCAFZq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 00:25:46 -0500
Received: by zproxy.gmail.com with SMTP id s18so56225nze
        for <linux-ide@vger.kernel.org>; Tue, 28 Feb 2006 21:25:46 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Carlos Pardo <Carlos.Pardo@siliconimage.com>, Raymond Liu <Raymond.Liu@siliconimage.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello, all.

Now that we have R_ERR on DMA activate FIS errata workaround in place,
sata_sil driver seems to work much better now.  There are two things
to do regarding sata_sil errata.

1. removing non-affected drives from m15w blacklist.  I think we
   should test this in -mm for some time before submitting to
   upstream.  Will submit a patch soon.

2. determining which are 3112 and which are 3512.

   Carlos and Raymond, can you guys please let us know which are 3112
   and which are 3512?  The PCI IDs in question are 0x1095/0x0240,
   0x1002/0x436e, 0x1002/0x4379 and 0x1002/0x437a.  All these IDs are
   currently treated as 3112 but it's a shame to apply m15w when a
   controller can work happily with R_ERR on DMA activate FIS errata,
   isn't it?

Thanks.  :-)

-- 
tejun
