From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Mon, 5 Jan 2009 22:47:22 +0100
Message-ID: <ac3eb2510901051347r6593d0fmd64702b1689716c1@mail.gmail.com>
References: <200901051952.58029.bzolnier@gmail.com>
	 <20090105185428.GS32491@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:28569 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbZAEVrX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 16:47:23 -0500
In-Reply-To: <20090105185428.GS32491@kernel.dk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Jan 5, 2009 at 19:54, Jens Axboe <jens.axboe@oracle.com> wrote:
> On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:

>> +static struct queue_sysfs_entry queue_nonrot_entry = {
>> +     .attr = {.name = "nonrot", .mode = S_IRUGO | S_IWUSR },
>> +     .show = queue_nonrot_show,
>> +     .store = queue_nonrot_store,
>> +};
>> +
>
> Lets please use a better name for export reasons, non-rotational is a
> lot better. Nobody will know what nonrot means :-)

What's that negation good for? Can't we just have "rotational", like
we have "removable" and not "non-removable"? :)

Thanks?
Kay
