From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: ahci sometimes fails to suspend controller
Date: Tue, 28 Jul 2009 13:04:53 +0800
Message-ID: <C8E4BD7D001E44499280E0884BD9DB30D7D051@sshaexmb1.amd.com>
References: <20090719220423.54e8c75d@uranus><4A683755.60909@kernel.org><20090727140612.27d176ca@pluto-lenny.milky.way><4A6E6774.6030909@kernel.org><C8E4BD7D001E44499280E0884BD9DB30D7CFD4@sshaexmb1.amd.com> <20090728061033.56394c6e@pluto-lenny.milky.way>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.15]:58038
	"EHLO VA3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751104AbZG1FFN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Jul 2009 01:05:13 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20090728061033.56394c6e@pluto-lenny.milky.way>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Benjamin S." <sbenni@gmx.de>
Cc: Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Huang, Shane" <Shane.Huang@amd.com>

Hi Benjamin,


> -----Original Message-----
> From: Benjamin S. [mailto:sbenni@gmx.de] 
> 
> On Tue, 28 Jul 2009 11:06:01 +0800
> "Huang, Shane" <Shane.Huang@amd.com> wrote:
> 
> > Can you send me the whole output of lspci?
> 
> Sure.


OK, I see. Your revision do need the SATA MSI quirk.



Thanks
Shane

