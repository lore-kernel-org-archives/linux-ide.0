From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes] ata_piix: verify SIDPR access before
 enabling it
Date: Tue, 06 May 2008 10:17:40 -0400
Message-ID: <48206884.6020205@garzik.org>
References: <481916CC.3070504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:39348 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbYEFORm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 May 2008 10:17:42 -0400
In-Reply-To: <481916CC.3070504@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, ryan.roth@ch2m.com

Tejun Heo wrote:
> On certain configurations (certain macbooks), even though all the
> conditions for SIDPR access described in the datasheet are met,
> actually reading those registers just returns 0 and have no effect on
> write.  Verify SIDPR is actually working before enabling it.
> 
> This is reported by Ryan Roth in bz#10512.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Ryan Roth <ryan.roth@ch2m.com>
> ---
> Apple did another weird thing with ich8m in addition to the weird
> lockup on second port enable and SIDPR causes drive misdetection.
> This one probably should go to -stable too.
> 
> Thanks.
> 
> drivers/ata/ata_piix.c |   25 +++++++++++++++++++++++++
> 1 file changed, 25 insertions(+)

applied


