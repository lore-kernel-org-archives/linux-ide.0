From: Tejun Heo <htejun@gmail.com>
Subject: Re: Frequent SATA errors / port timeouts in 2.6.18.3?
Date: Tue, 19 Dec 2006 16:09:48 +0900
Message-ID: <4587903C.3050204@gmail.com>
References: <4578F5D4.8080205@moniker.net> <4580907D.1020407@ucolick.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:25983 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbWLSHJ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Dec 2006 02:09:56 -0500
Received: by nz-out-0506.google.com with SMTP id s1so686345nze
        for <linux-ide@vger.kernel.org>; Mon, 18 Dec 2006 23:09:55 -0800 (PST)
In-Reply-To: <4580907D.1020407@ucolick.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Patrik Jonsson <patrik@ucolick.org>
Cc: linux-ide@vger.kernel.org

Patrik Jonsson wrote:
> First I thought it was a cabling or card issue, because the same drive
> got kicked twice. That drive was connected to a 2-port SIG sata_sil24
> card. However, I just had another drive kicked that's connected to the
> onboard sata_nv, which leads me to suspect that the upgraded kernel
> might have something to do with it. A quick googling seems to indicate
> that others are seeing this with 2.6.18, too, so I was wondering if
> anyone knows more.

I don't think there has been any change which can affect both sata_sil24
and sata_nv to cause timeouts.  Please post the result of 'smartctl -d
ata -a /dev/sdX' of failed devices.

> The drives contain science data for analysis, so it
> would be a pain (though not a disaster) to lose it. Would it be
> advisable to revert to the previous 2.6.17 that I was running before or
> is this a problem that's fixed in a later kernel than the one I'm
> running now?
> 
> I did at the same time also install an Areca ARC1260 controller and
> connected a bunch of drives to it, so another idea I had was cable
> interference or something (there are now 18 drives in the machine).
> 
> Any ideas or thought would be appreciated,

Power quality degradation can cause transmission failures which can
result in timeouts.  How are your power lines hooked?

-- 
tejun
