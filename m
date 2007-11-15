From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata-scsi:  be tolerant of 12-byte ATAPI commands in
 16-byte CDBs
Date: Thu, 15 Nov 2007 11:26:03 +0900
Message-ID: <473BAE3B.2050906@gmail.com>
References: <20071113164323.GA5252@section-eight> <20071113212230.77cadecd@the-village.bc.nu> <20071113232859.GA4681@section-eight> <473B0FA2.5000102@rtr.ca> <20071114153852.GA9019@section-eight> <473B1B83.9020103@rtr.ca> <473B33F7.7030708@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:19703 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335AbXKOC0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 21:26:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so357774rvb
        for <linux-ide@vger.kernel.org>; Wed, 14 Nov 2007 18:26:14 -0800 (PST)
In-Reply-To: <473B33F7.7030708@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Sebastian Kemper <sebastian_ml@gmx.net>, Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>

Mark Lord wrote:
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

applied to #tj-upstream-fixes.

-- 
tejun
