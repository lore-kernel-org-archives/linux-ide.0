From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] Fix PDC202XX_FORCE kconfig selection
Date: Sat, 14 Jan 2006 16:13:03 +0000
Message-ID: <1137255183.20915.0.camel@localhost.localdomain>
References: <20060114152119.GN29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:17083 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751199AbWANQLh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jan 2006 11:11:37 -0500
In-Reply-To: <20060114152119.GN29663@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>

On Sad, 2006-01-14 at 16:21 +0100, Adrian Bunk wrote:
> Split PDC202XX_FORCE selection into two independ option and allow user
> select it only for specific driver.

Seems pointless. We should always grab the raid cards. The option itself
is a mistake

Alan

