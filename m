From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ATA Passthru unimplemented protocols
Date: Wed, 27 Jul 2005 17:08:52 -0400
Message-ID: <42E7F7E4.90604@pobox.com>
References: <CA45571DE57E1C45BF3552118BA92C9D060A81@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:47042 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262160AbVG0VJL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jul 2005 17:09:11 -0400
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D060A81@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: linux-ide@vger.kernel.org

Timothy Thelin wrote:
> I'm interested in soft reset (1) and return response information (15).  But
> I didn't know who was doing what or had plans for what, which is why the
> question was so general.  If I end up working on these two myself, I'd be
> nice to  coordinate with existing efforts rather than collide with them =)

Certainly!  Your question was just a bit vague :)

The soft reset would be especially nice to have, but would require a bit 
of work to synchronize with other devices on the bus (needed for PATA 
only, really).

Another line item that I would like to see happen is "flagged 
taskfiles", which allows the user to specify which shadow registers to 
touch and -- more importantly -- which not to touch.  This is important 
for vendor-specific commands (particularly older PATA devices).

	Jeff



