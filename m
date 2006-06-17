From: Tejun Heo <htejun@gmail.com>
Subject: regarding conversion to new EH
Date: Sat, 17 Jun 2006 20:31:04 +0900
Message-ID: <20060617113104.GC11755@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:29957 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751613AbWFQLbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 07:31:09 -0400
Received: by py-out-1112.google.com with SMTP id i49so849219pye
        for <linux-ide@vger.kernel.org>; Sat, 17 Jun 2006 04:31:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Mark Lord <mlord@pobox.com>, linux-ide@vger.kernel.org

Hello, Jeff, Mark.

Currently, EH conversion status in #upstream is...

complete:	ata_piix, ahci, sata_sil, sata_sil24
submitted:	sata_sis, sata_svw, sata_uli, sata_vsc, sata_via, sata_nv
trying:		sata_qstor, pdc_adma
todo:		sata_sx4, sata_promise, sata_mv

For the last three todo drivers, I have no idea how those things work
and don't have access to the hardware or doc.

Jeff, sx4 seems to be a strain of promise controllers.  Can you
convert that one too in addition to sata_promise?

I guess the two 'trying' conversions are probably broken.  Mark, it
would be great if you can verify them.  Also, can you please convert
sata_mv to new EH?

I'll now convert the PATA drivers.

Thanks a lot.

-- 
tejun
