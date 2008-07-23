From: Jeroen Beerstra <jeroen@scorpion77.cjb.net>
Subject: Re: non functional pata dvd drive under 2.6.25.6
Date: Wed, 23 Jul 2008 22:19:47 +0200
Message-ID: <200807232219.47760.jeroen@scorpion77.cjb.net>
References: <vi85j5-uig.ln1@scorpion77.cjb.net> <4880237A.7070002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dhcp-077-248-068-247.chello.nl ([77.248.68.247]:58881 "EHLO
	scorpion77.cjb.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbYGWVAH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Jul 2008 17:00:07 -0400
In-Reply-To: <4880237A.7070002@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello Tejun,

Op Friday 18 July 2008 07:00:42 schreef u:
> Hello, Jeroen.
>
> [cc'ing linux-ide]
>
> Hmmm... the problem could be caused by hald polling for media presence.
>  Does "hal-disable-polling /dev/srX" make any difference?
> hal-disable-polling setting is persistent so if your drive goes bonkers
> quickly after boot, you can disable polling, reboot and see whether
> anything is different.  Also, please post the result of "lspci -nn" and
> "hdparm -I /dev/srX" && please try 2.6.26.
>
> Thanks.

I'm pretty sure about that since the hald process I'm refering to points to 
the 'faulty' drive. However simply booting with noapic seems to fix all of my 
problems.

See:

Bug 451081 @ bugzilla.redhat.com
Bug 11044 @ bugzilla.kernel.org

regards,

Jeroen Beerstra


