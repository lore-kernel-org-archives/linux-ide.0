From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiI SATA kernel driver
Date: Mon, 12 Jul 2004 06:59:47 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40F26F23.5040200@pobox.com>
References: <3254.1089628481@www2.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30124 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266758AbUGLLAE
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 07:00:04 -0400
In-Reply-To: <3254.1089628481@www2.gmx.net>
List-Id: linux-ide@vger.kernel.org
To: Markus Nicolussi <mcwimpy@gmx.at>
Cc: linux-ide@vger.kernel.org

Markus Nicolussi wrote:
> please can u help me with this problem:
> 
> can u tell me if the driver supports the SiI3112 Chip in _RAID_mode_? Or ist
> there a website which is constantly updated where i can look to from time to
> time and which tells me that?


The chip does not have a RAID mode.

You need a software RAID driver.

	Jeff



