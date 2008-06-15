From: Frans Pop <elendil@planet.nl>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Sun, 15 Jun 2008 11:41:50 +0200
Message-ID: <200806151141.52326.elendil@planet.nl>
References: <20080512132611.GA15410@deprecation.cyrius.com> <4852A6D0.8030607@rtr.ca> <48547BD9.8050306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpo-eml03.kpnxchange.com ([213.75.38.152]:7472 "EHLO
	cpsmtpo-eml03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756727AbYFOJlz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Jun 2008 05:41:55 -0400
In-Reply-To: <48547BD9.8050306@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Byron Bradley <byron.bbradley@gmail.com>

On Sunday 15 June 2008, Tejun Heo wrote:
> The interesting thing here is that sata_mv can see the disk going off
> the power, which is kind of cool.  The controller and CPU are watching
> itself as it goes off the life support and is drifting awaaaaaayyyy.
>
> The PSU has switched off and power to the drive was cut.  I don't think
> anything can go wrong at that point.

What I still find most interesting is that with 2.6.25 the extra 
message(s) do not appear and the poweroff is "clean". And that it affects 
2 different systems where one seems to live on just a bit longer than the 
other. So it does look as if something _has_ changed.

I'll probably do a bisect to see if I can discover what/where/why...

Cheers,
FJP
