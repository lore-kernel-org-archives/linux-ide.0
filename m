From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 03/12] libata-pmp: implement ATA_LFLAG_DISABLED
Date: Wed, 19 Jul 2006 16:36:00 -0400
Message-ID: <44BE97B0.9030809@pobox.com>
References: <11523382872631-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:11660 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030282AbWGSUgE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Jul 2006 16:36:04 -0400
In-Reply-To: <11523382872631-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: alan@lxorguk.ukuu.org.uk, lkml@rtr.ca, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Implement ATA_LFLAG_DISABLED.  The flag indicates the link is disabled
> due to EH recovery failure.  While a link is disabled, no EH action is
> taken on the link and suspend/resume become noop too.  For host port,
> this doesn't introduce any behavior change other than not invoking
> hotplug sequence on failed ports on resume and this behavior change is
> intended.

why?

libata should notice new devices, when resuming.

	Jeff



