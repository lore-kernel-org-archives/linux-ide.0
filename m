From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/4] libata: convert pio_task and packet_task to port_task
Date: Sat, 11 Mar 2006 18:43:29 -0500
Message-ID: <441360A1.7080402@pobox.com>
References: <114154014972-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:53941 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751245AbWCKXnl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Mar 2006 18:43:41 -0500
In-Reply-To: <114154014972-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Make pio_task and atapi_packet_task use port_task.
> atapi_packet_task() is moved upward such that it's right after
> ata_pio_task().  This position is more natural and makes adding
> prototype for ata_qc_issue_prot() unnecessary.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

Applied 1-4, though in the future, please -do not- include function 
shuffling in the same patch as other changes.  atapi_packet_task() has 
been moved all over the place, over the lifetime of libata, and it just 
clutters up cumulative diffs at review time.

	Jeff



