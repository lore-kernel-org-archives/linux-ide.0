From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SATA Promise driver
Date: Wed, 02 Jun 2004 14:40:22 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40BE1F16.2030609@pobox.com>
References: <007101c448ce$fd2cc8d0$0a01a8c0@jbsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28842 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263366AbUFBSkm
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jun 2004 14:40:42 -0400
In-Reply-To: <007101c448ce$fd2cc8d0$0a01a8c0@jbsys.com>
List-Id: linux-ide@vger.kernel.org
To: Jim B <jim@jbsys.com>
Cc: linux-ide@vger.kernel.org

Jim B wrote:
>  Jeff
> 
> I have a K8V SE Deluxe MoBo with a Promise FastTrack 378 controller.  It can be
> used as a RAID or extended IDE controller by sellecting the proper BIOS setting.
> I have tried the RAID setting and used ft3xx.o driver (from Promise) in FC1 2.4
> kernels to use the two 160 GB IDE disks.  I currently have it set to extended
> IDE.  I use the pdc-ultra.o driver (from Promise) in FC1 2.4 kernels for this
> mode.  I installed FC2 x86_64 version to another partition on the standard IDE
> disk.  It boots and works, except it will not see the PATA drives on the Promise
> controller.  It says there are no drives present.  Does the SATA_Promise module
> support this controller in either of these modes?  Am I doing something wrong?
> Is it because I am using IDE drives instead of SATA drivers?

As the name implies, sata_promise driver does not support PATA.

This support is planned, but not present yet.

	Jeff



