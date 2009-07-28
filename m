From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: ahci sometimes fails to suspend controller
Date: Tue, 28 Jul 2009 11:06:01 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com>
References: <20090719220423.54e8c75d@uranus>	<4A683755.60909@kernel.org> <20090727140612.27d176ca@pluto-lenny.milky.way> <4A6E6774.6030909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:7888 "EHLO
	VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751179AbZG1DGX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Jul 2009 23:06:23 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <4A6E6774.6030909@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, "Benjamin S." <sbenni@gmx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Benjamin,

Can you send me the whole output of lspci?


Hi Tejun, 

> -----Original Message-----
> From: Tejun Heo [mailto:tj@kernel.org] 
> 
> Shane, this is the msi pci quirk not being applied during resume,
> right?  IIRC, the patch has been posted upstream (did I do that or did
> you?).  Maybe it would be nice to send the patch to -stable?
> 
> Oh.. the original thread is..
> 
> http://thread.gmane.org/gmane.linux.ide/41926


http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commi
t;h=4600c9d74e23b5696acf66a36ce5f2cfbcdecc6c

Yes, the msi pci quick should also be added to resume.
Can you added it for us?


Thanks
Shane

