From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch] libata: add ioctls to support SMART
Date: Tue, 31 Aug 2004 04:52:54 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <41343C66.3080804@pobox.com>
References: <200408301531.i7UFVBg29089@ra.tuxdriver.com> <41336824.1040206@gmx.de> <41343B2A.80909@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267526AbUHaIxL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Aug 2004 04:53:11 -0400
In-Reply-To: <41343B2A.80909@gmx.de>
List-Id: linux-ide@vger.kernel.org
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Prakash K. Cheemplavam wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Prakash K. Cheemplavam wrote:
> | John W. Linville wrote:
> | | Support for HDIO_DRIVE_CMD and HDIO_DRIVE_TASK in libata.  Useful for
> | | supporting SMART w/ unmodified smartctl and smartd userland binaries.
> ~ > I just tried to give it a go with libata from 2.6.9-rc1. I had to fix
> | one rejects but the patching seemed to go fine beside that. Nevertheless
> | after a boot with patched libata I get:
> |
> | smartctl -a /dev/sda
> [snip]
> 
> | Device does not support SMART
> 
> Just wanted
> 
> Just wanted to say that smartctl -a -d ata /dev/sda works, as John
> Linville and now Bruce aLlen suggested to try.


As I noted in another email, be careful...  that patch bypasses the SCSI 
command synchronization, so you could potentially send a SMART command 
to the hardware while another command is still in progress.

	Jeff


