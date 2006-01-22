From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/12] libata: fix ata_qc_issue() error handling
Date: Sun, 22 Jan 2006 04:25:24 -0500
Message-ID: <43D34F84.4020508@pobox.com>
References: <11379167102315-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:13030 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932256AbWAVJZ2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Jan 2006 04:25:28 -0500
In-Reply-To: <11379167102315-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, albertcc@tw.ibm.com

Tejun Heo wrote:
> When ata_qc_issue() fails, the qc might have been dma mapped or not.
> So, performing only ata_qc_free() results in dma map leak.  This patch
> makes ata_qc_issue() mark dma map flags correctly on failure and calls
> ata_qc_complete() after ata_qc_issue() fails.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

ACK patches 1-3


