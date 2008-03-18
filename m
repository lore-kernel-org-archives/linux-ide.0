From: Nikanth Karthikesan <knikanth@suse.de>
Subject: ide_cd modifies hard_* members of request
Date: Tue, 18 Mar 2008 14:24:46 +0530
Message-ID: <1205830486.7126.16.camel@nikanth-laptop.blr.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:55035 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752304AbYCRJwP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 18 Mar 2008 05:52:15 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Hi

Despite the warning in blkdev.h, that members of struct request starting
with hard_* are block layer internals, and no driver should touch them,
the ide_cd driver seems to fiddle around with it.

Is this reqd, or can this be made to work without the need for this?

If this reqd, why not provide a helper function for that in block layer
itself, may be, with a warning about usage?

Thanks
Nikanth Karthikesan


