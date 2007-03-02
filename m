From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 4/4] libata: improve media error handling
Date: Fri, 02 Mar 2007 18:37:11 -0500
Message-ID: <45E8B527.7090903@garzik.org>
References: <11635120303772-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54756 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992753AbXCBXhO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Mar 2007 18:37:14 -0500
In-Reply-To: <11635120303772-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> The ATA spec says "The amount of data transferred is indeterminate"
> when READ/WRITE commands fail with error status.  TF regs contain the
> address of the first sector which failed, but that's it.  libata
> reports the reported sector to sd which assumes data upto the first
> failed sector was transferred successfully.  This can result in data
> corruption.
> 
> This patch implements highlevel command-aware recovery which currently
> has only one recovery action - ata_eh_do_partial().  If the device
> reports the first failed block, it tries to transfer upto that block.
> 
> SCSI sense generation is updated such that the first failed block is
> reported to SCSI layer iff partial IO occurred.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-eh.c   |  143 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata-scsi.c |   36 +++++++-----
>  include/linux/libata.h    |    2 +
>  3 files changed, 166 insertions(+), 15 deletions(-)

(finally reviewing a patch from a 3 months ago)

ACK, please resend at your leisure

In general, I have worries about how solid partial completion really is. 
  I am mainly thinking of SCSI and VFS not libata, here.  Your patch 
looks sane enough, so let's see how things go...

	Jeff



