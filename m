From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv 0000:03:06.0: PCI ERROR; PCI IRQ cause=0x30000040
Date: Tue, 06 Oct 2009 16:06:20 -0400
Message-ID: <4ACBA33C.7090606@rtr.ca>
References: <1254546642.1438.135.camel@giskard> <4ACA6904.1060509@rtr.ca>	 <4ACB3741.2030101@gmail.com> <1254852272.1471.172.camel@giskard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:58046 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382AbZJFUG7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 16:06:59 -0400
In-Reply-To: <1254852272.1471.172.camel@giskard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bernie Innocenti <bernie@codewiz.org>
Cc: Harri Olin <harri.olin@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, sysadmin <sysadmin@gnu.org>

If you could also send me the output of "lspci -vv" for the cards
then I can also have a quick look at chipset errata for possibilities.

The early revs of these chips did have a number of errata specific to PCI-X.

Cheers
