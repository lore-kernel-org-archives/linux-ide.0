From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] When a disk needs to be waken up from sleep, ensure that
 the command is retried by SCSI EH.
Date: Sat, 08 Aug 2009 08:12:22 +0900
Message-ID: <4A7CB4D6.7020902@kernel.org>
References: <4A7CACBE.6090208@kernel.org> <1249686403-29742-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50503 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844AbZHGXKB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Aug 2009 19:10:01 -0400
In-Reply-To: <1249686403-29742-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Gwendal Grignou wrote:
>  Without this fix, ATA passthrough commands are not resend to the drive, and no error is

80 column.

>  signalled to the caller because:
>  - allowed retry count is 1
>  - ata_eh_qc_complete fill the sense data, so result is valid
>  - sense data is filled with untouched ATA registers.

and Signed-off-by:

Thanks.

-- 
tejun
