From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 2.6.22-rc6] ATA: add a PCI ID for Intel Santa Rosa PATA
 controller
Date: Fri, 06 Jul 2007 16:43:51 -0400
Message-ID: <468EA987.80001@garzik.org>
References: <39B20DF628532344BC7A2692CB6AEE070181E0EA@orsmsx420.amr.corp.intel.com> <200707062145.01928.chunkeey@web.de> <468E9F9C.9010508@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59058 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764155AbXGFUn4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 6 Jul 2007 16:43:56 -0400
In-Reply-To: <468E9F9C.9010508@leemhuis.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thorsten Leemhuis <fedora@leemhuis.info>
Cc: Chr <chunkeey@web.de>, "Gaston, Jason D" <jason.d.gaston@intel.com>, Chuck Ebbert <cebbert@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org

Thorsten Leemhuis wrote:
> But anyway: Sorry, am I the only one that gets nervous if we start to
> run a ATA-Hardware (Intels recent ICH southbridges in this case) with a
> speed grade (Ultra ATA/133) that is not specified by its manufacturer in
> his public data sheets (Ultra ATA/100 max)?

That's why the patch I applied referenced ATA/100...

If they fix the datasheets, we can always upgrade it later.

	Jeff


