From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] alim15x3: Remove historical hacks, re-enable init_hwif for PowerPC
Date: Thu, 30 Apr 2009 18:39:09 +0200
Message-ID: <200904301839.13468.bzolnier@gmail.com>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com> <c8485d470904270146g7b7204eckc58cd57449a41f45@mail.gmail.com> <20090427184742.GA6435@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:61476 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756460AbZD3Qhx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Apr 2009 12:37:53 -0400
Received: by bwz7 with SMTP id 7so1915054bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 30 Apr 2009 09:37:51 -0700 (PDT)
In-Reply-To: <20090427184742.GA6435@oksana.dev.rtsoft.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: avorontsov@ru.mvista.com
Cc: Roderick Colenbrander <thunderbird2k@gmail.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Monday 27 April 2009 20:47:42 Anton Vorontsov wrote:
> Some time ago we had to disable init_hwif callback for PowerPC builds.
> That was because of a historical IRQ overwrite in the driver, which
> was causing IDE malfunction on the MPC8610HPCD PowerPC boards.
> 
> It's unclear whether this overwrite is still useful, but it is proven
> to cause a bit of harm, and today some PowerPC targets (Xilinx ML510,
> as reported by Roderick Colenbrander) need the init_hwif, so we have
> to re-enable it and remove the overwrite.
> 
> Reported-by: Roderick Colenbrander <thunderbird2k@gmail.com>
> Suggested-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

thanks, I applied it to ide-2.6.git/for-next
