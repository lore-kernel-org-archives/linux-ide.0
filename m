From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 06/12] SCSI: export scsi_eh_finish_cmd() and scsi_eh_flush_done_q()
Date: Sun, 22 Jan 2006 04:36:55 -0500
Message-ID: <43D35237.8090206@pobox.com>
References: <1137916710230-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:19686 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932276AbWAVJg5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:36:57 -0500
In-Reply-To: <1137916710230-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> Export two SCSI EH command handling functions.  To be used by libata EH.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

OK, though don't forget to CC linux-scsi on this patch.


