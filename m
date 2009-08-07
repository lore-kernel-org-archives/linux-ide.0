From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] When a disk needs to be waken up from sleep, ensure that
 	the command is retried by SCSI EH.
Date: Fri, 07 Aug 2009 17:34:11 +0900
Message-ID: <4A7BE703.3000004@kernel.org>
References: <1249579547-21091-1-git-send-email-gwendal@google.com> <e7510f760908061028o1b005c4wd2552c24fc619d9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59547 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757293AbZHGIcC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 04:32:02 -0400
In-Reply-To: <e7510f760908061028o1b005c4wd2552c24fc619d9e@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Gwendal Grignou wrote:
> The explanation did not go through git-send-email:
> 
>  Without this fix, ATA passthrough commands are not resend to the
> drive, and no error is
>  signalled to the caller because:
>  - allowed retry count is 1
>  - ata_eh_qc_complete fill the sense data, so result is valid
>  - sense data is filled with untouched ATA registers.

Would setting ATA_QCFLAG_RETRY achieve the same result?

Thanks.

-- 
tejun
