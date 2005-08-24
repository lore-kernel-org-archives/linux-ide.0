From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Another libata TODO item
Date: Wed, 24 Aug 2005 13:24:28 -0400
Message-ID: <430CAD4C.9030804@pobox.com>
References: <430C10E7.9060502@pobox.com>	<20050824074116.GF24513@infradead.org> <430C271E.7060006@pobox.com>	<52d5o31fce.fsf@cisco.com> <430CA617.6090106@pobox.com> <52ll2rz1zm.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:11672 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751240AbVHXRYf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Aug 2005 13:24:35 -0400
In-Reply-To: <52ll2rz1zm.fsf@cisco.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roland Dreier <rolandd@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>

Roland Dreier wrote:
>     Jeff> Look at net drivers.  Theres no real infrastructure beyond
>     Jeff> bit tests and printks.  I wouldn't call that a subsystem,
>     Jeff> so, I wouldn't call this one such either.
> 
> Well, scsi_logging.h isn't much of a subsystem either.

You obviously did not grep for CONFIG_SCSI_LOGGING :)

	Jeff


