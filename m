From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] ide: fix for ide_timing quantisation errors
Date: Thu, 13 Oct 2011 13:33:01 -0400 (EDT)
Message-ID: <20111013.133301.432417802471753173.davem@davemloft.net>
References: <201110131516.03408.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201110131516.03408.bzolnier@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Thu, 13 Oct 2011 15:16:03 +0200

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH v2] ide: fix for ide_timing quantisation errors
> 
> Based on commit 4f701d1 ("ata_timing: ensure t->cycle is always
> correct") for libata.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

I'm not applying patches that sync up the ATA layer with the IDE layer
in ways like this unless the change is in response to a user reported
bug.

We're way past the stage where we are making changes to the IDE
layer based purely upon visual inspection.  I want a real user
bug report to back most if not all changes.

These two layers will get out of sync, and you're going to have to
accept that.  Please concentrate your efforts on the ATA layer
if you want to make cleanups, simplifications, and fixes based
upon code audits.
