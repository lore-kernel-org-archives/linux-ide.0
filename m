From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] always enable CONFIG_PDC202XX_FORCE
Date: Sun, 15 Jan 2006 01:07:29 +0000
Message-ID: <1137287249.26046.13.camel@localhost.localdomain>
References: <20060114152119.GN29663@stusta.de>
	 <1137255183.20915.0.camel@localhost.localdomain>
	 <58cb370e0601140947medcb66flf6b7281976683765@mail.gmail.com>
	 <20060114195521.GS29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13802 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751603AbWAOBFu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 14 Jan 2006 20:05:50 -0500
In-Reply-To: <20060114195521.GS29663@stusta.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Andrey J. Melnikoff" <temnota@kmv.ru>

On Sad, 2006-01-14 at 20:55 +0100, Adrian Bunk wrote:
> This patch removes the CONFIG_PDC202XX_FORCE=n case.

NAK. The Y case is the one you want to keep


