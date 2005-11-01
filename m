From: Jens Axboe <axboe@suse.de>
Subject: Re: [UPDATED][PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Tue, 1 Nov 2005 20:27:31 +0100
Message-ID: <20051101192730.GJ26049@suse.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF2C@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:64586 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751177AbVKAT0d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2005 14:26:33 -0500
Content-Disposition: inline
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF2C@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

On Tue, Nov 01 2005, Timothy Thelin wrote:
> Changes:
> Increases the taskfile data transfer limit from 128K to a
> theoretical 2-4MB (arch dependant) by using __get_free_pages
> instead of kmalloc.  Note that larger requests have a lower
> success rate because of needing to find a larger amount of
> free consecutive memory.

I don't think this is a good way to do it. IDE already supports sg for
regular fs requests, the correct solution would be to make sure the user
driven taskfile submission is sg based as well. That would enable large
transfers without risking allocation failures. An interface that doesn't
work for anything but a freshly booted kernel is pretty worthless, imho.
User interfaces must work predictably.

-- 
Jens Axboe

