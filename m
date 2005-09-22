From: Mark Lord <liml@rtr.ca>
Subject: Re: SATA suspend-to-ram patch - merge?
Date: Thu, 22 Sep 2005 09:04:28 -0400
Message-ID: <4332ABDC.3030106@rtr.ca>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030305AbVIVNE3@vger.kernel.org>
In-Reply-To: <20050922061849.GJ7929@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
List-Id: linux-ide@vger.kernel.org

>>So currently we are in limbo...
> 
> Which is a shame, since it means that software suspend on sata is
> basically impossible :)

Except that it actually does work, with Jen's patch.

Rather than sitting around for another six months hoping the problem
will go away (it won't), perhaps we should just update/merge Jen's
patch as a sorely needed interim fix.

This might then prod James et al into looking more at the SCSI side of
things, and some year we might see this get replaced with a better scheme.

This is a real problem, and an immediate solution is needed last spring.

Cheers
