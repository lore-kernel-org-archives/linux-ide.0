From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/02] sata_mv: warn on PIO with multiple DRQs
Date: Thu, 19 Jun 2008 10:48:47 +0900
Message-ID: <4859BAFF.1060800@gmail.com>
References: <485933A4.3010409@rtr.ca> <4859340E.60203@rtr.ca> <4859A886.8000509@pobox.com> <4859B9E2.4060909@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:44271 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbYFSBsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 21:48:53 -0400
Received: by ti-out-0910.google.com with SMTP id b6so219416tic.23
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 18:48:51 -0700 (PDT)
In-Reply-To: <4859B9E2.4060909@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
>>> We may also want a patch to prevent libata-eh from downshifting
>>> all the way to PIO on these chipsets, but I am not sure how to
>>> accomplish that from inside sata_mv.  Any suggestions?
>>
>> Do we really want that?  Seems to me we need that for older bridged
>> PATA devices attached to a SATA bridge.
> ..
> 
> Just about everything can do some form of DMA nowadays,
> but regardless of that the sata_mv chipsets have errata
> for PIO of anything more than a single sector.
> 
> In practice, I haven't managed to trigger the issue here,
> but the errata descriptions indicate that it should be a major
> issue for any volume of multi-sector PIO commands.

The following nack'd patch has something similar if it's really necessary.

http://article.gmane.org/gmane.linux.ide/32282

-- 
tejun
