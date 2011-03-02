From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH #upstream-fixes] libata: fix hotplug for drivers which
 don't implement LPM
Date: Wed, 02 Mar 2011 02:45:17 -0500
Message-ID: <4D6DF58D.5030905@pobox.com>
References: <20110224183037.GS7840@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57109 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264Ab1CBHpX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2011 02:45:23 -0500
In-Reply-To: <20110224183037.GS7840@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, stable <stable@kernel.org>

On 02/24/2011 01:30 PM, Tejun Heo wrote:
> ata_eh_analyze_serror() suppresses hotplug notifications if LPM is
> being used because LPM generates spurious hotplug events.  It compared
> whether link->lpm_policy was different from ATA_LPM_MAX_POWER to
> determine whether LPM is enabled; however, this is incorrect as for
> drivers which don't implement LPM, lpm_policy is always
> ATA_LPM_UNKNOWN.  This disabled hotplug detection for all drivers
> which don't implement LPM.
>
> Fix it by comparing whether lpm_policy is greater than
> ATA_LPM_MAX_POWER.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: stable@kernel.org

applied, though putting this into 2.6.38.1 is preferred to changing this 
at -rc7...  stable@ cc'd.

