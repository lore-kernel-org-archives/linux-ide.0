From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] CHS: LBA28/LBA48 optimization (revise #6)
Date: Tue, 18 Oct 2005 17:19:21 -0400
Message-ID: <435566D9.2010300@pobox.com>
References: <434CAF8E.5040607@tw.ibm.com> <434CB75A.6010109@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3995 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751509AbVJRVTZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Oct 2005 17:19:25 -0400
In-Reply-To: <434CB75A.6010109@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Albert Lee wrote:
> Patch 4/4: LBA28/LBA48 optimization per Mark's advice.
> 
> Changes:
>      - add lba_28_ok() and lba_48_ok() to ata.h.
>      - check ending block number instead of staring block number.
>      - use lba_28_ok() for CHS range check
>      - LBA28/LBA48 optimization
> 
> Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

applied to the new lba48-opt branch of libata-dev.

We'll probably merge this into the 'upstream' branch after 2.6.15-rc1 is 
released, to enable lots of testing.

	Jeff



