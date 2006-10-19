From: Tejun Heo <htejun@gmail.com>
Subject: Re: Question about Scsi error handling/recovery
Date: Thu, 19 Oct 2006 10:50:53 +0900
Message-ID: <4536D9FD.4050708@gmail.com>
References: <8202f4270610181711k7b15f81bw589f956f6e521988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:2064 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1945973AbWJSBve (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 18 Oct 2006 21:51:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so595396pyg
        for <linux-ide@vger.kernel.org>; Wed, 18 Oct 2006 18:51:00 -0700 (PDT)
In-Reply-To: <8202f4270610181711k7b15f81bw589f956f6e521988@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fajun Chen <fajunchen@gmail.com>
Cc: linux-ide@vger.kernel.org

Fajun Chen wrote:
> Hi,
> 
> I tested two SATA drives on the same controller (Sil3124) and found
> that if their hotplug/unplug sequences overlaps, scsi layer will block
> the use of any of the drives during error recovery phase.  So even if
> one drive is recovered way early, it won't process any commands until
> the error recovery  on another drive is completed.  Could someone
> explain why the block is on controller/host basis instead of on port
> basis? Is this because the controller could be reset during any error
> recovery?

I don't think that's true.  Each ATA port is represented as separate 
host to SCSI midlayer, so SCSI doesn't have any way to enforce such 
cross-port synchronization.  In fact, libata needs to implement such 
facility to properly implement transfer mode reconfiguration on several 
controllers.  What exactly are you seeing?

-- 
tejun
