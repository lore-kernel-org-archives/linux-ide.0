From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: fix drive_is_ready() for non-PCI hosts and CONFIG_IDEPCI_SHARE_IRQ=y
Date: Fri, 26 Oct 2007 02:30:52 +0200
Message-ID: <200710260230.52115.bzolnier@gmail.com>
References: <200710260136.37333.bzolnier@gmail.com> <20071026010515.260672b4@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:21935 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbXJZAYl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 20:24:41 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1110365mue
        for <linux-ide@vger.kernel.org>; Thu, 25 Oct 2007 17:24:39 -0700 (PDT)
In-Reply-To: <20071026010515.260672b4@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 26 October 2007, Alan Cox wrote:
> On Fri, 26 Oct 2007 01:36:37 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Need to check if the host is a PCI one before reading IDE_ALTSTATUS_REG.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Umm why ? The altstatus register goes back to ST-506 and the original IBM
> XT hard disk controller card ?

Thought that there have to be some (non-obvious) reason behing the fact that
IDE_ALTSTATUS_REG reading was covered by #ifdef CONFIG_IDEPCI_SHARE_IRQ.

However if this is the case patch #2/3 can be dumped and we can go straight
to patch #3/3.

Thanks,
Bart
