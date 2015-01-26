From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] libata: make sata_sil24 use fifo tag allocator
Date: Mon, 26 Jan 2015 08:39:27 -0800
Message-ID: <CAPcyv4jEDewtXJRZROCZHUW2Mm2ab-hGbf+rOfebmOv0-ERWJQ@mail.gmail.com>
References: <e836211c9bce48b23ddf37a4d8832e1b2fbd893c.1422072962.git.shli@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:56841 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752905AbbAZQj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 26 Jan 2015 11:39:29 -0500
Received: by mail-wi0-f176.google.com with SMTP id em10so11285970wid.3
        for <linux-ide@vger.kernel.org>; Mon, 26 Jan 2015 08:39:27 -0800 (PST)
In-Reply-To: <e836211c9bce48b23ddf37a4d8832e1b2fbd893c.1422072962.git.shli@fb.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shli@fb.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@infradead.org>

On Fri, Jan 23, 2015 at 8:17 PM, Shaohua Li <shli@fb.com> wrote:
> libata starts using block tag now, we can use BLK_TAG_ALLOC_FIFO to
> solve the sata_sil24 tag bug.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=87101
>
> Cc: Jens Axboe <axboe@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Shaohua Li <shli@fb.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
