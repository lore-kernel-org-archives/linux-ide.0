From: Jan Dittmer <j.dittmer@portrix.net>
Subject: Re: harddisk corruption with 2.5.41bk and tcq enabled
Date: Sat, 12 Oct 2002 13:37:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1034422647.3da8097797dd3@smartmail.portrix.net>
References: <200210121050.01471.jan@jandittmer.de> <20021012091653.GD26719@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021012091653.GD26719@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

> > attempt to access beyond end of device
> > ide0(3,2): rw=0, want=1076371720, limit=19535040
>
At least not ide related. Just ext3 moaning.
I'm just reinstalling debian, e2fsck just killed most of my filesystem :-(
(including old dmesg/config).
I'll give 2.4.42 a try on a fresh install with ext_2_. But I think there
were no changes with respect to ext3 lately?!

jan

> Any messages _before_ these??
> 
> -- 
> Jens Axboe
> 


--
portrix.net GmbH
j.dittmer@portrix.net
