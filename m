From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [patch libata-2.6] libata: SMART support via ATA pass-thru
Date: Thu, 30 Sep 2004 15:52:31 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <415C63FF.4090105@pobox.com>
References: <20040928001633.A8363@florence.linkmargin.com> <20040930141302.B14317@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30857 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269455AbUI3Twq
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Sep 2004 15:52:46 -0400
In-Reply-To: <20040930141302.B14317@tuxdriver.com>
List-Id: linux-ide@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Andy Warner <andyw@pobox.com>, linux-ide@vger.kernel.org

John W. Linville wrote:
> Patch to add support for SMART to libata via the HDIO_DRIVE_CMD and
> HDIO_DRIVE_TASK ioctls.  These ioctls are translated to ATA pass-thru
> CDBs and submitted via scsi_wait_req().
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>

Looks pretty good to me...

I'll roll a new libata-dev bundle today or tomorrow.

	Jeff



