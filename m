From: Jan Dittmer <j.dittmer@portrix.net>
Subject: Re: harddisk corruption with 2.5.41bk and tcq enabled
Date: Sat, 12 Oct 2002 20:40:49 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1034448049.3da86cb1bc72a@smartmail.portrix.net>
References: <200210121050.01471.jan@jandittmer.de> <20021012091653.GD26719@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20021012091653.GD26719@suse.de>
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

> 2.5.42 has no changes in this area, so it's probably not safe for you
> either.

Tried it anyway. Nothing better. Seems to happen also with tcq disabled. I've
for now downgraded to 2.4 ... Don't want to reinstall again.
I don't have a serial console available. So I'm sorry but I can't give you any
further clues. X locks up completly after some minutes, on reboot e2fsck gives a
ton of errors (also with ext2 btw). Or can you point me to something I can try
safely?! Perhaps I'll give 2.5.40 a try again tomorrow. That was the latest
revision working iirc. But for now I'm tired and a bit scared ;-)

jan
