From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [discuss] pci_get_device_reverse(), why does Calgary need this?
Date: Thu, 14 Feb 2008 13:11:42 +0100
Message-ID: <200802141311.43103.bzolnier@gmail.com>
References: <20080213001506.GA13933@kroah.com> <20080213181655.GB8960@kroah.com> <ho3arwq8w7.fsf@reger.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:15620 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759118AbYBNMO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 07:14:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so210354nfb.21
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 04:14:56 -0800 (PST)
In-Reply-To: <ho3arwq8w7.fsf@reger.suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andreas Jaeger <aj@suse.de>
Cc: Greg KH <greg@kroah.com>, muli@il.ibm.com, discuss@x86-64.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jdmason@kudzu.us, linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thursday 14 February 2008, Andreas Jaeger wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > How does the patch below look?  I didn't want to remove the whole config
> > option, as there is more to the logic than just the "reverse order"
> > stuff there.
> 
> I think you miss Documentation - it's mentioned in ide.txt and
> kernel-parameters.txt,

+ drivers/ide/Kconfig

Greg, please update the patch (and add my S-o-B while at it).

Thanks,
Bart
