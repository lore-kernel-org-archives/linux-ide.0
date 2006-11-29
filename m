From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ide_scsi: allow it to be used for non CD only
Date: Wed, 29 Nov 2006 22:35:18 +0000
Message-ID: <20061129223518.19f6ef95@localhost.localdomain>
References: <20061129144652.299f7919@localhost.localdomain>
	<58cb370e0611291405j1e5f3eb1t4950ed0993b84c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26281 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1758881AbWK2W2d (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Nov 2006 17:28:33 -0500
In-Reply-To: <58cb370e0611291405j1e5f3eb1t4950ed0993b84c85@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org

On Wed, 29 Nov 2006 23:05:56 +0100
"Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:

> Hi,
> 
> Nowadays, you can dynamically change driver bound to a device using
> sysfs and it works just fine for IDE, ie:

This isn't the point of this change. The point is to do this at discovery
time. If you do it later then many horrible things happen as the device
names and renames itself while udev goes boom.


Its a small clean patch and it'll solve the problem nicely until
drivers/ide dies.
