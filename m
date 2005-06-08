From: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [PATCH] SATA NCQ #4
Date: Wed, 08 Jun 2005 21:36:24 +1000
Message-ID: <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com>
References: <20050608102857.GC18490@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:21485 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S262177AbVFHLgh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Jun 2005 07:36:37 -0400
In-Reply-To: <20050608102857.GC18490@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com

Hi Jens,
On Wed, 8 Jun 2005 12:28:59 +0200, Jens Axboe <axboe@suse.de> wrote:
>
>This should be pretty final, at least only minor stuff left. Changes:

Fell over here, on http://scatter.mine.nu/test/boxen/sempro/

No logged info, just scrolling heaps junk on screen --> libata 
I could see and I think 8 digit hex in [] on left.  

Hit RESET to reboot, no apparent filesystem damage :)  Sorry so 
little info.  patched 2.6.12-rc6 cleanly  seemed to go stupid 
during mount reiserfs partitions, about that stage of boot.

Being a sucker for punishment, I recompiled with 8KB stacks, highmem 
off (box has 1GB mem) and it go stupid when touch HDD, but USB started 
okay while it stupid, saw USB messages and mouse lit up.

Hit RESET to reboot...  Again, box safely back in 2.6.11.11 land :)

--Grant.

