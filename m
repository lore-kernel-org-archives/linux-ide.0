From: Jeff Garzik <jeff@garzik.org>
Subject: Re: How to activate pata support of ata_piix in vanilla 2.6.18?
Date: Thu, 28 Sep 2006 08:27:10 -0400
Message-ID: <451BBF9E.6010004@garzik.org>
References: <87slicw5q5.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:53990 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750823AbWI1M1M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 28 Sep 2006 08:27:12 -0400
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75] helo=[10.10.10.99])
	by mail.dvmed.net with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1GSuyt-0005Ox-97
	for linux-ide@vger.kernel.org; Thu, 28 Sep 2006 12:27:11 +0000
In-Reply-To: <87slicw5q5.fsf@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Elias Oltmanns wrote:
> A git checkout of libata-dev.git worked out of the
> box. My question is whether pata support in ata_piix was intentionally
> not included in mainline as of 2.6.18 (even when ATA_ENABLE_PATA is
> set), or if there may be a bug.

libata PATA support basically doesn't exist in 2.6.18.  It's queued for 
2.6.19 in torvalds/linux-2.6.git however.

	Jeff


