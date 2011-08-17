From: Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: [PATCH v3 1/3] drivers/block/mtip32xx: Adding header file and
  source for pci and block related operation
Date: Wed, 17 Aug 2011 17:32:58 -0600
Message-ID: <4E4C4FAA.70409@micron.com>
References: <22A973199D2C2F46933448F6E7990A3002C80025@ntxboimbx31.micron.com> <4E44DE84.2030306@fusionio.com>
Reply-To: <asamymuthupa@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:11456 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab1HQXdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2011 19:33:42 -0400
In-Reply-To: <4E44DE84.2030306@fusionio.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Moyer <jmoyer@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>, "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>

On 8/12/2011 2:04 AM, Jens Axboe wrote:
> On 2011-08-11 20:52, Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR] wrote:
>> +       /*
>> +        * Semaphore used to lock out read/write commands during the
>> +        * execution of an internal command.
>> +        */
>> +       struct rw_semaphore internal_sem;
> 
> I hope you are not using that in a hot path...

As we don't use a queue, we can't inject the IOCTL/PIO commands at the
head of the queue like the ahci stack. So we have to wait on all NCQ
commands to complete while preventing more from being issued, issue our
'internal' command, wait for it to complete, and  then resume NCQ
submissions. Ideally, we'd like to do this without the overhead of
managing a queue for performance reasons. Do you have any suggestion for
this problem?

>> +int mtip_block_initialize(struct driver_data *dd)
>> +{
>> +       int rv = 0;
>> +       sector_t capacity;
>> +       unsigned int index = 0;
>> +       struct kobject *kobj;
>> +
>> +       /* Initialize the protocol layer. */
>> +       rv = mtip_hw_init(dd);
>> +       if (rv < 0) {
>> +               dev_err(&dd->pdev->dev,
>> +                       "Protocol layer initialization failed\n");
>> +               rv = -EINVAL;
>> +               goto protocol_init_error;
>> +       }
>> +
>> +       /* Allocate the request queue. */
>> +       dd->queue = blk_alloc_queue(GFP_KERNEL);
> 
> It'd be nice for a high perf device like this to allocate the queue node
> local.

We thought not to mess with block layer housekeeping for request queue.
Will there be any performance gain if the driver allocates the request
queue? Is there any other benefit?


-- 
Regards,
Asai Thambi
