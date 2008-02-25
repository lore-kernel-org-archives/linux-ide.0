From: Jeff Garzik <jeff@garzik.org>
Subject: Re: new regression in 2.6.25-rc3: can't resume from suspend to ram,
 ata1 errors
Date: Mon, 25 Feb 2008 16:04:08 -0500
Message-ID: <47C32D48.7060909@garzik.org>
References: <8f53421d0802251257o75d2975dldcfb99a2dc5e3539@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55949 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbYBYVEO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Feb 2008 16:04:14 -0500
In-Reply-To: <8f53421d0802251257o75d2975dldcfb99a2dc5e3539@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-ide@vger.kernel.org

Michael S. Tsirkin wrote:
> git bisect points at this commit:
> commit 559bbe6cbd0d8c68d40076a5f7dc98e3bf5864b2.
> power_state: get rid of write-only variable in SATA


Hello Pavel --

It looks like this not a write-only variable after all...

	Jeff


