From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH RESEND 0/1] AHCI: Optimize interrupt processing
Date: Thu, 11 Sep 2014 15:36:31 +0200
Message-ID: <4127129.ClfhyhZXo5@amdc1032>
References: <cover.1369155164.git.agordeev@redhat.com>
 <20130521235003.GE6985@mtj.dyndns.org>
 <20140911124248.GA18490@dhcp-27-160.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16233 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbaIKNgh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Sep 2014 09:36:37 -0400
In-reply-to: <20140911124248.GA18490@dhcp-27-160.brq.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org


Hi,

On Thursday, September 11, 2014 02:42:49 PM Alexander Gordeev wrote:

> The numbers are taken by running 'dd if=/dev/sd{a,b} of=/dev/null'
> in parallel. All time values are in us.
> 
> Before this update host lock average holdtime was 2.45 and
> average waittime was 1.24. After the update average holdtime
> dropped to 0.29 (about eight times) while average waittime
> decreased to 0.58 (about two times).
> 
> Also, port events are handled with local interrupts enabled
> and compete on individual per-port locks with average holdtime
> 1.25 and average waittime 1.48. So combined average holdtime
> spent while holding host and port locks decreased from 2.45 to
> 0.29 + 1.25 = 1.54 (about 1.6 times).
> 
> The downside of this change is introduction of a kernel thread.
> 
> The upside is shorter access time to port locks and moving port
> interrupts handling out of the hardware interrupt context.

IMHO it would be great to put the above results into the patch
description (it now looks a bit skimpy).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

