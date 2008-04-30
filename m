From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCHSET] sata_inic162x: make it work
Date: Wed, 30 Apr 2008 16:39:19 +0900
Message-ID: <48182227.4080802@gmail.com>
References: <12095409172824-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.248]:31736 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755876AbYD3HjZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Apr 2008 03:39:25 -0400
Received: by rv-out-0506.google.com with SMTP id k29so212133rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Apr 2008 00:39:24 -0700 (PDT)
In-Reply-To: <12095409172824-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Hello, Jeff, Alan.
> 
> Initio took the sata_inic162x driver, implemented ATA_PROT_DMA using
> IDMA, renamed it to sata_initio162x and posted on their website.  It
> didn't work very well for me but contained enough hint on how to use
> IDMA mode.
> 
> So, this is the patchset to make sata_inic162x to use IDMA for
> everything including ATAPIs.  There are still some issues - result TF
> is not accessible, !read ATAPI commands should be issued using
> ATAPI_PROT_PIO, but overall, everything including suspend/resume,
> hotplug and burning cd/dvds works nicely.

Available as git tree.

  http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=inic162x
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git inic162x

Thanks.

-- 
tejun
