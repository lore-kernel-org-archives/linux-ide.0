From: Abutalib Aghayev <agayev@gmail.com>
Subject: Re: Race in AHCI code?
Date: Fri, 04 Jul 2014 12:59:44 -0400
Message-ID: <871tu1m3z8.fsf@gmail.com>
References: <87d2dlzxka.fsf@gmail.com> <20140704155752.GB764@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:42332 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbaGDRYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jul 2014 13:24:32 -0400
Received: by mail-qg0-f51.google.com with SMTP id z60so1676604qgd.10
        for <linux-ide@vger.kernel.org>; Fri, 04 Jul 2014 10:24:31 -0700 (PDT)
In-reply-to: <20140704155752.GB764@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

--=-=-=
Content-Type: text/plain


Adding linux-ide per Tejun's request.

On Fri, Jul 04 2014 at 11:57 AM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Can you please cc linux-ide@vger.kernel.org in future postings?
>
> On Thu, Jul 03, 2014 at 09:57:11PM -0400, Abutalib Aghayev wrote:
>> I face the following problem: if I send more
>> than a single bio with 256 pages, one right after another, to a SATA
>> device as follows:
>>
>>    generic_make_request(bio1_with_256_pages);
>>    generic_make_request(bio2_with_256_pages);
>>
>> I get the error at messages you see at the end.  Currently all
>> distributions set max_sectors limit for SATA drives to 1024 sectors (128
>> pages) so this problem does not happen in the wild.  But given the fact
>> that hardware limit is 65535 sectors, I should be able to do the above
>> without any problems.
>
> That's a widely optimistic view.  I don't think any OS has been
> regularly using requests that big.  Linux certinaly hasn't.  The
> problem could be anywhere including the hardware.  Why do you say it's
> a "race" in AHCI code?  What suggests it's a race condition?

Because it is time dependent -- it takes various number of tries to
reproduce it -- and HostInt error, according to the spec is FIFO
over/underflow in HBA.

I have attached a proof-of-concept device mapper module that reliably
reproduces this.  It is a tiny module that is a wrapper around an
existing SATA drive and it splits the incoming bio into two chunks and
submits them in sequence.  It takes the chunk size (in pages) of the
first chunk as parameter.  For chunk size 250 the error happens
reliably, but for smaller values it never happens.

Here's how to reproduce:

1) Compile and install the module and create a device mapper target (250
is the chunk size here):

$ sudo insmod dm-poc.ko
$ echo 0 100000 poc /dev/sdb 250 | sudo dmsetup create poc

2) The module silently drops write requests (for safety) and requests
less than the specified chunk size (since they are not interesting).
After a few reads you see the errors in the logs:

$ while :; do sudo dd if=/dev/mapper/poc iflag=direct of=/dev/null bs=$((255*4096)) count=1; done

3) If you create the table with smaller chunk size the error never
happens:

$ sudo dmsetup remove poc
$ echo 0 100000 poc /dev/sdb 150 | sudo dmsetup create poc
$ while :; do sleep 1; sudo dd if=/dev/mapper/poc of=/dev/null bs=$((255*4096)) count=1 iflag=direct; done

The two interesting functions are poc_map() and clone_bio() both of
which are straightforward and less than 50 LOC.

>> I have a small proof of concept code that reproduces this reliably, in
>> case you are interested.  But first, I would like to ask: is the current
>> soft limit of 1024 sectors is due to some limitation in the AHCI driver,
>> since sending larger things causes below error?
>
> Mostly because that was enough.
>
>> I appreciate your response, thank you!
>>
>> ata3.00: exception Emask 0x60 SAct 0x3 SErr 0x800 action 0x6 frozen
>> ata3.00: irq_stat 0x20000000, host bus error
>> ata3: SError: { HostInt }
>> ata3.00: failed command: WRITE FPDMA QUEUED
>> ata3.00: cmd 61/48:00:58:90:1f/05:00:00:00:00/40 tag 0 ncq 692224 out
>>          res 50/00:58:00:90:1f/00:00:00:00:00/40 Emask 0x60 (host bus error)
>> ata3.00: status: { DRDY }
>
> This could be the OS messing up SG mapping or the controller puking on
> a large request.  Which controller are you using?

My controller information is below.  I've tried it on a number of
different machines with various controllers and I have even sent the POC
to a disk drive vendor who has reproduced it as well.

Thank you!

