From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 25/64] ide: use standard timing for XFER_PIO_SLOW mode
 in ide_timing_compute()
Date: Tue, 19 Jan 2010 11:48:16 -0800 (PST)
Message-ID: <20100119.114816.78180589.davem@davemloft.net>
References: <20100119.012526.203639880.davem@davemloft.net>
	<201001191609.42582.bzolnier@gmail.com>
	<4B560B41.6080205@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:34692
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932105Ab0ASTsG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 14:48:06 -0500
In-Reply-To: <4B560B41.6080205@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sshtylyov@ru.mvista.com
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Tue, 19 Jan 2010 22:42:57 +0300

>   But shouldn't this just be merged to "ide: use standard timing for
>   XFER_PIO_SLOW mode in ide_timing_compute()" since it's the patch that
>   introduced that check?

It's fine either way.

I can break the ide-next-2.6 tree for everyone by rebasing it to
unwind the 50 or so patches I applied from Bart yesterday to do this,
but really is that pain worth it since right thing is there in the
end?
