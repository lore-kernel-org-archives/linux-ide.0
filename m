From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 01:17:58 +0200
Message-ID: <200708020117.58916.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <200708020019.25742.bzolnier@gmail.com> <20070801233221.34e2ff0c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:32723 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbXHAXT3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 19:19:29 -0400
Received: by mu-out-0910.google.com with SMTP id i10so438350mue
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 16:19:27 -0700 (PDT)
In-Reply-To: <20070801233221.34e2ff0c@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, linux-ide@vger.kernel.org

On Thursday 02 August 2007, Alan Cox wrote:
> > If you fix the printk, add patch description (can use the one from my patch)
> > and add "Signed-off-by:" I would happily apply it and dump mine version.
> 
> Sorry but the patch is wrong - plain and simple. It works over the bug
> but its not the real problem. ide-disk needs to spot a 1K request for the
> last 512 bytes, issue a 512 byte request and complete the 512 bytes only.

block/ll_rw_blk.c:

static inline void __generic_make_request(struct bio *bio)
{
...
        int ret, nr_sectors = bio_sectors(bio);
...
        /* Test device or partition size, when known. */
        maxsector = bio->bi_bdev->bd_inode->i_size >> 9;
        if (maxsector) {
                sector_t sector = bio->bi_sector;

                if (maxsector < nr_sectors || maxsector - nr_sectors < sector) {
                        /*
                         * This may well happen - the kernel calls bread()
                         * without checking the size of the device, e.g., when
                         * mounting a device.
                         */
                        handle_bad_sector(bio);
                        goto end_io;

so low-level-driver should never see such requests.

Additionally fs/partitions/check.c:rescan_partitions() should warn if the
partition exceeds device size and we are not seeing any such warning.

Mikko, could you please revert any patches that you have applied, uncomment
#define DEBUG in ide-disk.c, recompile and note the sectors count in the

"hdd: reading: block=78165360 sectors=..."

debug message?

Thanks,
Bart
