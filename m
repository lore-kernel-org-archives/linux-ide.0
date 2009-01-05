From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: [PATCH] block: export SSD/non-rotational queue flag through sysfs
Date: Mon, 05 Jan 2009 22:18:08 +0000
Message-ID: <49628720.6050101@yahoo.com>
References: <fa.+H1UnEqOmFht/vMPmVy8ellbQi0@ifi.uio.no> <fa.RLz5WOGorLui5GRkc963Ww1kXqg@ifi.uio.no> <fa.x4ejZ7Kj7ZZRu88Sond1Cap6XxY@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pih-relay05.plus.net ([212.159.14.18]:51872 "EHLO
	pih-relay05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbZAEWSC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 17:18:02 -0500
In-Reply-To: <fa.x4ejZ7Kj7ZZRu88Sond1Cap6XxY@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Jens Axboe <jens.axboe@oracle.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Kay Sievers wrote:
> On Mon, Jan 5, 2009 at 19:54, Jens Axboe <jens.axboe@oracle.com> wrote:
>> On Mon, Jan 05 2009, Bartlomiej Zolnierkiewicz wrote:
> 
>>> +static struct queue_sysfs_entry queue_nonrot_entry = {
>>> +     .attr = {.name = "nonrot", .mode = S_IRUGO | S_IWUSR },
>>> +     .show = queue_nonrot_show,
>>> +     .store = queue_nonrot_store,
>>> +};
>>> +
>> Lets please use a better name for export reasons, non-rotational is a
>> lot better. Nobody will know what nonrot means :-)
> 
> What's that negation good for? Can't we just have "rotational", like
> we have "removable" and not "non-removable"? :)

How about cheapseek? fastrandom? flash? ssd? However the internal flag 
is called QUEUE_FLAG_NONROT so it kind of makes sense just to leave it 
as nonrot...
