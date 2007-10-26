From: "Shane Huang" <Shane.Huang@amd.com>
Subject: Questions about SATA hotplug in linux 2.6
Date: Fri, 26 Oct 2007 10:27:20 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A50705622EAB@sshaexmb1.amd.com>
References: <20071025.011445.80152909.davem@davemloft.net>
 <472052C1.2050302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-dub.bigfish.com ([213.199.154.10]:9434 "EHLO
	mail133-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXJZC2P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Oct 2007 22:28:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <472052C1.2050302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
Cc: Shane Huang <Shane.Huang@amd.com>

Greetings:

I have some questions about SATA HDD/ODD hotplug support in linux.
1. If users unplug one SATA HDD(no-root partition) or SATA ODD when
the system is running, then plug it back to the same SATA port,
Should the system and SATA HDD/ODD still work well?

2. How about users plug the SATA HDD/ODD in a different SATA port?
Should it still work?

These questions come up when our QA test our SB700 SATA drivers,
but I don't know the SATA hotplug support in linux 2.6.
Is there any guy who can give some official confirmation? :-)


Thanks
Best Regards

Shane



