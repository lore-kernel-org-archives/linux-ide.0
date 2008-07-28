From: Tejun Heo <teheo@suse.de>
Subject: Re: Seagate HDD Frequent Head Unload - hdparm/dmidecode/smartctl
 output
Date: Mon, 28 Jul 2008 18:18:09 +0900
Message-ID: <488D8ED1.2040400@suse.de>
References: <488B27CE.5060106@i-nz.net> <488D751C.5080302@suse.de> <488D8B97.1040805@i-nz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:34470 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYG1JSf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 05:18:35 -0400
In-Reply-To: <488D8B97.1040805@i-nz.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Ivan N. Zlatev" <contact@i-nz.net>
Cc: linux-ide@vger.kernel.org

Ivan N. Zlatev wrote:
> I tested and it seems that the right value for my configuration is 254
> instead of 255. With 255 I still get spin downs.

Ah... okay, so it should be 254.

> BTW I noticed that on http://en.opensuse.org/Disk_Power_Management the
> script sets a combination of APM and spin-down time, e.g:
> 
>    [1] hdparm -q -B 200 -q -S 252 /dev/sda
> 
> With that I also don't get spin downs. So compared to:
> 
>    [2] hdparm  -B 254 /dev/sda
> 
> will [1] or [2] be better for the HDD in terms of power consumption and
> overheating? Would *not* disabling the APM for the HDD (is what 254/255
> do?), but setting the spin down timeout to something more sensible be
> better for the HDD? I have no idea if spinning down the head is the only
> thing HDDs do for power saving. I suppose you would know best?

I have no idea at all.  The semantics for APM settings isn't strictly
defined so only the vendor knows what each range of values actually
does.  And devices don't even follow the loose definitions too well -
255 should stop unloading but it doesn't on some devices.

I'll set the value to 254 for your system for now.  If you find that 252
 or any other value is better, please lemme know.

> Also on another note I accidentally saw two more potential entries for
> your storage-fixup on the linux-ide list (I do not know if you monitor it):

I monitor the list but have accumulated quite some backlog during past
two weeks.  I'm going through them now.

>    * http://www.spinics.net/lists/linux-ide/msg24667.html
>    * http://www.spinics.net/lists/linux-ide/msg24460.html

Thanks a lot for the pointers & testing.

-- 
tejun
