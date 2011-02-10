From: Tejun Heo <tj@kernel.org>
Subject: Re: libata: implement on-demand HPA unlocking
Date: Thu, 10 Feb 2011 10:44:40 +0100
Message-ID: <20110210094440.GL3770@htj.dyndns.org>
References: <4D51A648.20707@cfl.rr.com>
 <20110209085935.GE6558@htj.dyndns.org>
 <4D52B0B3.40900@cfl.rr.com>
 <20110209153714.558133d7@lxorguk.ukuu.org.uk>
 <20110209153601.GJ3770@htj.dyndns.org>
 <4D52E180.6020908@garzik.org>
 <4D52EEEC.1020602@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51583 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab1BJJop (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Feb 2011 04:44:45 -0500
Received: by fxm20 with SMTP id 20so1251658fxm.19
        for <linux-ide@vger.kernel.org>; Thu, 10 Feb 2011 01:44:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D52EEEC.1020602@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Ben Hutchings <ben@decadent.org.uk>, Jeff Garzik <jgarzik@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

On Wed, Feb 09, 2011 at 02:45:48PM -0500, Phillip Susi wrote:
> Then why did you have libata default to NOT unlocking it, which seems to
> be the correct thing to do?  When Ubuntu switched to libata they patched
> it to default to unlocking the HPA because the old ide driver did.  This
> seems wrong and causes breakage.  Tejun's patch seems to be a good
> compromise between the two choices: unlock if you think it will help,
> otherwise, don't, since it might hurt.

I don't think that patch supports your argument to begin with but even
if it did don't get too hung up on the fact that I (or anyone else)
did something contrary in the past.  I've done a lot of stupid and
horrible things and changed mind more times than anyone should care
about.

I thought it would be a good and safe compromise for distros which
don't want to unlock by default but look at where we are.  We just
ended up with failures which are more obscure.  Your proposed addition
will only push things further that direction.  It might not
necessarily be a bad thing.  Maybe the level of obscurity then goes
beyond certain level and we wouldn't have to care about that.

But much better solution seems to be exporting the bios size to others
and letting the ones which understand storage configuration better
deal with it.  At the block or libata layer, we simply don't have
enough information to make those decisions in a reliable manner.

Thanks.

-- 
tejun
