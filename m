From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata-scsi:  be tolerant of 12-byte ATAPI commands in 16-byte CDBs
Date: Wed, 14 Nov 2007 12:50:28 -0500
Message-ID: <20071114175028.GA9546@devserv.devel.redhat.com>
References: <20071113164323.GA5252@section-eight> <20071113212230.77cadecd@the-village.bc.nu> <20071113232859.GA4681@section-eight> <473B0FA2.5000102@rtr.ca> <20071114153852.GA9019@section-eight> <473B1B83.9020103@rtr.ca> <473B33F7.7030708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:47399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762149AbXKNRv1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Nov 2007 12:51:27 -0500
Content-Disposition: inline
In-Reply-To: <473B33F7.7030708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Sebastian Kemper <sebastian_ml@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>

On Wed, Nov 14, 2007 at 12:44:23PM -0500, Mark Lord wrote:
> Sebastian Kemper reported that issuing CD/DVD commands under libata
> is not fully compatible with ide-scsi.  In particular, the 
> GPCMD_SET_STREAMING
> was being rejected at the host level in some instances.
> 
> The reason is that libata-scsi insists upon the cmd_len field exactly 
> matching
> the SCSI opcode being issued, whereas ide-scsi tolerates 12-byte commands
> contained within a 16-byte (cmd_len) CDB.
> 
> There doesn't seem to be a good reason for us to not be compatible there,
> so here is a patch to fix libata-scsi to permit SCSI opcodes so long as
> they fit within whatever size CDB is provided.
> 
> Signed-off-by: Mark Lord <mlord@pobox.com>

Acked-by: Alan Cox <alan@redhat.com>

