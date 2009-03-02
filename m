From: Tejun Heo <tj@kernel.org>
Subject: Re: Backplane mystery
Date: Mon, 02 Mar 2009 17:46:14 +0900
Message-ID: <49AB9CD6.1060404@kernel.org>
References: <49A6B441.8010605@seiner.com> <49A6B683.9060806@rtr.ca> <49A8093A.1030401@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53304 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbZCBIp5 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 2 Mar 2009 03:45:57 -0500
In-Reply-To: <49A8093A.1030401@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: linux-ide@vger.kernel.org

Yan Seiner wrote:
> [   82.533526] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [   82.533606] ata3: link online but device misclassified, retrying
> [   82.533686] ata3: reset failed (errno=-11), retrying in 9 secs
> 
> Is there some way to be more forceful with the reset?  I suspect one of
> the port multiplier boards is bad at this point.  Is there some way to
> force a hard reset from user space?  What can I from userspace short of
> hitting the thing with a hammer?

ATA already uses hardreset.  You can trigger it by echoing "- - -" to
/sys/class/scsi_host/hostN/scan but I doubt it would do any good.  :-(

-- 
tejun
