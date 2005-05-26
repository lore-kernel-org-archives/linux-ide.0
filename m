From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Playing with SATA NCQ
Date: Thu, 26 May 2005 13:15:34 -0400
Message-ID: <42960436.4070106@pobox.com>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de> <20050526171132.GV1419@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:54234 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261652AbVEZRPh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2005 13:15:37 -0400
In-Reply-To: <20050526171132.GV1419@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Re-reading AHCI spec, it does indicate that you want to set SActive
> after building the command. I'll move it back, but keep the conditional
> of setting SActive on queued commands.

SActive is intentionally used for non-NCQ devices.  The SATA registers 
are -host- registers not -device- registers, remember.

At the very least, I would like to see a lot of testing before you make 
the current unconditional code conditional.

	Jeff


