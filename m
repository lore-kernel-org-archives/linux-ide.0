From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/2] libata-dev: determine err_mask when error is found
Date: Tue, 17 Jan 2006 19:55:39 -0500
Message-ID: <43CD920B.5000505@pobox.com>
References: <43AFAC95.7030207@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16049 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932504AbWARAzr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jan 2006 19:55:47 -0500
In-Reply-To: <43AFAC95.7030207@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>

Albert Lee wrote:
> Jeff,
> 
> Patch 1/2: Minor fix to determine err_mask directly when an error is found.
> 
> Changes:
> - Determine err_mask directly when an error is found.
> - Remove "qc->err_mask |= __ac_err_mask(status);" in ata_host_intr() 
> 
> Patch against the libata-dev irq-pio branch 
> (3d0a59c02303df01848537b3bf938dc11e9a0ded).

applied 1-2 to irq-pio branch


