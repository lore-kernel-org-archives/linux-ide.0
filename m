From: idurdanovic@comcast.net (Igor Durdanovic)
Subject: [PATCH] libata: fix revalidation issuing after configuration commands
Date: Wed, 10 Oct 2007 22:55:09 -0400
Message-ID: <18189.37005.959133.650409@kitty1.shrimp.net>
References: <20071010065744.GO12186@htj.dyndns.org>
Reply-To: idurdanovic@comcast.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([206.18.177.51]:55001 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973AbXJKCzv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 10 Oct 2007 22:55:51 -0400
In-Reply-To: <20071010065744.GO12186@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, idurdanovic@comcast.net

Hi,

The patch works fine! Reset happens only once per disk and works also
when disks are missing, which would result in infinite loop before.
Setting the parameters of a hard-drive works too.

The only thing that is puzzling to me is that I am unable to send more
than 80MB/s through one Express-Card sata port. I am not sure what the
problem is, the bus ought to sustain 300MB/s without the problem, is
this PM limitation (does not seem so from the PR material), or the
sata card? This makes it impossible to create high-speed RAID.

Regards, Igor

Tejun Heo writes:
> After commands which can change device configuration, EH is scheduled
> to revalidate and reconfigure the device.  Host link was incorrectly
> used unconditionally when scheduling EH action.  This resulted in
> bogus revalidation request and mismatched configuration between device
> and driver.  Fix it.
