From: Borislav Petkov <bp@alien8.de>
Subject: Re: PROBLEM: udevd appears to loop and use CPU in 2.6.39-git11
 (32bit build)
Date: Wed, 1 Jun 2011 09:29:57 +0200
Message-ID: <20110601072957.GC3368@liondog.tnic>
References: <844A621A-66E5-42F1-8B15-C6C700A40A53@daviesinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:54944 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755153Ab1FAHaB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 1 Jun 2011 03:30:01 -0400
Content-Disposition: inline
In-Reply-To: <844A621A-66E5-42F1-8B15-C6C700A40A53@daviesinc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chris Davies <mcd@daviesinc.com>
Cc: linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, joshuacov@googlemail.com

On Wed, Jun 01, 2011 at 01:31:47AM -0400, Chris Davies wrote:
> [1.] One line summary of the problem:    2.6.39-git11 experiences loop on /dev creation and later udevd loops using CPU
> [2.] Full description of the problem/report:

Great, udev looping rings the big bell here:

There's a user running 2.6.39 fedora kernels and reports the same
issue of udev looping but only when loading a module which fails
loading with -EINVAL. Reportedly, udev keeps trying indefinitely there:
https://bugzilla.kernel.org/show_bug.cgi?id=35522

Anyway, just a datapoint, it could be unrelated.

Thanks.


-- 
Regards/Gruss,
    Boris.
