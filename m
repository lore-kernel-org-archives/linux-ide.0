From: John Fremlin <not@just.any.name>
Subject: AHCI aggressive powersaving
Date: Tue, 12 Jun 2007 00:52:46 +0000
Message-ID: <878xaqm1sx.fsf-genuine-vii@john.fremlin.org>
References: <873b0yvk14.fsf-genuine-vii@john.fremlin.org>
	<466D56B2.5080109@linux.intel.com>
	<20070611124422.769cba7d.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:64525 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866AbXFLAxJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 20:53:09 -0400
In-Reply-To: <20070611124422.769cba7d.kristen.c.accardi@intel.com> (Kristen Carlson Accardi's message of "Mon\, 11 Jun 2007 12\:44\:22 -0700")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-ide@vger.kernel.org, power@bughost.org

Kristen Carlson Accardi <kristen.c.accardi@intel.com> writes:
[...]
> I've updated the hardware based patches and posted to the mailing list - 
> they do indeed save anywhere from .6-1.5 watts depending on the system,
> on my X60 they save about a watt.  I don't think that a hardware based
> solution is irrelevant at all - it will usually be able to make faster
> and more accurrate decisions about when to place the link into lower
> power state than software could.

Fair enough. But could I point out that the patch I posted from Tejun
Heo actually does "stop" the port, not just putting it into low power
slumber modes.

So, I think it might be able to save more power.

Please take a look at it. It is quite sophisticated and could be
generalised to more chipsets. Perhaps, on AHCI it can be used in
combination with the aggressive link power management.

> Note that the previous implementation that was posted didn't work for me,
> so I just redid everything.

Was that my implementation? 

I posted it in November last year. It certainly isn't as good as yours

http://marc.info/?l=linux-kernel&m=116343039621877&w=2

As you can see, I too thought it saved about 1 W, but Pavel Machek
measured 250mW.

 
