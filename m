From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Question about Scsi error handling/recovery
Date: Wed, 18 Oct 2006 18:11:55 -0600
Message-ID: <8202f4270610181711k7b15f81bw589f956f6e521988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:52533 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1945913AbWJSAL5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Oct 2006 20:11:57 -0400
Received: by py-out-1112.google.com with SMTP id n25so580587pyg
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 17:11:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Hi,

I tested two SATA drives on the same controller (Sil3124) and found
that if their hotplug/unplug sequences overlaps, scsi layer will block
the use of any of the drives during error recovery phase.  So even if
one drive is recovered way early, it won't process any commands until
the error recovery  on another drive is completed.  Could someone
explain why the block is on controller/host basis instead of on port
basis? Is this because the controller could be reset during any error
recovery?

Thanks,
Fajun
