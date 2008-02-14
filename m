From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: pci_get_device_reverse(), why does Calgary need this?
Date: Thu, 14 Feb 2008 16:09:47 +0300
Message-ID: <47B43D9B.3020105@ru.mvista.com>
References: <20080213001506.GA13933@kroah.com> <20080213172824.GB10733@kroah.com> <20080213181655.GB8960@kroah.com> <200802132320.37172.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:8170 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751376AbYBNNIv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 14 Feb 2008 08:08:51 -0500
In-Reply-To: <200802132320.37172.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, muli@il.ibm.com, jdmason@kudzu.us, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, discuss@x86-64.org

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ide: mark "ide=reverse" option as obsolete

> - it is valid only if "Probe IDE PCI devices in the PCI bus order
>   (DEPRECATED)" config option is used

> - Greg needs to remove pci_get_device_reverse() for PCI core changes

> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei
