From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 7/7] libata: remove ap->last_ctl
Date: Fri, 13 Jul 2007 15:58:32 +0900
Message-ID: <46972298.7020504@gmail.com>
References: <468F3949.5050800@tw.ibm.com> <468F3F8B.5010200@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:46678 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935841AbXGMG6j (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 02:58:39 -0400
Received: by wa-out-1112.google.com with SMTP id v27so476453wah
        for <linux-ide@vger.kernel.org>; Thu, 12 Jul 2007 23:58:38 -0700 (PDT)
In-Reply-To: <468F3F8B.5010200@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Maxey <dwm@enoyolf.org>, Mark Lord <mlord@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> With the previous changes made to tf_load(), ap->last_ctl is now unused. Remove it.
> 
> (The purpose of ap->last_ctl is to cache the last status of nIEN bit
> and hopefully avoid writing the Control register unnecessarily.
> However, the libata polling code always call irq_on() in ata_hsm_qc_complete()
> and such mechanism isn't much utilized.)
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

Ack 6-7.  Thanks for cleaning irq on/off up.  Things should have been
done this way from the beginning.  Also, I think removing last_ctl
caching (or whatever is left of it) should be okay.  Only polling PIO
path is affected and one or two more ioport accesses won't make any
meaningful difference anyway.

-- 
tejun
