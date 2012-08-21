From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide: fix generic_ide_suspend/resume Oops
Date: Tue, 21 Aug 2012 14:54:52 -0700 (PDT)
Message-ID: <20120821.145452.1762302256533324265.davem@davemloft.net>
References: <87txvwgtkx.fsf@tucsk.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87txvwgtkx.fsf@tucsk.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: miklos@szeredi.hu
Cc: rjw@sisk.pl, stern@rowland.harvard.edu, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Aug 2012 17:20:30 +0200

> From: Miklos Szeredi <mszeredi@suse.cz>
> 
> This patch fixes a regresion introduced by commit 0998d063 (device-core: Ensure
> drvdata = NULL when no driver is bound).
> 
> Suspend oopses in generic_ide_suspend() because dev_get_drvdata()
> returns NULL (dev->p->driver_data == NULL) and this function is not
> prepared for this.
> 
> Fix is based on Alan Stern's suggestion.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied, thanks.
