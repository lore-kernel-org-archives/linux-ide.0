From: Asai Thambi S P <asamymuthupa@micron.com>
Subject: Re: [PATCH v3 2/3] drivers/block/mtip32xx: Adding source for hardware
  related operations
Date: Wed, 17 Aug 2011 18:18:39 -0600
Message-ID: <4E4C5A5F.2090709@micron.com>
References: <22A973199D2C2F46933448F6E7990A3002C80026@ntxboimbx31.micron.com> <4E44E782.7090309@fusionio.com>
Reply-To: <asamymuthupa@micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:42129 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1HRAS7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Aug 2011 20:18:59 -0400
In-Reply-To: <4E44E782.7090309@fusionio.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Moyer <jmoyer@redhat.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>, "Sam Bradshaw (sbradshaw)" <sbradshaw@micron.com>

On 8/12/2011 2:42 AM, Jens Axboe wrote:
>> +/*
>> + * Obtain an empty command slot.
>> + *
>> + * This function needs to be reentrant since it could be called
>> + * at the same time on multiple CPUs. The allocation of the
>> + * command slot must be atomic.
>> + *
>> + * @port Pointer to the port data structure.
>> + *
>> + * return value
>> + *     >= 0    Index of command slot obtained.
>> + *     -1      No command slots available.
>> + */
>> +static int get_slot(struct mtip_port *port)
>> +{
>> +       int slot, i;
>> +       unsigned int num_command_slots = port->dd->slot_groups * 32;
>> +
>> +       /*
>> +        * Try 10 times, because there is a small race here.
>> +        *  that's ok, because it's still cheaper than a lock.
>> +        */
> 
> Might want to expand on what that race is.

find_next_zero_bit and test_and_set, in order, could be executed in
different process contexts in different processor. So both(2 or more)
contexts could land in choosing the same bit, but test_and_set will
succeed only for one. The failing contexts will try to get the next bit
in subsequent retries. This operation is cheaper than a lock.

This procedure is protected under the counting semaphore, so there is a
slot request for every context that calls this routine.

Is there an equivalent of doing find_next_zero_bit and test_and_set_bit
atomically?


>> +static irqreturn_t mtip_irq_handler(int irq, void *instance)
>> +{
>> +       struct driver_data *dd = instance;
>> +#ifdef MTIP_USE_TASKLET
>> +       tasklet_schedule(&dd->tasklet);
>> +       return IRQ_HANDLED;
>> +#else
>> +       return mtip_handle_irq(dd);
>> +#endif
>> +}
> 
> Have you experimented with blk-iopoll?

Working on this. Believe this experiment could go in parallel to
submission. Let us know.

>> +/*
>> + * Byte-swap ATA ID strings.
>> + *
>> + * ATA identify data contains strings in byte-swapped 16-bit words.
>> + * They must be swapped (on all architectures) to be usable as C
>> strings.
>> + * This function swaps bytes in-place.
>> + *
>> + * @buf The buffer location of the string
>> + * @len The number of bytes to swap
>> + *
>> + * return value
>> + *     None
>> + */
>> +static inline void ata_swap_string(u16 *buf, unsigned int len)
>> +{
>> +       int i;
>> +       for (i = 0; i < (len/2); i++)
>> +               be16_to_cpus(&buf[i]);
>> +}
> 
> I'm pretty sure we have the exact same thing in IDE and libata, so lets
> put this somewhere we they can all use it.

Is ata.h an appropriate location? Would it be better to make this change
after inclusion of this driver?

> 
> Overall looks very clean. If you take care of the little things
> mentioned by me and Christoph, I don't see anything stopping this from
> being merged for 3.2.

Appreciate your valuable feedback.

-- 
Regards,
Asai Thambi
