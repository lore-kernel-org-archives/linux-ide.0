From: Shane Huang <chunhao.huang@hotmail.com>
Subject: RE: [patch] PCI: disable MSI on more ATI NorthBridges
Date: Sat, 20 Oct 2007 22:50:27 +0800
Message-ID: <BLU120-W12C06900EC932864CC13A8E2980@phx.gbl>
References: <BLU112-W5125F6D8BEB3DF6359D53E29F0@phx.gbl>
 <20071019195749.GK29903@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bay0-omc1-s31.bay0.hotmail.com ([65.54.246.103]:16941 "EHLO
	bay0-omc1-s31.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752586AbXJTOu3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 20 Oct 2007 10:50:29 -0400
In-Reply-To: <20071019195749.GK29903@austin.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linas Vepstas <linas@austin.ibm.com>, davem@davemloft.net, gregkh@suse.de, htejun@gmail.com, brice.goglin@gmail.com, david.gaarenstroom@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, shane.huang@amd.com, jgarzik@pobox.com, linux-ide@vger.kernel.org, chunhao.huang@hotmail.com


Quoting  "David G"
> "Here" as in "here at AMD"?! I'm stunned...
> Both AMD and the former ATI should have quite some experience?!

When I used "here", I was just meaning our youthful linux southbridge
drivers team instead of the whole AMD. Sorry for the confusion to you.


Quoting "Linas"
> As someone else pointed out, AMD should have *lots* of people with
> pci and msi experience on the payroll. (Folks here buy AMD-designed
> pci chips ...)

Yes, absolutely AMD has lots of people with PCI and MSI experience,
but this MSI issue is mainly under the debug of our team now.
I think our team will cooperate with other teams more closely to provide
linux chipset support besides fixing the MSI problem in the future.


Quoting "Jeff"
> Take a look at tg3.c net driver change
> 2fbe43f6f631dd7ce19fb1499d6164a5bdb34568 which is a similar
> situation. However, it may turn out that removing the pci_intx()
> stuff as a general rule is easier than quirking these devices, if enough
> of them turn out to have this hardware bug. The tg3.c change should
> illustrate how to fix immediately, though.

Thanks for your suggestion. I will continue to debug this problem next
Monday when I'm back to the office. 


Thanks
Best Regards

Shane

_________________________________________________________________
Invite your mail contacts to join your friends list with Windows Live Spaces. It's easy!
http://spaces.live.com/spacesapi.aspx?wx_action=create&wx_url=/friends.aspx&mkt=en-us
