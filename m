From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] drivers/ide/pci/sc1200.c: fix suspend/resume buglets and warnings
Date: Thu, 25 Oct 2007 22:10:46 +0200
Message-ID: <200710252210.47072.bzolnier@gmail.com>
References: <09821349085390234lkjasdflkjasflkdj24746@havoc.gtf.org> <20071024234825.829191F81A2@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:46373 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427AbXJYUGw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 16:06:52 -0400
Received: by ug-out-1314.google.com with SMTP id z38so572967ugc
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 13:06:51 -0700 (PDT)
In-Reply-To: <20071024234825.829191F81A2@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, akpm@linux-foundation.org

On Thursday 25 October 2007, Jeff Garzik wrote:
> * We shouldn't bother with dev->current_state, the PCI API functions we
>   call manage this for us (and do a far better job at it too).
> 
> * Remove pci_set_power_state(dev, PCI_D0) call in resume, as
>   pci_enable_device() does the same thing.
> 
> * Check pci_enable_device() return value.  If it failed, fail
>   the entire resume and avoid programming timings into the [potentially
>   dead/asleep] chip.
> 
> Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

applied, thanks
