From: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: [RFC] IDE/ATA/SATA controller hotplug
Date: Tue, 27 Jul 2004 15:14:31 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <4106C5B7.9040606@clanhk.org>
References: <200407191947.i6JJldK1024910@falcon10.austin.ibm.com> <41067543.3090003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.hardcore-gaming.net ([69.93.101.157]:5015 "EHLO
	mail.hardcore-gaming.net") by vger.kernel.org with ESMTP
	id S266613AbUG0UOf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Jul 2004 16:14:35 -0400
In-Reply-To: <41067543.3090003@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug Maxey <dwm@austin.ibm.com>, Linux IDE Mailing List <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:

> Why do you think libata is not already hotplug capable, WRT controllers?

I'm not sure what WRT means, but your last Linux SATA Update did contain:

"Hotplug support
---------------
All SATA is hotplug.

libata does not support hotplug... yet.

The following SATA controllers will never support hotplug:
Intel ICH5, Intel ICH5-R, Intel ICH6 (non-AHCI), Pacific Digital Talon,
Promise SATA SX4."

-ryan



