From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Thu, 19 Aug 2004 14:12:23 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4124ED87.6040702@pobox.com>
References: <411FD744.2090308@pobox.com> <4120E693.8070700@pobox.com> <4124C135.7050200@rtr.ca> <200408191751.19101.bzolnier@elka.pw.edu.pl> <4124E701.5020905@rtr.ca> <4124E9F6.6030000@pobox.com> <4124EB91.60706@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266631AbUHSSMj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 19 Aug 2004 14:12:39 -0400
In-Reply-To: <4124EB91.60706@rtr.ca>
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Mark Lord wrote:
>  >* I don't mind HDIO_DRIVE_TASK nearly as much as HDIO_DRIVE_CMD,
>  >* since the command protocol is available.
> 
> That's not HDIO_DRIVE_TASKFILE, by the way..  a different beast there.
> 
> HDIO_DRIVE_TASK is just a slightly different form of HDIO_DRIVE_CMD
> for non-data commands (specifically, some SMART commands),
> with a more complete register set being exchanged.

Oops, indeed I meant HDIO_DRIVE_TASKFILE.

Anyway, once the infrastructure for the ATA Pass-thru CDB is implemented 
in libata, it is trivial to implement any of these three HDIO_DRIVE_xxx 
ioctls, using the ioctl data to build a scsi command internally.  A bit 
strange at first glance, but it maximizes the leverage of existing 
kernel infrastructure to send commands, time them out, etc.

	Jeff


