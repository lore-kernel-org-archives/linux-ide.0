From: Mark Lord <kernel@start.ca>
Subject: Re: [PATCH v2] libata: add support for NCQ commands for SG interface
Date: Mon, 16 Nov 2015 08:47:19 -0500
Message-ID: <5649DE67.7080509@start.ca>
References: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail3.start.ca ([64.140.120.243]:57423 "EHLO mail3.start.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbbKPNrn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 16 Nov 2015 08:47:43 -0500
In-Reply-To: <1445924955-11124-1-git-send-email-vinayak.kale@seagate.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: vinayak.kale@gmail.com, tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sumit.g.gupta@seagate.com, Vinayak Kale <vinayak.kale@seagate.com>

On 15-10-27 01:49 AM, vinayak.kale@gmail.com wrote:
> From: Vinayak Kale <vinayak.kale@seagate.com>
>
> This patch is needed to make NCQ commands with FPDMA protocol value
> (eg READ/WRITE FPDMA) work over SCSI Generic (SG) interface.
..
> +	/* For NCQ commands with FPDMA protocol, copy the tag value */
> +	if (tf->protocol == ATA_PROT_NCQ)
> +		tf->nsect = qc->tag << 3;
> +


What prevents the qc-tag value here from conflicting with in-flight I/O
using the exact same qc-tag ??
