From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Add an additional LPM policy to match Intel
 recommendations
Date: Mon, 13 Apr 2015 10:32:25 -0400
Message-ID: <20150413143225.GB2596@htj.duckdns.org>
References: <1428696929-2988-1-git-send-email-mjg59@coreos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35629 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbbDMOc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Apr 2015 10:32:28 -0400
Content-Disposition: inline
In-Reply-To: <1428696929-2988-1-git-send-email-mjg59@coreos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@coreos.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Apr 10, 2015 at 01:15:29PM -0700, Matthew Garrett wrote:
> Intel publish a document on designing energy efficient SATA devices at
> http://www.intel.com/content/dam/doc/reference-guide/sata-devices-implementation-recommendations.pdf
> which recommends that ALPE be set, ASPE be cleared and that DIPM be enabled
> on the device. Right now we have no policy that matches that - medium_power
> does not enable DIPM and min_power sets ASPE. Add a new low_power policy to
> implement these recommendations. I've left devslp disabled because I'm not
> yet sure what Intel do in that case. With luck this will provide reasonable
> power savings without causing the device breakages we occasionally see with
> the min_power policy.

I suspect the aggressive methods actually don't buy us much, except
for the obsessive mode switchings, in terms of power saving compared
to something more reasonable provided via DIPM and I'm not sure it's a
good idea to introduce yet another mode.  I'd be all in for converting
min_power mode to DIPM for cases where we know this actually works
rather than introducing yet another mode.  Or if there's a clear power
consumption disadvantage to DIPM, let's conver medium_power to that.

Thanks.

-- 
tejun
