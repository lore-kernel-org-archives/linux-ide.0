From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Recommended SATA controller?
Date: Sun, 07 Mar 2004 22:27:53 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <404B93D9.5090402@stesmi.com>
References: <opr4idafayq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:42436 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262324AbUCGV14
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 7 Mar 2004 16:27:56 -0500
In-Reply-To: <opr4idafayq1sf88@mail.broadpark.no>
List-Id: linux-ide@vger.kernel.org
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: linux-ide@vger.kernel.org

Arve Knudsen wrote:

> Hi
> 
> As it seems the Silicon Image driver won't be radically improved anytime 
> soon(?), I'm thinking of purchasing a dedicated SATA controller. Can 
> anyone recommend me a fairly cheap 2-port controller that's known to 
> work well with Linux (2.6-series)? Stability is imperative, I just had a 
> solid freeze and I'm afraid it might have to do with disk activity 
> (playing MP3s while compiling). Might Promise (Ultra 150) or Adaptect 
> (1210 SA) be worth considering?

I sent a list the other day about my harddrives dieing on me and after
following up my search I came across that there is some kind of either
driver or hardware error on the VIA 8237 controller's SATA part, but
ONLY if you run it in "DISK" mode. It works fine in "RAID" mode.

I can't give you specifics on what works or doesn't as I've only tried
2.4 so far but the promise one seems to work fine for me in 2.4 right
now.

So stay away from the 8237 in case you decide to get a motherboard with
SATA on instead (not much more expensive really than getting a seperate
SATA PCI card.

// Stefan
