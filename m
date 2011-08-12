From: Jens Axboe <jaxboe@fusionio.com>
Subject: Re: [PATCH v3 1/3] drivers/block/mtip32xx: Adding header file and
  source for pci and block related operation
Date: Fri, 12 Aug 2011 10:04:20 +0200
Message-ID: <4E44DE84.2030306@fusionio.com>
References: <22A973199D2C2F46933448F6E7990A3002C80025@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <22A973199D2C2F46933448F6E7990A3002C80025@ntxboimbx31.micron.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]" <asamymuthupa@micron.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Moyer <jmoyer@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>
List-Id: linux-ide@vger.kernel.org

On 2011-08-11 20:52, Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR] wrote:
> +#ifndef WIN_SMART
> + #define WIN_SMART       0xB0
> +#endif

We have defines for this, just use those.

> +#ifndef TRUE
> + #define TRUE 1
> +#endif
> +
> +#ifndef FALSE
> + #define FALSE 0
> +#endif

Get rid of any TRUE/FALSE, just use true/false.

> + * Use a tasklet for bottom half IRQ processing.
> + *
> + * Set to 1 to use a tasklet for bottom half IRQ processing.
> + */
> +#define MTIP_USE_TASKLET       1

As Christoph said, either get rid of this one or make it an option. My
advise would be to kill it completely. It's one of those design
decisions that you have to make, not a potential customer/user.

> +/* Macro to extract the tag bit number from a tag value. */
> +#define MTIP_TAG_BIT(tag)      (tag & 0x1f)
> +
> +/*
> + * Macro to extract the tag index from a tag value. The index
> + * is used to access the correct s_active/Command Issue register based
> + * on the tag value.
> + */
> +#define MTIP_TAG_INDEX(tag)    (tag >> 5)

You have these, but don't seem to use them consistently.

> +/* Forced Unit Access Bit */
> +#define FUA_BIT                        0x80

Ditto WIN_SMART.

> +       /*
> +        * Semaphore used to lock out read/write commands during the
> +        * execution of an internal command.
> +        */
> +       struct rw_semaphore internal_sem;

I hope you are not using that in a hot path...

> +/*
> + * BIO completion function.
> + *
> + * @bio    Pointer to the BIO that has completed.
> + * @status Completion status, 0 = success, non-zero = error.
> + *
> + * return value
> + *     0
> + */
> +static int mtip_complete_bio(struct bio *bio, int status)
> +{
> +       bio_endio(bio, status);
> +       return 0;
> +}

Why wrap this?

> +int mtip_block_initialize(struct driver_data *dd)
> +{
> +       int rv = 0;
> +       sector_t capacity;
> +       unsigned int index = 0;
> +       struct kobject *kobj;
> +
> +       /* Initialize the protocol layer. */
> +       rv = mtip_hw_init(dd);
> +       if (rv < 0) {
> +               dev_err(&dd->pdev->dev,
> +                       "Protocol layer initialization failed\n");
> +               rv = -EINVAL;
> +               goto protocol_init_error;
> +       }
> +
> +       /* Allocate the request queue. */
> +       dd->queue = blk_alloc_queue(GFP_KERNEL);

It'd be nice for a high perf device like this to allocate the queue node
local.

> +       /* Set device limits. */
> +       set_bit(QUEUE_FLAG_NOMERGES, &dd->queue->queue_flags);

This wont matter, if you are using ->make_request_fn entry.

-- 
Jens Axboe
