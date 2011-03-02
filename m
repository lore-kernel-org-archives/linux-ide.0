From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libata: fix hotplug for drivers which
 don't implement LPM
Date: Wed, 2 Mar 2011 08:47:21 +0100
Message-ID: <20110302074721.GF19669@htj.dyndns.org>
References: <20110224183037.GS7840@htj.dyndns.org>
 <4D6DF58D.5030905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60697 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab1CBHr0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 02:47:26 -0500
Content-Disposition: inline
In-Reply-To: <4D6DF58D.5030905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, stable <stable@kernel.org>

On Wed, Mar 02, 2011 at 02:45:17AM -0500, Jeff Garzik wrote:
> On 02/24/2011 01:30 PM, Tejun Heo wrote:
> >ata_eh_analyze_serror() suppresses hotplug notifications if LPM is
> >being used because LPM generates spurious hotplug events.  It compared
> >whether link->lpm_policy was different from ATA_LPM_MAX_POWER to
> >determine whether LPM is enabled; however, this is incorrect as for
> >drivers which don't implement LPM, lpm_policy is always
> >ATA_LPM_UNKNOWN.  This disabled hotplug detection for all drivers
> >which don't implement LPM.
> >
> >Fix it by comparing whether lpm_policy is greater than
> >ATA_LPM_MAX_POWER.
> >
> >Signed-off-by: Tejun Heo<tj@kernel.org>
> >Cc: stable@kernel.org
> 
> applied, though putting this into 2.6.38.1 is preferred to changing
> this at -rc7...  stable@ cc'd.

Understood.  As long as it ends up in stable@, either way is okay with
me.  Thank you.

-- 
tejun
