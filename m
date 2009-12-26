From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delays while hibernating
Date: Sat, 26 Dec 2009 10:26:55 +0900
Message-ID: <4B35665F.20001@kernel.org>
References: <74fd948d0912221950m1ade8475pfe3ec3018e14d834@mail.gmail.com>	 <4B31CAF9.8070104@kernel.org>	 <74fd948d0912230550i639f7c05m9a6e5c9996479c01@mail.gmail.com>	 <4B331C16.4080901@kernel.org>	 <74fd948d0912240634h621de8b6l746470556da3eb7f@mail.gmail.com>	 <74fd948d0912240759n72e8c141y6b75f1ee7caadf60@mail.gmail.com>	 <4B34D2AC.8040908@kernel.org> <74fd948d0912251010y2bba5bd6nf7aa3a34a7946c31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46204 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756786AbZLZBZU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Dec 2009 20:25:20 -0500
In-Reply-To: <74fd948d0912251010y2bba5bd6nf7aa3a34a7946c31@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pedro Ribeiro <pedrib@gmail.com>
Cc: linux-ide@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

(cc'ing Rafael)

On 12/26/2009 03:10 AM, Pedro Ribeiro wrote:
>> Oh... Can you please try this one then?
> 
> Sorry, still hangs with this patch :(
> 
> This only happens in hibernation... suspend is fine.

Hmmm... the patch does apply to both suspend and hibernation.  Rafael,
Pedro's ThinkPad T400 burns cpu cycle for 30secs on "Atomic
copy/restore" step of hibernation if the ultrabay is powered off.  The
original report can be found at...

  http://thread.gmane.org/gmane.linux.ide/44190

Please note that it's with TuxOnIce patches.  Anyways, ata_piix on
certain configurations have similar issues where after the OS is done
suspending and powering off the piix controller, the BIOS tries to
access it and ends up burning cpu cycles which can be worked around by
leaving the controller on after suspend.  Applying the same workaround
didn't resolve the issue.  Do you know what can make cpu burn for
30secs on the atomic copy/restore step?

Pedro, can you please try to reproduce the problem without TuxOnIce
patches?

Thanks.

-- 
tejun
