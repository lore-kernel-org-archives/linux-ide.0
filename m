From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ATA Passthru unimplemented protocols
Date: Thu, 11 Aug 2005 15:38:49 -0400
Message-ID: <42FBA949.4090808@pobox.com>
References: <CA45571DE57E1C45BF3552118BA92C9D060A82@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:16808 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932395AbVHKTiz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 15:38:55 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D060A82@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: linux-ide@vger.kernel.org

Timothy Thelin wrote:
> Well it doesn't seem that nasty to adopt flagged access.  From a userland
> API point of view how about adopting the IDE driver's taskfile mechanism,
> and simply translating that into the yet-to-be internal flagged mechanism?

There is actually already an internal flagged mechanism, but we only 
have two flags at present: ATA_TFLAG_ISADDR and ATA_TFLAG_DEVICE.

	Jeff


