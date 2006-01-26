From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCHSET] libata: reorganize configuration and implement revalidation
Date: Thu, 26 Jan 2006 12:42:37 -0500
Message-ID: <43D90A0D.6000900@rtr.ca>
References: <1138289951261-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:49382 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751317AbWAZRnR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jan 2006 12:43:17 -0500
In-Reply-To: <1138289951261-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk

Tejun Heo wrote:
>
> Also, please pay attention to the following.  It's taken from #08's
> description.
> 
>   This function is probably the place to set transfer mode to PIO0
>   before IDENTIFY.  However, reset -> identify -> init_dev_params
>   order should be kept for pre-ATA4 devices so we cannot set transfer
>   mode before IDENTIFY for them.  How do we know if a device is
>   post-ATA4 before IDENTIFY?
> 
> How should we do this?  Ignore pre-ATA4 devices?

It should be more a matter of setting the chipset to PIO0
before doing the IDENTIFY.

The drives themselves should "just work", as the RESET would
have bumped them back to their default (slow) PIO timing mode.

IDENTIFY has to be the very first drive command, so there's no
way to do a SET_FEATURES/XFER_MODE beforehand.

-ml
