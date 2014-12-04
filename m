From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Whitelist SSDs that are known to properly return
 zeroes after TRIM
Date: Thu, 4 Dec 2014 12:06:11 -0500
Message-ID: <20141204170611.GB2995@htj.dyndns.org>
References: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:51699 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbaLDRGV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 4 Dec 2014 12:06:21 -0500
Received: by mail-qa0-f43.google.com with SMTP id bm13so12112124qab.16
        for <linux-ide@vger.kernel.org>; Thu, 04 Dec 2014 09:06:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <yq18uiojfq9.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org

Hello, Martin.

On Wed, Dec 03, 2014 at 09:44:46PM -0500, Martin K. Petersen wrote:
> 
> As defined, the DRAT (Deterministic Read After Trim) and RZAT (Return
> Zero After Trim) flags in the ATA Command Set are unreliable in the
> sense that they only define what happens if the device successfully
> executed the DSM TRIM command. TRIM is only advisory, however, and the
> device is free to silently ignore all or parts of the request.
> 
> In practice this renders the DRAT and RZAT flags completely useless and
> because the results are unpredictable we decided to disable discard in
> MD for 3.18 to avoid the risk of data corruption.
> 
> Hardware vendors in the real world obviously need better guarantees than
> what the standards bodies provide. Unfortuntely those guarantees are
> encoded in product requirements documents rather than somewhere we can
> key off of them programatically. So we are compelled to disabling
> discard_zeroes_data for all devices unless we explicitly have data to
> support whitelisting them.
> 
> This patch whitelists SSDs from a few of the main vendors. None of the
> whitelists are based on written guarantees. They are purely based on
> empirical evidence collected from internal and external users that have
> tested or qualified these drives in RAID deployments.
> 
> The whitelist is only meant as a starting point and is by no means
> comprehensive:
> 
>    - All intel SSD models except for 510
>    - Micron M5*
>    - Samsung SSDs
>    - Seagate SSDs

Generally, I'm extremely skeptical about whitelists.  It's very
difficult to keep them meaningfully up-to-date and often just ends up
bit rotting after the initial flurry of updates, especially given how
little this particular feature would be visible to most users.

If there's something on the horizon which would solve the
identification problem and we only have to worry about the current
batch of devices, whitelisting can be useful but otherwise I'm not
sure this is a good idea.

If there currently is no way of properly indicating this feature,
let's please disable it unconditionally.  If this is absolutely
necesary in certain cases (is it?), we can add libata.force flags or
sysfs knobs to force enable it for users who care enough about it and
knows what they're doing.

Thanks.

-- 
tejun