00:1f.2 SATA controller: Intel Corporation 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode] (rev 05) (prog-if 01 [AHCI 1.0])
        Subsystem: ASRock Incorporation Device 8c02
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 41
        I/O ports at f0d0 [size=8]
        I/O ports at f0c0 [size=4]
        I/O ports at f0b0 [size=8]
        I/O ports at f0a0 [size=4]
        I/O ports at f060 [size=32]
        Memory at f043a000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: <access denied>
        Kernel driver in use: ahci


--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=dm-poc.c

#include <linux/module.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/bio.h>
#include <linux/slab.h>
#include <linux/device-mapper.h>

#define DM_MSG_PREFIX "poc"

struct poc_c {
	struct dm_dev *dev;
	int chunk_size_in_pages;
        atomic_t nr_pending;
        struct bio *pending_bio;
};

static void endio(struct bio *bio, int error)
{
        struct poc_c *pc = bio->bi_private;

        bio_put(bio);

        if (atomic_dec_and_test(&pc->nr_pending))
                bio_endio(pc->pending_bio, error);
}

static struct bio *clone_bio(struct poc_c *pc, struct bio *bio, int idx,
                             int nr_pages)
{
        struct bio *clone = bio_clone(bio, GFP_NOIO);

        if (!clone)
                return NULL;

        clone->bi_sector = bio->bi_sector + (idx * 8); /* 8 sectors per page. */
        clone->bi_idx = idx;
        clone->bi_vcnt = idx + nr_pages;
        clone->bi_size = nr_pages * PAGE_SIZE;
        clone->bi_end_io = endio;
        clone->bi_bdev = pc->dev->bdev;
        clone->bi_private = pc;

        atomic_inc(&pc->nr_pending);

        return clone;
}

static int poc_map(struct dm_target *ti, struct bio *bio)
{
        struct poc_c *pc = ti->private;
        struct bio *clone1, *clone2;
        int nr_pages1 = pc->chunk_size_in_pages;
        int nr_pages2 = bio_segments(bio) - nr_pages1;

        if (bio_data_dir(bio) == WRITE || nr_pages2 <= 0) {
                bio_endio(bio, 0);
                return DM_MAPIO_SUBMITTED;
        }

        clone1 = clone_bio(pc, bio, 0, nr_pages1);
        clone2 = clone_bio(pc, bio, nr_pages1, nr_pages2);

        if (!clone1 || !clone2) {
                printk(KERN_ERR "Failed to clone bio.\n");
                return -EIO;
        }

        pc->pending_bio = bio;

        generic_make_request(clone1);
        generic_make_request(clone2);

	return DM_MAPIO_SUBMITTED;
}

static int poc_ctr(struct dm_target *ti, unsigned int argc, char **argv)
{
	struct poc_c *pc;
	unsigned long long tmp;
	char dummy;

	if (argc != 2) {
		ti->error = "Invalid argument count";
		return -EINVAL;
	}

	pc = kzalloc(sizeof(*pc), GFP_KERNEL);
	if (pc == NULL) {
		ti->error = "dm-poc: Cannot allocate poc context";
		return -ENOMEM;
        }

	if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1) {
		ti->error = "dm-poc: Invalid chunk size";
		goto bad;
	}
	pc->chunk_size_in_pages = tmp;
        atomic_set(&pc->nr_pending, 0);

	if (dm_get_device(ti, argv[0], dm_table_get_mode(ti->table), &pc->dev)) {
                printk(KERN_ERR "device is %s", argv[0]);
		ti->error = "dm-poc: Device lookup failed";
		goto bad;
	}
	ti->private = pc;

	return 0;

      bad:
	kfree(pc);
	return -EINVAL;
}

static void poc_dtr(struct dm_target *ti)
{
	struct poc_c *pc = (struct poc_c *) ti->private;

	dm_put_device(ti, pc->dev);
	kfree(pc);
}

static struct target_type poc_target = {
	.name   = "poc",
	.version = {1, 0, 0},
	.module = THIS_MODULE,
	.ctr    = poc_ctr,
	.dtr    = poc_dtr,
	.map    = poc_map,
};

int __init dm_poc_init(void)
{
	int r = dm_register_target(&poc_target);

	if (r < 0)
		DMERR("register failed %d", r);

	return r;
}

void dm_poc_exit(void)
{
	dm_unregister_target(&poc_target);
}

module_init(dm_poc_init);
module_exit(dm_poc_exit);

MODULE_LICENSE("GPL");

--=-=-=
Content-Type: text/plain
Content-Disposition: attachment; filename=Makefile

module := poc
obj-m := dm-$(module).o
KDIR := /lib/modules/$(shell uname -r)/build
PWD := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean

--=-=-=--
