From: "Asai Thambi Samymuthu Pattrayasamy (asamymuthupa) [CONTRACTOR]"
	<asamymuthupa@micron.com>
Subject: [PATCH 3/3] New driver mtipx2xx submission
Date: Tue, 3 May 2011 14:25:56 -0600
Message-ID: <22A973199D2C2F46933448F6E7990A300204FB93@ntxboimbx31.micron.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:19238 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab1ECU0A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 May 2011 16:26:00 -0400
Received: from ntxboimbx31.micron.com (ntxboimbx31.micron.com [137.201.91.17])
	by masquerade.micron.com (8.13.6/8.13.6) with SMTP id p43KPx0W007502
	for <linux-ide@vger.kernel.org>; Tue, 3 May 2011 14:25:59 -0600
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Part 3

diff -uNr a/drivers/block/mtipx2xx/block.c
b/drivers/block/mtipx2xx/block.c
--- a/drivers/block/mtipx2xx/block.c	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/block.c	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,641 @@
+/**********************************************************************
*******
+ *
+ * block.c - Handles the block layer of the Cyclone SSD Block Driver
+ *   Copyright (C) 2009  Integrated Device Technology, Inc.
+ *
+ *  Changes from IDT 1.0.1 are copyright (C) 2010 Micron Technology,
Inc.
+ *
+ *  This file is part of the Cyclone SSD Block Driver, it is free
software:
+ *  you can redistribute it and/or modify it under the terms of the GNU
+ *  General Public License as published by the Free Software
Foundation;
+ *  either version 2 of the License, or (at your option) any later
version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *  if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street,
+ *  Fifth Floor, Boston,
+ *  MA 02110-1301,
+ *  USA.
+ *
+
************************************************************************
****/
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/bio.h>
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/idr.h>
+#include "mtipx2xx.h"
+
+/**
+ * This layer will manage the allocation and registration of block
devices,
+ * request queuing, and the inter-face into the kernel block layer.
+ * The block layer will also be required to call into the protocol
layer.
+ * Since multiple protocols are supported, the block layer uses a
structure
+ * called PROTOCOL_FUNCS, which is an array of structures that contain
+ * pointers to functions exported by the protocol layers. An example of
the
+ * PROTOCOL_FUNCS table is shown below.
+ * @verbatim
+static PROTOCOL_FUNCS protocol[] = {
+	{
+		.init = ahci_init,
+		.exit = ahci_exit,
+#ifdef CONFIG_PM
+		.suspend = ahci_suspend,
+		.resume = ahci_resume,
+#endif
+		.shutdown = ahci_shutdown,
+		.read = ahci_read,
+		.write = ahci_write,
+		.hwBlkSize = ahci_hard_blksize,
+		.getCapacity = ahci_get_capacity,
+		.getScatterList = ahci_get_scatterList,
+		.ioctl = ahci_ioctl,
+		.sysfsInit = ahci_sysfs_init,
+		.sysfsExit = ahci_sysfs_exit,
+	},
+	{}
+};
+@endverbatim
+ * In the above example only one protocol is supported, AHCI.
+ * The block layer accesses the appropriate array element in the table
by
+ * using the protocol index value that was defined in the pci_device_id
table
+ * and passed to the block layer in the driver private data structure.
+ * This allows the same Block Layer source code to interface to
multiple
+ * protocol layers based on the PCI vendor/device ID of the device.
+ *
+ * All Cyclone devices will utilize the same major device number,
allocated by
+ * the Module Layer, and will support 16 minor device numbers. This
will allow
+ * each Cyclone device to have an entry under /dev for the "full
device" and 15
+ * partitions.
+ * For example, the first Cyclone device detected will have a major/min
+ * device number of 0,0. The first partition on this drive will have a
+ * major/minor device number of 0,1, and so on. The second Cyclone
device will
+ * have the same major device number but its minor device number will
be 16,
+ * the third Cyclone device will have a minor device number of 32, etc.
Cyclone
+ * devices are registered with the kernel block layer as "cyclone",
+ * consequently they appear under /dev as cyclonex where x is a letter
a-z
+ * which is assigned in the order that the drives are detected.
+ * Partitions are referenced as /dev/cyclonexn, where n is the
+ * partition number 1-15.
+ *
+ * The Kernel block layer requires that the following functions be
implemented
+ * by the block device driver.
+ *
+ * - open() - Called when the block device is opened, i.e. mounted,
etc.
+ * This function will perform minimal initialization since there is
really
+ * nothing to do when the device is opened.
+ *
+ * - release() - Called when the block device is closed.
+ *
+ * - ioctl() - Called by the kernel block layer when it receives an
IOCTL
+ * request that it does not understand. This will be the mechanism by
which
+ * the SMART information will be obtained from the device and how
vendor
+ * specific commands will be issued to the device.
+ *
+ * - make_request() - Called by the kernel to process a BIO structure.
+ * This function is the main guts of the block layer. It receives BIO
requests
+ * from the kernel, processes them, and then issues read or writes to
the
+ * protocol layer. Upon completion of a request by the protocol layer
it will
+ * callback into the block layer to complete the transfer. This is the
only
+ * acceptable manner in which a driver layer may call a function that
belongs
+ * to a higher layer. It is also worth noting that this interface will
bypass
+ * the I/O scheduler. No merging or reordering of the BIO's will be
performed.
+ * See the section titled BIO Processing for detaile information on
exactly
+ * how a BIO is handled.
+ *
+ * Additionally, the PCI layer requires that the following management
functions
+ * be implemented in the drivers block layer.
+ *
+ * - block_initialize() - Called by the PCI layer to initialize the
block device
+ * and layer. This function should first call the Protocol Layer
initialization
+ * function. Once that is done, this function will allocate a block
request
+ * queue, inform the kernel of the hardware block size, allocate a
Linux disk
+ * structure, inform the kernel of the drives capacity, and finally add
the new
+ * disk to the system. The hardware block size and drive capacity are
obtained
+ * by calling the hwBlkSize() and getCapacity() functions in the
Protocol Layer,
+ * respectively.
+ *
+ * - block_remove() - Called by the PCI layer to de-initialize the
block device
+ * and layer. This function must remove the block device from the
system before
+ * calling the Protocol Layer exit() function.
+ *
+ * - block_shutdown() - Called by the PCI layer just before the system
halts
+ * during a shutdown. This function should call the protocol layers
shutdown()
+ * function to sync the device before the system is powered off.
+ *
+ * - block_suspend() - Called by the PCI layer during
hibernation/suspend of the
+ * system. This function should call the protocol layers suspend()
function to
+ * change the power state of the device
+ *
+ * - block_resume() - Called by the PCI layer while resuming from
+ * hiberation/suspend of the system. This function should call the
protocol
+ * layers resume() function to change the power state of the device.
+ */
+
+static int rssd_disk_name_format(char *prefix,
+				int index,
+				char *buf,
+				int buflen);
+
+static DEFINE_IDA(rssd_index_ida);
+
+static struct  PROTOCOL_FUNCS	protocol[] = {
+		{
+				.init = ahci_init,
+				.exit = ahci_exit,
+				.suspend = ahci_suspend,
+				.resume = ahci_resume,
+				.shutdown = ahci_shutdown,
+				.read = ahci_read,
+				.write = ahci_write,
+				.hwBlkSize = ahci_hard_blksize,
+				.getCapacity = ahci_get_capacity,
+				.getScatterList = ahci_get_scatterlist,
+				.ioctl = ahci_ioctl,
+				.sysfsInit = ahci_sysfs_init,
+				.sysfsExit = ahci_sysfs_exit,
+		},
+		{}	/* Terminate the list*/
+};
+
+/**
+ * @brief Block layer IOCTL handler.
+ *
+ * @param dev Pointer to the block_device structure.
+ * @param mode ????
+ * @param cmd IOCTL command passed from the user application.
+ * @param arg Argument passed from the user application.
+ *
+ * @retval 0 IOCTL completed successfully.
+ * @retval -ENOTTY IOCTL not supported or invalid driver data structure
pointer.
+ */
+static int block_ioctl(struct block_device *dev,
+			fmode_t mode,
+			unsigned cmd,
+			unsigned long arg)
+{
+	struct driver_data *dd = dev->bd_disk->private_data;
+	int rv = 0;
+
+	if (!dd)
+		return -ENOTTY;
+
+	switch (cmd) {
+	case BLKFLSBUF: /* Flush the device buffers, if it has any. */
+		printk(KERN_INFO "%s: Received BLKFLSBUF\n", __func__);
+		break;
+	default:
+		rv = protocol[dd->protocol].ioctl(dd, cmd, arg);
+	}
+	return rv;
+}
+
+/**
+ * @brief Obtain the geometry of the device.
+ *
+ * You may think that this function is obsolete, but some applications,
+ * fdisk for example still used CHS values. This function describes the
+ * device as having 224 heads and 56 sectors per cylinder. These values
are
+ * chosen so that each cylinder is aligned on a 4KB boundary. Since a
partition
+ * is described in terms of a start and end cylinder this means that
each
+ * partition is also 4KB aligned. Non-aligned partitions adversely
affects
+ * performance.
+ *
+ * @param dev Pointer to the block_device strucutre.
+ * @param geo Pointer to a hd_geometry structure.
+ *
+ * @retval 0 Operation completed successfully.
+ * @retval -ENOTTY An error occurred while reading the drive capacity.
+ */
+static int block_getgeo(struct block_device *dev, struct hd_geometry
*geo)
+{
+	struct driver_data *dd = dev->bd_disk->private_data;
+	sector_t capacity;
+	capacity = protocol[dd->protocol].getCapacity(dd);
+	if (capacity == (sector_t) -1) {
+		printk(KERN_ERR "%s: Could not get drive capacity.\n",
+					__func__);
+		return -ENOTTY;
+	}
+
+	geo->heads = 224;
+	geo->sectors = 56;
+#if BITS_PER_LONG == 64
+	geo->cylinders = capacity / (geo->heads*geo->sectors);
+#else
+	do_div(capacity, (geo->heads*geo->sectors));
+	geo->cylinders = capacity;
+#endif
+	return 0;
+}
+
+/**
+ * @brief Block device operation function.
+ *
+ * This structure contains pointers to the functions required by the
block
+ * layer.
+ */
+static const struct block_device_operations blockOps = {
+		/**
+		 * Called to process an IOCTL for the block device.
+		 */
+		.ioctl		= block_ioctl,
+		/**
+		 * Called to obtain the drives geometry.
+		 */
+		.getgeo		= block_getgeo,
+		/**
+		 * Owner of this structure.
+		 */
+		.owner		= THIS_MODULE
+};
+
+/**
+ * @brief BIO completion function.
+ *
+ * This function is called by the protocol layer to complete a BIO
transfer.
+ * A Pointer to this function is passed into the protocol layer
read/write
+ * functions as the completion callback.
+ *
+ * @param bio Pointer to the BIO that has completed.
+ * @param status Completion status, 0 = success, non-zero = error.
+ *
+ * @return This function always returns 0.
+ */
+static int complete_bio(struct bio *bio, int status)
+{
+	bio_endio(bio, status);
+	return 0;
+}
+
+
+#define bio_rw_flagged(bio, flag) ((bio)->bi_rw & flag)
+
+/**
+ * @brief Block layer make request function.
+ *
+ * This function is called by the kernel to process a BIO for
+ * the Cyclone device.
+ *
+ * @param queue Pointer to the request queue. Unused other than to
obtain the driver data structure.
+ * @param bio Pointer to the BIO.
+ *
+ * @return This function always returns 0.
+ */
+static int make_request(struct request_queue *queue, struct bio *bio)
+{
+	struct driver_data *dd = queue->queuedata;
+	struct scatterlist *sg;
+	struct bio_vec *bvec;
+	int nents = 0;
+	int tag = 0;
+	if (unlikely(!bio_has_data(bio))) {
+		blk_queue_flush(queue, 0);
+		bio_endio(bio, 0);
+		return 0;
+	}
+
+	sg = protocol[dd->protocol].getScatterList(dd, &tag);
+	if (likely(sg != NULL)) {
+		blk_queue_bounce(queue, &bio);
+
+		if (unlikely((bio)->bi_vcnt > MAX_SG)) {
+			printk(KERN_WARNING "Maximum number of scatter
list entries exceeded\n");
+			bio_io_error(bio);
+			return 0;
+		}
+
+		/*
+		 * Create the scatter list for this bio.
+		 */
+		bio_for_each_segment(bvec, bio, nents)
+		{
+			sg_set_page(&sg[nents],
+					bvec->bv_page,
+					bvec->bv_len,
+					bvec->bv_offset);
+		}
+
+		/*
+		 * Issue the read or write to the protocol layer.
+		 */
+		if (bio_data_dir(bio) == WRITE) {
+			protocol[dd->protocol].write(dd,/* Driver data
*/
+					/* Start sector */
+						bio->bi_sector,
+					/* # sectors to write */
+						bio_sectors(bio),
+					/*entries in the scatterlist*/
+						nents,
+					/*tag obtained with
scatterlist*/
+						tag,
+					/* Blocklayer completion
routineo*/
+						complete_bio,
+					/*Blocklayer completion data*/
+						bio,
+					/*Write must be flushed to
media*/
+						bio_rw_flagged(bio,
REQ_FLUSH));
+		} else {
+			protocol[dd->protocol].read(dd,	/* Driver data
*/
+					/* Start sector */
+						bio->bi_sector,
+					/* # sectors to read */
+						bio_sectors(bio),
+					/* # entries in the scatter list
*/
+						nents,
+					/* tag obtained with scatter
list */
+						tag,
+					/* Block layer completion
routine */
+						complete_bio,
+					/*Block layer completion data*/
+						bio,
+					/*Read must be from
physicalmedia*/
+						bio_rw_flagged(bio,
REQ_FLUSH));
+		}
+	} else {
+			bio_io_error(bio);
+		/*printk(KERN_ERR "%s: Interrupted\n", __func__);*/
+	}
+
+	return 0;
+}
+
+/**
+ * @brief Block layer initialization function.
+ *
+ * This function is called once by the PCI layer for each Cyclone
+ * device that is connected to the system.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return 0 on success else an error code.
+ */
+int block_initialize(struct driver_data *dd)
+{
+	int rv = 0;
+	sector_t capacity;
+	unsigned int  index = 0;
+	/*
+	 * Initialize the protocol layer.
+	 */
+	rv = protocol[dd->protocol].init(dd);
+	if (rv  < 0) {
+		printk(KERN_ERR "protocol layer initialization
failed\n");
+		rv = -EINVAL;
+		goto protocol_init_error;
+	}
+
+	/*
+	 * Allocate the request queue.
+	 */
+	dd->queue = blk_alloc_queue(GFP_KERNEL);
+	if (dd->queue == NULL) {
+		printk(KERN_ERR "Unable to allocate request queue\n");
+		rv = -ENOMEM;
+		goto block_queue_alloc_init_error;
+	}
+
+	/*
+	 * Attach our request function to the request queue.
+	 */
+	blk_queue_make_request(dd->queue, make_request);
+
+	/* Set device limits.
+	* Even settings normally directed at the elevator are assigned,
+	* because they are exported to userspace via sysfs and might
+	* be used for tuning.
+	*/
+
+	set_bit(QUEUE_FLAG_NOMERGES, &dd->queue->queue_flags);
+	set_bit(QUEUE_FLAG_NONROT, &dd->queue->queue_flags);
+
+
+	/*set_bit(QUEUE_FLAG_SAME_COMP, &dd->queue->queue_flags);
+	 * fixme: should we use this? */
+	/*set_bit(QUEUE_FLAG_ELVSWITCH, &dd->queue->queue_flags);
+	 * fixme: should we use this? */
+
+	blk_queue_max_segments(dd->queue, MAX_SG);
+
+	/*blk_queue_max_hw_sectors(dd->queue, 1<<20);
+	 * fixme: figure out what the hardware's max sector size is.*/
+
+	blk_queue_physical_block_size(dd->queue, 4096);
+	/*blk_queue_alignment_offset(dd->queue, 0);   // default is 0.*/
+	blk_queue_io_min(dd->queue, 4096);          /*
sysfs/minimum_io_size*/
+	/* not sure yet.  sysfs/optimal_io_size*/
+	/*blk_queue_io_opt(dd->queue, 4096);*/
+
+	/* no discard support yet.*/
+	/*set_bit(QUEUE_FLAG_DISCARD, &dd->queue->queue_flags);
+	*dd->queue->limits.discard_granularity=4096;
+	*not sure yet.  1<<22 is 1<<31 in sectors.
+	*blk_queue_max_discard_sectors(dd->queue, 1<<22);
+	*dd->queue->limits.discard_zeroes_data=0; // ?
+	*/
+	dd->disk = alloc_disk(MAX_MINORS);
+	if (dd->disk  == NULL) {
+		printk(KERN_ERR "Unable to allocate gendisk
structure\n");
+		rv = -EINVAL;
+		goto alloc_disk_error;
+	}
+	/*
+	 * Generate the disk name, implemented same as in sd.c
+	 */
+	do {
+		if (!ida_pre_get(&rssd_index_ida, GFP_KERNEL))
+				goto ida_get_error;
+
+		down_write(&dd->internalSem);
+		rv = ida_get_new(&rssd_index_ida, &index);
+		up_write(&dd->internalSem);
+	} while (rv == -EAGAIN);
+
+	if (rv)
+		goto ida_get_error;
+
+	rv = rssd_disk_name_format("rssd",
+				index,
+				dd->disk->disk_name,
+				DISK_NAME_LEN);
+	if (rv)
+		goto disk_index_error;
+
+	dd->disk->driverfs_dev	= &dd->pdev->dev;
+	dd->disk->major		= dd->major;
+	dd->disk->first_minor	= dd->instance * MAX_MINORS;
+	dd->disk->fops		= &blockOps;
+	dd->disk->queue		= dd->queue;
+	dd->disk->private_data	= dd;
+	dd->queue->queuedata	= dd;
+	dd->index				= index;
+
+	/*
+	 * Set the capacity of the device in 512 byte sectors.
+	 */
+	capacity = protocol[dd->protocol].getCapacity(dd);
+	if (capacity == (sector_t) -1) {
+		printk(KERN_ERR "Could not read drive capacity\n");
+		rv = -EIO;
+		goto read_capacity_error;
+	}
+	set_capacity(dd->disk, capacity);
+
+	/*
+	 * Enable the block device and add it to /dev
+	 */
+	add_disk(dd->disk);
+
+	/*
+	 * Now that the disk is active, initialize any sysfs attributes
+	 * managed by the protocol layer.
+	 */
+	if (protocol[dd->protocol].sysfsInit) {
+		struct kobject *kobj =
+			kobject_get(&disk_to_dev(dd->disk)->kobj);
+		protocol[dd->protocol].sysfsInit(dd, kobj);
+		kobject_put(kobj);
+	}
+
+	return rv;
+
+read_capacity_error:
+	/*
+	 * Delete our gendisk structure. This also removes the device
+	 * from /dev
+	 */
+	del_gendisk(dd->disk);
+
+disk_index_error:
+	down_write(&dd->internalSem);
+	ida_remove(&rssd_index_ida, index);
+	up_write(&dd->internalSem);
+
+ida_get_error:
+	put_disk(dd->disk);
+
+alloc_disk_error:
+
+	blk_cleanup_queue(dd->queue);
+
+block_queue_alloc_init_error:
+	/*
+	 * De-initialize the protocol layer.
+	 */
+	protocol[dd->protocol].exit(dd);
+protocol_init_error:
+	return rv;
+}
+
+/**
+ * @brief Block layer deinitialization function.
+ *
+ * Called by the PCI layer as each Cyclone device is removed.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return This function always returns 0.
+ */
+int block_remove(struct driver_data *dd)
+{
+
+	/*
+	 * Clean up the sysfs attributes managed by the protocol layer.
+	 */
+	if (protocol[dd->protocol].sysfsExit) {
+		struct kobject *kobj =
+			kobject_get(&disk_to_dev(dd->disk)->kobj);
+		protocol[dd->protocol].sysfsExit(dd, kobj);
+		kobject_put(kobj);
+	}
+
+	/*
+	 * Delete our gendisk structure. This also removes the device
+	 * from /dev
+	 */
+	del_gendisk(dd->disk);
+	blk_cleanup_queue(dd->queue);
+	dd->disk  = NULL;
+	dd->queue = NULL;
+
+	/*
+	 * De-initialize the protocol layer.
+	 */
+	protocol[dd->protocol].exit(dd);
+
+	return 0;
+}
+
+/**
+ * @brief Function called by the PCI layer when just before the
+ * machine shuts down.
+ *
+ * If a protocol layer shutdown function is present it will be called
+ * by this function.
+ *
+ * @param dd Pointer to the driver data structure.
+ *
+ * @return This function always returns 0.
+ */
+int block_shutdown(struct driver_data *dd)
+{
+	printk(KERN_NOTICE "Shutting down %s\n", dd->disk->disk_name);
+
+	/* Delete our gendisk structure, and cleanup the blk queue. */
+	del_gendisk(dd->disk);
+	blk_cleanup_queue(dd->queue);
+	dd->disk  = NULL;
+	dd->queue = NULL;
+
+	if (protocol[dd->protocol].shutdown)
+		protocol[dd->protocol].shutdown(dd);
+	return 0;
+}
+
+int block_suspend(struct driver_data *dd)
+{
+	printk(KERN_NOTICE "Suspending %s\n", dd->disk->disk_name);
+	if (protocol[dd->protocol].suspend)
+		protocol[dd->protocol].suspend(dd);
+	return 0;
+}
+
+int block_resume(struct driver_data *dd)
+{
+	printk(KERN_NOTICE "Resuming %s\n", dd->disk->disk_name);
+	if (protocol[dd->protocol].resume)
+		protocol[dd->protocol].resume(dd);
+	return 0;
+}
+
+static int rssd_disk_name_format(char *prefix, int index, char *buf,
int buflen)
+{
+	const int base = 'z' - 'a' + 1;
+	char *begin = buf + strlen(prefix);
+	char *end = buf + buflen;
+	char *p;
+	int unit;
+	p = end - 1;
+	*p = '\0';
+	unit = base;
+	do {
+		if (p == begin)
+			return -EINVAL;
+		*--p = 'a' + (index % unit);
+		index = (index / unit) - 1;
+	} while (index >= 0);
+
+	memmove(begin, p, end - p);
+	memcpy(buf, prefix, strlen(prefix));
+
+	return 0;
+}
diff -uNr a/drivers/block/mtipx2xx/module.c
b/drivers/block/mtipx2xx/module.c
--- a/drivers/block/mtipx2xx/module.c	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/module.c	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,149 @@
+/**********************************************************************
*******
+ *
+ * module.c - Handles the module layer of the Cyclone SSD Block Driver
+ *   Copyright (C) 2009  Integrated Device Technology, Inc.
+ *
+ *  Changes from IDT 1.0.1 are copyright (C) 2010 Micron Technology,
Inc.
+ *
+ *  This file is part of the Cyclone SSD Block Driver, it is free
software:
+ *  you can redistribute it and/or modify it under the terms of the GNU
+ *  General Public License as published by the Free Software
Foundation;
+ *  either version 2 of the License, or (at your option) any later
version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *  if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street,
+ *  Fifth Floor, Boston,
+ *  MA 02110-1301,
+ *  USA.
+ *
+
************************************************************************
****/
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/pci.h>
+#include "mtipx2xx.h"
+
+/**
+ * @file
+ * The module layer manages the loading and unloading of the driver
module.
+ * Primarily this comprises of the module init and exit functions,
prototypes
+ * for which are shown below.
+ *
+ * static int __init cyclone_init(void);@n
+ * static void __exit cyclone_exit(void);
+ *
+ * These functions are declared as the module entry and exit points,
called
+ * when the module is loaded or unloaded by the following Linux macros.
+ *
+ * module_init(cyclone_init);@n
+ * module_exit(cyclone_exit);
+ *
+ * When the module is loaded, cyclone_init() will allocate a new major
device
+ * number for the Cyclone devices, this should be evident by an entry
in
+ * /proc/devices called "cyclone".
+ * This major device number will be used for all Cyclone devices
connected
+ * to the system. Assuming a new major device number was allocated,
+ * cyclone_init() will then register the PCI driver by
+ * calling pci_register_driver() passing the address of the
cyclone_pci_driver
+ * structure which is declared by the PCI layer.
+ *
+ * When the module is unloaded, cyclone_exit() is called to undo the
work
+ * done by cyclone_init(). So, basically freeing the major device
number
+ * and unregistering the PCI driver.
+ */
+
+/** @mainpage Cyclone Linux Block Device Driver
+ *
+ * @section Introduction
+ * The Cyclone SSD Linux Block Device Driver is a high performance low
latency
+ * driver that interfaces directly to the Linux kernel block layer,
bypassing
+ * the I/O scheduler. The driver will be implemented as a loadable
Linux module
+ * that will support multiple Cyclone devices, device versions, and
+ * interface protocols such as AHCI and NVMHCI.
+ * @section Driver Layers
+ * For ease of maintenance the driver will be split into layers as
depicted
+ * in Figure 1.
+ * Each layer will be self contained within a single C module.
+ * Each module exports a number of functions that constitute the layers
API.
+ * A layer may only access the API of the layer that is directly
beneath it.
+ * Calling functions that do not belong to the layer directly below the
+ * calling layer is prohibited, as is calling functions that belong to
the
+ * layer above the calling layer unless done so via a callback.
+ * In effect you can only call down through the stack.
+ *
+ * @image html Layers.jpg Figure 1 - Cyclone Driver Layers
+ */
+
+
+/**
+ * Global variable used to hold the major block device number
+ * allocated in cyclone_init().
+ */
+int cyclone_major;
+
+/**
+ * Module initialization function.
+ *
+ * Called once when the module is loaded. This function allocates a
major
+ * block device number to the Cyclone devices and registers the PCI
layer
+ * of the driver.
+ *
+ * @return 0 on success else error code.
+ */
+static int __init cyclone_init(void)
+{
+	printk(KERN_INFO DRV_NAME " Version " DRV_VERSION "\n");
+
+	/*
+	 * Allocate a major block device number to use with this
+	 * driver.
+	 */
+	cyclone_major = register_blkdev(0, "mtipx2xx");
+	if (cyclone_major < 0) {
+		printk(KERN_ERR "Unable to register block device
(%d)\n",
+						cyclone_major);
+		return -EBUSY;
+	}
+
+	/*
+	 * Register our PCI operations.
+	 */
+	return pci_register_driver(&cyclone_pci_driver);
+}
+
+/**
+ * Module de-initialization function.
+ *
+ * Called once when the module is unloaded. This function deallocates
+ * the major block device number allocated by cyclone_init() and
+ * unregisters the PCI layer of the driver.
+ *
+ * @return N/A
+ */
+static void __exit cyclone_exit(void)
+{
+	/*
+	 * Release the allocated major block device number.
+	 */
+	unregister_blkdev(cyclone_major, "mtipx2xx");
+
+	/*
+	 * Unregister the PCI driver.
+	 */
+	pci_unregister_driver(&cyclone_pci_driver);
+}
+
+MODULE_AUTHOR("Integrated Device Technology, Inc, Micron Technology,
Inc");
+MODULE_DESCRIPTION("Micron RealSSD PCIe Block Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(cyclone_init);
+module_exit(cyclone_exit);
diff -uNr a/drivers/block/mtipx2xx/mtipx2xx.h
b/drivers/block/mtipx2xx/mtipx2xx.h
--- a/drivers/block/mtipx2xx/mtipx2xx.h	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/mtipx2xx.h	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,806 @@
+/**********************************************************************
*******
+ *
+ * mtipx2xx.h - General header file for the Cyclone SSD Block Driver
+ *   Copyright (C) 2009  Integrated Device Technology, Inc.
+ *
+ *  Changes from IDT 1.0.1 are copyright (C) 2010 Micron Technology,
Inc.
+ *
+ *  This file is part of the Cyclone SSD Block Driver, it is free
software:
+ *  you can redistribute it and/or modify it under the terms of the GNU
+ *  General Public License as published by the Free Software
Foundation;
+ *  either version 2 of the License, or (at your option) any later
version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *  if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street,
+ *  Fifth Floor, Boston,
+ *  MA 02110-1301,
+ *  USA.
+ *
+
************************************************************************
****/
+#ifndef __MTIPX2XX_H__
+#define __MTIPX2XX_H__
+/**
+ * @file
+ */
+#include <linux/spinlock.h>
+#include <linux/rwsem.h>
+#include <linux/ata.h>
+#include <linux/interrupt.h>
+#include <linux/atomic.h>
+#include <linux/genhd.h>
+#include <linux/version.h>
+
+#ifndef WIN_SMART
+#define WIN_SMART       0xB0
+#endif
+
+/**
+ * Defined for enabling surprise removal handling
+ */
+#define SRSI_IMPLEMENATAION  1
+
+/**
+ * offset of subsystem Device ID in pci confoguration space
+ */
+#define PCI_SUBSYSTEM_DEVICEID 0x2E
+
+/* offset of Device Control register in PCIe extended capabilites space
*/
+#define PCIE_CONFIG_EXT_DEVICE_CONTROL_OFFSET  0x48
+
+#define MAX_RETRIES	5
+/**
+ * Defined if the driver should timeout commands that take
+ * too long to execute.
+ */
+#define COMMAND_TIMEOUT
+/**
+ * If COMMAND_TIMEOUT is defined, this is the timeout value in ms.
+ */
+#define NCQ_COMMAND_TIMEOUT_MS       5000
+#define IOCTL_COMMAND_TIMEOUT_MS     5000
+#define INTERNAL_COMMAND_TIMEOUT_MS  5000
+
+/* check for timeouts every 500ms.*/
+#define TIMEOUT_CHECK_PERIOD 500
+
+/**
+ * How should the driver react when an error occurs?
+ * Set each of these to 1 (enabled) or 0 (disabled)
+ */
+#define ISSUE_COMRESET_ON_TIMEOUT 1
+#define ISSUE_COMRESET_ON_TFE 1
+#define REISSUE_NCQ_COMMANDS_ON_ERR 1
+#define REISSUE_INT_COMMANDS_ON_ERR 0
+#define NULL_BIO_FIX 1
+/**
+ * Use a tasklet for bottom half IRQ processing.
+ *
+ * Set to 1 to use a tasklet for bottom half IRQ processing.
+ */
+#define USE_TASKLET	1
+/**
+ * Macro to extract the tag bit number from a tag value.
+ */
+#define TAG_BIT(tag)	(tag & 0x1f)
+/**
+ * Macro to extract the tag index from a tag value. The index
+ * is used to access the correct SActive/Command Issue register based
+ * on the tag value.
+ */
+#define TAG_INDEX(tag)	(tag >> 5)
+/**
+ * Maximum number of scatter gather entries
+ * a single command may have.
+ */
+#define MAX_SG				128
+/**
+ * Maximum number of slot groups (Command Issue & SActive registers)
+ * NOTE: This is the driver maximum; check dd->slot_groups for actual
value.
+ */
+#define MAX_SLOT_GROUPS			8
+/**
+ * Internal command tag.
+ */
+#define TAG_INTERNAL	0
+/**
+ * Micron Vendor ID
+ */
+#define PCI_VENDOR_ID_MICRON    0x1344
+/**
+ * Micron FPGA SSD device ID
+ */
+#define CYCLONE_FPGA_DEVICE_ID	0x5150
+/**
+ * Driver name string.
+ */
+#define DRV_NAME	"Micron RealSSD PCIe Block Driver"
+/**
+ * Driver version string.
+ */
+#define DRV_VERSION	"1.2.6b"
+/**
+ * Maximum number of minor device numbers per device.
+ */
+#define MAX_MINORS				16
+/**
+ * Maximum number of supported command slots.
+ */
+#define MAX_COMMAND_SLOTS	(MAX_SLOT_GROUPS * 32)
+/**
+ * Per-tag bitfield size in longs.
+ * Linux bit manipulation functions (i.e. test_and_set_bit,
find_next_zero_bit)
+ * manipulate memory in longs, so we try to make the math work.
+ * take the slot groups and find the number of longs, rounding up.
+ * Careful! i386 and x86_64 use different size longs!
+ */
+#define U32_PER_LONG (sizeof(long) / sizeof(u32))
+#define SLOTBITS_IN_LONGS
((MAX_SLOT_GROUPS+(U32_PER_LONG-1))/U32_PER_LONG)
+/**
+ * BAR number used to access the AHCI HBA registers.
+ */
+#define MTIPX2XX_ABAR				5
+/*
+ * Forced Unit Access Bit
+ */
+#define FUA_BIT		0x80
+
+/**
+ * Register Frame Information Structure (FIS), host to device.
+ */
+
+ /**
+ * Macro value specfies the success and failure
+ *
+ */
+#define SUCCESS   0
+#define FAILURE  -1
+
+struct HOST_TO_DEV_FIS {
+	/**
+	 * FIS type.
+	 * - 27h Register FIS, host to device.
+	 * - 34h Register FIS, device to host.
+	 * - 39h DMA Activate FIS, device to host.
+	 * - 41h DMA Setup FIS, bi-directional.
+	 * - 46h Data FIS, bi-directional.
+	 * - 58h BIST Activate FIS, bi-directional.
+	 * - 5Fh PIO Setup FIS, device to host.
+	 * - A1h Set Device Bits FIS, device to host.
+	 */
+	unsigned char type;
+	unsigned char opts;
+	unsigned char command;
+	unsigned char features;
+
+	union {
+		unsigned char LBALow;
+		unsigned char sector;
+	};
+	union {
+		unsigned char LBAMid;
+		unsigned char cylLow;
+	};
+	union {
+		unsigned char LBAHi;
+		unsigned char cylHi;
+	};
+	union {
+		unsigned char device;
+		unsigned char head;
+	};
+
+	union {
+		unsigned char LBALowEx;
+		unsigned char sectorEx;
+	};
+	union {
+		unsigned char LBAMidEx;
+		unsigned char cylLowEx;
+	};
+	union {
+		unsigned char LBAHiEx;
+		unsigned char cylHiEx;
+	};
+	unsigned char featuresEx;
+
+	unsigned char sectCount;
+	unsigned char secCountEx;
+	unsigned char res2;
+	unsigned char control;
+
+	unsigned int res3;
+};
+
+/**
+ * Command header structure.
+ */
+struct COMMAND_HDR {
+	/**
+	 * Command options.
+	 * - Bits 31:16 Number of PRD entries.
+	 * - Bits 15:8 Unused in this implementation.
+	 * - Bit 7 Prefetch bit, informs the drive to prefetch PRD
entries.
+	 * - Bit 6 Write bit, should be set when writing data to the
device.
+	 * - Bit 5 Unused in this implementation.
+	 * - Bits 4:0 Length of the command FIS in DWords (DWord = 4
bytes).
+	 */
+	unsigned int opts;
+	/**
+	 * This field is unsed when using NCQ.
+	 */
+	union {
+		unsigned int byteCount;
+		unsigned int status;
+	};
+	/**
+	 * Lower 32 bits of the command table address associated with
this header.
+	 * The command table addresses must be 128 byte aligned.
+	 */
+	unsigned int ctba;
+	/**
+	 * If 64 bit addressing is used this field is the upper 32 bits
+	 * of the command table address associated with this command.
+	 */
+	unsigned int ctbau;
+	/**
+	 * Reserved and unused.
+	 */
+	unsigned int res[4];
+};
+
+/**
+ * Command scatter gather structure (PRD).
+ */
+struct COMMAND_SG {
+	/**
+	 * Low 32 bits of the data buffer address. For Cyclone this
+	 * address must be 8 byte aligned signified by bits 2:0 being
+	 * set to 0.
+	 */
+	unsigned int dba;
+	/**
+	 * When 64 bit addressing is used this field is the upper
+	 * 32 bits of the data buffer address.
+	 */
+	unsigned int dbaUpper;
+	/**
+	 * Unused.
+	 */
+	unsigned int reserved;
+	/**
+	 * Bit 31: interrupt when this data block has been transferred.
+	 * Bits 30..22: reserved
+	 * Bits 21..0: byte count (minus 1).  For Cyclone the byte count
must be
+	 * 8 byte aligned signified by bits 2:0 being set to 1.
+	 */
+	unsigned int info;
+
+};
+struct port;
+/*struct port;*/
+
+/**
+ * Structure used to describe an AHCI command.
+ */
+struct COMMAND {
+	/**
+	 * Pointer to the command headers in virtual kernel address
space.
+	 */
+	struct COMMAND_HDR *commandHeader;
+	/**
+	 * Pointer to the command headers in physical address space.
+	 */
+	dma_addr_t commandHeaderDMA;
+	/**
+	 * Pointer to the command tables in virtual kernel address
space.
+	 */
+	void *command;
+	/**
+	 * Pointer to the command tables in physical address space.
+	 */
+	dma_addr_t commandDMA;
+	/**
+	 * Completion data passed to completionFunc() upon completion
+	 * of a command.
+	 */
+	void *completionData;
+	/**
+	 * Completion function called by the ISR upon completion of
+	 * a command.
+	 */
+	void (*completionFunc)(struct port *port,
+				int tag,
+				void *data,
+				int status);
+	/**
+	 * Additional callback function that may be called by
+	 * completionFunc().
+	 */
+	void (*asyncCallback)(void *data, int status);
+	/**
+	 * Additional callback data that should be passed to
+	 * asyncCallback().
+	 */
+	void *asyncData;
+	/**
+	 * Number of scatter list entries used by this command.
+	 */
+	int scatterEnts;
+	/**
+	 * Scatter list entries for this command.
+	 */
+	struct scatterlist sg[MAX_SG];
+	/**
+	 * The nuCOMMANDmber of retries left for this command.
+	 */
+	int retries;
+#ifdef COMMAND_TIMEOUT
+	/**
+	 * The time, in jiffies, at which this command should have
completed.
+	 */
+	unsigned long compTime;
+#endif
+	/**
+	 * A bit to declare that this command has been sent to the
drive.
+	 */
+	atomic_t active;
+};
+
+
+/**
+ * Structure usCOMMAND_SGed to describe an AHCI port.
+ */
+struct port {
+	/**
+	 * Pointer back to the driver data for this port.
+	 */
+	struct driver_data *dd;
+	/**
+	 * Used to determine if the data pointed to by the
+	 * identify field is valid.
+	 */
+	int identifyValid;
+	/**
+	 * Base address of the memory mapped IO for the port.
+	 */
+	void __iomem *mmio;
+	/**
+	 * Array of pointers to the memory mapped SActive registers.
+	 */
+	void __iomem *SActive[MAX_SLOT_GROUPS];
+	/**
+	 * Array of pointers to the memory mapped Completed registers.
+	 */
+	void __iomem *Completed[MAX_SLOT_GROUPS];
+	/**
+	 * Array of pointers to the memory mapped Command Issue
registers.
+	 */
+	void __iomem *CommandIssue[MAX_SLOT_GROUPS];
+	/**
+	 * Pointer to the beginning of the command header memory as used
+	 * by the driver.
+	 */
+	void *commandList;
+	/**COMMAND_SG
+	 * Pointer to the beginning of the command header memory as used
+	 * by the DMA.
+	 */
+	dma_addr_t commandListDMA;
+	/**
+	 * Pointer to the beginning of the RX FIS memory as used
+	 * by the driver.
+	 */
+	void *rxFIS;
+	/**
+	 * Pointer to the beginning of the RX FIS memory as used
+	 * by the DMA.
+	 */
+	dma_addr_t rxFISDMA;
+	/**COMMAND_SG
+	 * Pointer to the beginning of the command table memory as used
+	 * by the driver.
+	 */
+	void *commandTbl;
+	/**
+	 * Pointer to the beginning of the command table memory as used
+	 * by the DMA.
+	 */
+	dma_addr_t commandTblDMA;
+	/**
+	 * Pointer to the beginning of the identify data memory as used
+	 * by the driver.
+	 */
+	u16 *identify;
+	/**
+	 * Pointer to the beginning of the identify data memory as used
+	 * by the DMA.
+	 */
+	dma_addr_t identifyDMA;
+	/**
+	 * Pointer to the beginning of a sector buffer that is used
+	 * by the driver when issuing internal commands.
+	 */
+	u16 *sectorBuffer;
+	/**
+	 * Pointer to the beginning of a sector buffer that is used
+	 * by the DMA when the driver issues internal commands.
+	 */
+	dma_addr_t sectorBufferDMA;
+	/**
+	 * Bit significant, used to determine if a command slot has
+	 * been allocated. i.e. the slot is in use.  Bits are cleared
+	 * when the command slot and all associated data structures
+	 * are no longer needed.
+	 */
+	unsigned long allocated[SLOTBITS_IN_LONGS];
+	/**
+	 * Array of command slots. Structure includes pointers to the
+	 * command header and command table, and completion function and
data
+	 * pointers.
+	 */
+	struct COMMAND commands[MAX_COMMAND_SLOTS];
+	/**
+	 * Non-zero if an internal command is in progress.
+	 */
+	int internalCommandInProgress;
+#ifdef COMMAND_TIMEOUT
+	/**
+	 * Timer used to complete commands that have been active for too
long.
+	 */
+	struct timer_list	commandTimer;
+#endif
+	/**
+	 * Semaphore used to block threads if there are no
+	 * command slots available.
+	 */
+	struct semaphore commandSlot;
+	/**
+	 * Spinlock for working around command-issue bug.
+	 */
+	spinlock_t cmdIssueLock;
+};
+
+/**
+ * Structure used to hold information relating to performance
+ * statistics.
+ */
+struct STATS {
+	/**
+	 * Statistics timer.
+	 */
+	struct timer_list	timer;
+	/**
+	 * Statistics, incremented each time the SSD ISR is executed.
+	 * Cleared to zero each second when the value is copied to
currentInts.
+	 */
+	atomic_t interrupts;
+	/**
+	 * Statistics, incremented each time a read is issued to the
device.
+	 * Cleared to zero each second when the value is copied to
+	 * currentReads.
+	 */
+	atomic_t reads;
+	/**
+	 * Statistics, incremented each time a write is issued to the
device.
+	 * Cleared to zero each second when the value is copied to
+	 * currentWrites.
+	 */
+	atomic_t writes;
+	/**
+	 * The current number of interrupts per second.
+	 */
+	atomic_t currentInts;
+	/**
+	 * The current number of reads per second.
+	 */
+	atomic_t currentReads;
+	/**
+	 * The current number of writes per second.
+	 */
+	atomic_t currentWrites;
+	/**
+	 * The current number of IOPS.
+	 */
+	atomic_t currentIOPS;
+	/**
+	 * Minimum response time.
+	 */
+	atomic_t minRespTime;
+	/**
+	 * Maximum response time.
+	 */
+	atomic_t maxRespTime;
+	/**
+	 * Average response time.
+	 */
+	atomic_t avgRespTime;
+	/**
+	 * Average response time.
+	 */
+	atomic_t currentAvgRespTime;
+};
+
+
+/**
+ * Driver private data structure.
+ *
+ * One structure is allocated per probed device.
+ */
+struct  driver_data {
+	/**
+	 * Base address of the HBA registers.
+	 */
+	void __iomem *mmio;
+	/**
+	 * Major device number.
+	 */
+	int	major;
+	/**
+	 * Instance number for this device. First device probed is 0,
second
+	 * is 1, etc.
+	 */
+	int instance;
+	/**
+	 * Protocol ops array index.
+	 */
+	int protocol;
+	/**
+	 * Pointer to our gendisk structure.
+	 */
+	struct gendisk *disk;
+	/**
+	 * Pointer to the PCI device structure.
+	 */
+	struct pci_dev *pdev;
+	/**
+	 * Our request queue.
+	 */
+	struct request_queue	*queue;
+	/**
+	 * Semaphore used to lock out read/write commands during the
+	 * execution of an internal command.
+	 */
+	struct rw_semaphore internalSem;
+	/**
+	 * Pointer to the port data structure.
+	 */
+	struct port  *port;
+#ifdef USE_TASKLET
+	/**
+	 * Tasklet used to process the bottom half of
+	 * the ISR.
+	 */
+	struct tasklet_struct tasklet;
+#endif
+	/**
+	 * Performance statistics.
+	 */
+	struct STATS statistics;
+	/**
+	 * Used to inject random read/write errors.
+	 * - Bit 0 - Insert random read errors.
+	 * - Bit 1 - Insert random write errors.
+	 */
+	int makeItFail;
+	/**
+	 * Tag which caused the simulated failure.
+	 */
+	int makeItFailTag;
+	/**
+	 * Used to store the original start sector value from the FIS
+	 * when an error is injected.
+	 */
+	sector_t makeItFailStart;
+	/**
+	 * Spinlock used to access the make_it_fail counters below.
+	 */
+	spinlock_t	makeItFailLock;
+	/**
+	 * Initialized with a random value when bit 0 is set in
makeItFail.
+	 * The value is decremented each time there is a read, when the
count
+	 * is zero an error is injected into the read command and the
counter
+	 * is written with a new random value.
+	 */
+	unsigned  randomReadCount;
+	/**
+	 * Initialized with a random value when bit 1 is set in
makeItFail.
+	 * The value is decremented each time there is a write, when the
count
+	 * is zero an error is injected into the write command and the
counter
+	 * is written with a new random value.
+	 */
+	unsigned  randomWriteCount;
+	/**
+	 * Store a magic value declaring the product type.
+	 */
+	unsigned product_type;
+	/**
+	 * Store the number of slot groups the product supports.
+	 */
+	unsigned slot_groups;
+	/**
+	 * Atomic varaiable for SRSI
+	 */
+	atomic_t drv_cleanup_done;
+	/*
+	 *Index to determine the disk name
+	 */
+	unsigned long index;
+};
+
+/**
+ * Protocol layer exported functions.
+ *
+ * This structure contains functions that are required by
+ * the block layer.
+ */
+struct PROTOCOL_FUNCS {
+	/**
+	 * Protocol layer initialization function. Called by the
+	 * block layer initialization function (blockInitialize())
+	 * to initialize the protocol layer.
+	 */
+	int (*init)(struct driver_data *dd);
+	/**
+	 * Protocol layer exit function. Called by the block layer
+	 * exit function (blockRemove()) to deinitialize the protocol
+	 * layer.
+	 */
+	int (*exit)(struct driver_data *dd);
+#ifdef CONFIG_PM
+	/**
+	 * Protocol layer suspend function. Called by the block layer
suspend
+	 * routine (blockSuspend()) to suspend the device
+	 */
+	int (*suspend)(struct driver_data *dd);
+	/**
+	 * Protocol layer resume function. Called by the block layer
resume
+	 * routine (blockResume()) to resume the device
+	 */
+	int (*resume)(struct driver_data *dd);
+#endif
+	/**
+	 * Protocol layer shutdown function. Called by the kernel when
+	 * the machine is being shutdown. This function should sync the
+	 * hardware. For Cyclone, this means issuing a Standby Immediate
+	 * command. This function is optional.
+	 */
+	int (*shutdown)(struct driver_data *dd);
+	/**
+	 * Function that returns the actual hardware block size. For the
Cyclone
+	 * SSD this function should return 4096. The information
returned from
+	 * this function is used to be block layer to inform the kernel
of the
+	 * hardware block size. The kernel will then only issue block
read/write
+	 * commands that are a multiples of that size.
+	 */
+	int (*hwBlkSize)(void);
+	/**
+	 * Function to obtain and return the size of the device in 512
+	 * byte sectors.
+	 */
+	sector_t (*getCapacity)(struct driver_data *dd);
+	/**
+	 * Function called by the block later to obtain a free command
+	 * slot and to return a pointer to the scatter list associated
+	 * with it.
+	 */
+	struct scatterlist *(*getScatterList)(struct driver_data *dd,
int *tag);
+	/**
+	 * Called by the Block Layer to issue a read to the hardware.
+	 */
+	int (*read)(struct driver_data *dd,
+			sector_t start,
+			int nsect,
+			int nents,
+			int tag,
+			void *callback,
+			void *data,
+			int barrier);
+	/**
+	 * Called by the Block Layer to issue a write to the hardware.
+	 */
+	int (*write)(struct driver_data *dd,
+			sector_t start,
+			int nsect,
+			int nents,
+			int tag,
+			void *callback,
+			void *data,
+			int barrier);
+	/**
+	 * Called by the Block Layer to handle device specific IOCTL
commands.
+	 */
+	int (*ioctl)(struct driver_data *dd,
+			unsigned int cmd,
+			unsigned long arg);
+	/**
+	 * Function to initialize sysfs attributes for the protocol
layer. This
+	 * function is called by the block layer after the block device
has
+	 * been added to the system by a call to add_disk(). This field
is
+	 * optional.
+	 */
+	int (*sysfsInit)(struct driver_data *dd, struct kobject *kobj);
+	/**
+	 * Function to deinitialize sysfs attributes for the protocol
layer. This
+	 * function is called by the block layer before the block device
is
+	 * removed from the system by a call to del_gendisk(). This
function
+	 * is optional.
+	 */
+	int (*sysfsExit)(struct driver_data *dd, struct kobject *kobj);
+};
+
+extern int cyclone_major;
+extern bool resumeflag;
+extern int block_initialize(struct driver_data *dd);
+extern int block_remove(struct driver_data *dd);
+extern int block_shutdown(struct driver_data *dd);
+extern int block_suspend(struct driver_data *dd);
+extern int block_resume(struct driver_data *dd);
+extern int ahci_init(struct driver_data *dd);
+extern int ahci_exit(struct driver_data *dd);
+extern int ahci_shutdown(struct driver_data *dd);
+extern int ahci_hard_blksize(void);
+extern sector_t ahci_get_capacity(struct driver_data *dd);
+extern struct scatterlist *ahci_get_scatterlist(
+				struct driver_data *dd,
+				int *tag);
+extern int ahci_read(struct driver_data *dd,
+			sector_t start,
+			int nsect,
+			int nents,
+			int tag,
+			void *callback,
+			void *data,
+			int barrier);
+extern int ahci_write(struct driver_data *dd,
+			sector_t start,
+			int nsect,
+			int nents,
+			int tag,
+			void *callback,
+			void *data,
+			int barrier);
+extern int ahci_ioctl(struct driver_data *dd,
+			unsigned int cmd,
+			unsigned long arg);
+extern int ahci_sysfs_init(struct driver_data *dd, struct kobject
*kobj);
+extern int ahci_sysfs_exit(struct driver_data *dd, struct kobject
*kobj);
+extern int ahci_resume(struct driver_data *dd);
+extern int ahci_suspend(struct driver_data *dd);
+
+
+extern struct pci_driver cyclone_pci_driver;
+void command_cleanup(struct driver_data *dd);
+int check_for_surprise_removal(struct pci_dev *pdev);
+
+void restart_port(struct port *);
+/**
+ * Swap halves of 16-bit words in place
+ *
+ * Swap halves of 16-bit words if needed to convert from
+ * little-endian byte order to native cpu byte order, or
+ * vice-versa.
+ *
+ * @param buf Buffer to swap
+ * @param buf_words Number of 16-bit words in buffer.
+ *
+ * @return N/A
+ */
+static inline void swap_buf_le16(u16 *buf, unsigned int buf_words)
+{
+#ifdef __BIG_ENDIAN
+	unsigned int i;
+
+	for (i = 0; i < buf_words; i++)
+		buf[i] = le16_to_cpu(buf[i]);
+#endif /* __BIG_ENDIAN */
+}
+
+
+#endif
diff -uNr a/drivers/block/mtipx2xx/pci.c b/drivers/block/mtipx2xx/pci.c
--- a/drivers/block/mtipx2xx/pci.c	1969-12-31 17:00:00.000000000
-0700
+++ b/drivers/block/mtipx2xx/pci.c	2011-05-03 12:57:34.000000000
-0600
@@ -0,0 +1,411 @@
+/**********************************************************************
*******
+ *
+ * pci.c - Handles the PCI layer of the Cyclone SSD Block Driver
+ *   Copyright (C) 2009  Integrated Device Technology, Inc.
+ *
+ *  Changes from IDT 1.0.1 are copyright (C) 2010 Micron Technology,
Inc.
+ *
+ *  This file is part of the Cyclone SSD Block Driver, it is free
software:
+ *  you can redistribute it and/or modify it under the terms of the GNU
+ *  General Public License as published by the Free Software
Foundation;
+ *  either version 2 of the License, or (at your option) any later
version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program;
+ *  if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street,
+ *  Fifth Floor, Boston,
+ *  MA 02110-1301,
+ *  USA.
+ *
+
************************************************************************
****/
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include "mtipx2xx.h"
+/**
+ * @file
+ * The PCI layer contains the pci_device_id structure which is used to
+ * associate a hardware vendor/device ID with the device driver. An
example of
+ * a pci_device_id structure for Cyclone is shown below.
+ * @verbatim
+static const struct pci_device_id pci_tbl[] = {
+	{ PCI_VDEVICE(MICRON, CYCLONE_FPGA_DEVICE_ID), 0},
+	{}
+};
+@endverbatim
+ * Each entry in the pci_device_id table consists of a vendor/device
ID, the
+ * macro PCI_VDEVICE() is used to correctly populate the vendor/device
entries,
+ * and an integer value that is used by the block layer as an
+ * index into the PROTOCOL_FUNCS table which is described in the Block
Layer
+ * section.
+ * The Linux macro MODULE_DEVICE_TABLE is used to create the relevant
linker
+ * sections so that the depmod command may be used to update the module
+ * dependency files.
+ *
+ * Another structure declared in the PCI layer is the
cyclone_pci_driver
+ * structure. This is the structure that describes the PCI driver entry
points.
+ * A pointer to this structure is passed into the pci_register_driver()
+ * function by the module layer to register the PCI driver.
+ * The following PCI driver methods will be supported by the PCI layer.
+ *
+ * - probe() - When the module is loaded this function is called for
each device
+ * that matches the vendor/device ID's specified in the pci_device_id
table as
+ * they are discovered.
+ * The probe() function performs the following operations.
+ *  - Allocate memory for the drivers private data
+ *  cyclone_major = register_blkdev(0, "mtipx2xx")a structures.
+ *  -	Enables the PCI device.
+ *  -	Iomap the devices BARs.
+ * cyclone_major = register_blkdev(0, "mtipx2xx") -Set the DMA mask for
the
+ * device.
+ *  -	Enable PCI device master operations.
+ *  -	Call the block layer initialization function
(blockInitialize()).
+ * - remove() - When the module is unloaded this function is called for
each
+ * device that matches the vendor/device ID's specified in the
pci_device_id
+ * table.
+ * The remove() function must undo the operations of the probe()
function.
+ *  -	Call the block layer remove function (blockRemove()).
+ *  -	Free the memory allocated for the driver private data
structures.
+ *  -	Unmap the devices BARs.
+ * - shutdown() - This function is called by the kernel PCI
infrastructure
+ * just before the system is halted during a shutdown. This function
should
+ * call into the block layer to sync the device before the power is
switched
+ * off.
+ *
+ * The PCI layer will also handle the suspend and resume operations
which are
+ * issued when the system enters and exits low power states. The
initial
+ * version of the driver will not support these methods.
+ */
+
+/**
+ * Device instance number, incremented each time a device is probed.
+ */
+static int instance;
+
+/**
+ * Called for each supported PCI device detected.
+ *
+ * This function allocates the private data structure, enables the
+ * PCI device and then calls the block layer initialization function.
+ *
+ * @return 0 on success else an error code.
+ */
+static int pci_probe(struct pci_dev *pdev, const struct pci_device_id
*ent)
+{
+	struct driver_data	*dd = NULL;
+	int rv = 0;
+	unsigned short pcie_dev_ctrl, pcie_sub_deviceid;
+	/*
+	 * Allocate memory for this devices private data.
+	 */
+	dd = vmalloc(sizeof(struct driver_data));
+	if (dd == NULL) {
+		printk(KERN_ERR "Unable to allocate memory for driver
data\n");
+		return -ENOMEM;
+	}
+	memset(dd, 0, sizeof(struct driver_data));
+	/**
+	* Set the atomic variable as 1 in case of SRSI
+	*/
+
+	atomic_set(&dd->drv_cleanup_done, true);
+
+	/*
+	 * Attach the private data to this PCI device.
+	 */
+	pci_set_drvdata(pdev, dd);
+
+	/*
+	 * Enable the PCI device.
+	 */
+	rv = pcim_enable_device(pdev);
+	if (rv < 0) {
+		printk(KERN_ERR "Unable to enable device\n");
+		goto iomap_err;
+	}
+
+	/*
+	 * Read the subsystem device id from the pci configuration
+	 * space to identify the 2.5" drive
+	 */
+	 pci_read_config_word(pdev, PCI_SUBSYSTEM_DEVICEID ,
+
&pcie_sub_deviceid);
+	 if (pcie_sub_deviceid & 0x08) {
+		/*
+		 *  workaround for max TLP payload issue
+		 * after surprise insertion
+		 */
+		pci_read_config_word(pdev,
+				PCIE_CONFIG_EXT_DEVICE_CONTROL_OFFSET,
+				&pcie_dev_ctrl);
+		if (!(pcie_dev_ctrl & 0x20)) {
+			printk(KERN_INFO "mtipx2xx: setting"
+				"max TLP payload size to 256 bytes\n");
+			pcie_dev_ctrl |= 0x20;
+			pci_write_config_word(pdev,
+				PCIE_CONFIG_EXT_DEVICE_CONTROL_OFFSET,
+				pcie_dev_ctrl);
+		}
+	}
+	/*
+	 * Map BAR5 to memory.
+	 */
+	rv = pcim_iomap_regions(pdev, 1 << MTIPX2XX_ABAR, DRV_NAME);
+	if (rv  < 0) {
+		printk(KERN_ERR "Unable to map regions\n");
+		goto iomap_err;
+	}
+
+	if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(64))) {
+		rv = pci_set_consistent_dma_mask(pdev,
DMA_BIT_MASK(64));
+
+		if (rv) {
+			rv = pci_set_consistent_dma_mask(pdev,
+						DMA_BIT_MASK(32));
+			if (rv) {
+				dev_printk(KERN_ERR, &pdev->dev,
+					"64-bit DMA enable failed\n");
+				return rv;
+			}
+		}
+	}
+
+	/*
+	 * Enable PCI device master operations.
+	 */
+	pci_set_master(pdev);
+
+	/*
+	 * Enable MSI for this device.
+	 */
+	if (pci_enable_msi(pdev))
+		printk(KERN_WARNING "Unable to enable MSI
interrupt.\n");
+
+
+	/*
+	 * Copy the info we may need later into the private data
structure.
+	 */
+	dd->major	= cyclone_major;
+	dd->protocol	= ent->driver_data;
+	dd->instance	= instance;
+	dd->pdev	= pdev;
+
+	/*
+	 * Initialize the block layer.
+	 */
+	rv = block_initialize(dd);
+	if (rv < 0) {
+		printk(KERN_ERR "Unable to initialize block layer\n");
+		goto block_initialize_err;
+	}
+
+	/*
+	 * Increment the instance count so that each device has a unique
+	 * instance number.
+	 */
+	instance++;
+
+	goto done;
+
+block_initialize_err:
+
+	pcim_iounmap_regions(pdev, 1 << MTIPX2XX_ABAR);
+iomap_err:
+	vfree(dd);
+	pci_set_drvdata(pdev, NULL);
+done:
+	/**
+	* Set the atomic variable as 0 in case of SRSI
+	*/
+
+	atomic_set(&dd->drv_cleanup_done, false);
+
+	return rv;
+}
+
+/**
+ * Called for each probed device when the device is removed or the
+ * driver is unloaded.
+ *
+ * @return N/A
+ */
+static void pci_remove(struct pci_dev *pdev)
+{
+	struct driver_data	*dd = pci_get_drvdata(pdev);
+	int Counter = 0;
+
+	/*
+	* Check for the device presence
+	*/
+	if (check_for_surprise_removal(pdev)) {
+		while (atomic_read(&dd->drv_cleanup_done) == false) {
+			Counter++;
+			msleep(20);
+			if (Counter == 10) {
+				/*
+				* Cleanup the outstanding the command
+				*/
+				command_cleanup(dd);
+				break;
+			}
+		}
+	}
+       /*
+	* Set the atomic variable as 1 in case of SRSI
+	*/
+	atomic_set(&dd->drv_cleanup_done, true);
+
+
+	/*
+	 * Clean up the block layer.
+	 */
+	block_remove(dd);
+
+	/*
+	 * Reverse the effects of pci_enable_msi().
+	 */
+	pci_disable_msi(pdev);
+
+	/*
+	 * Free the memory allocated for the private data structure.
+	 */
+	vfree(dd);
+
+	/*
+	 * Unmap the memory regions allocated to the BARs.
+	 */
+	pcim_iounmap_regions(pdev, 1 << MTIPX2XX_ABAR);
+}
+
+
+static int pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+		int rv = 0;
+		struct driver_data	 *dd ;
+
+		resumeflag = 1;
+		dd = pci_get_drvdata(pdev);
+		if (dd == NULL)
+			printk(KERN_ERR "Driver private datastructure is
NULL\n");
+
+
+		/* Disable PORTs and Interrupts.
+		 * It sends standbyImmediate command to controller.*/
+		rv = block_suspend(dd);
+
+		if (rv < 0) {
+			printk(KERN_ERR "Failed to suspend AHCI
controller\n");
+			return rv;
+		}
+
+		/* Save the pci config space to pdev structure &
+		 * disable the device */
+		pci_save_state(pdev);
+		pci_disable_device(pdev);
+
+		/* Move to Low power state*/
+		pci_set_power_state(pdev, PCI_D3hot);
+
+		return rv;
+}
+
+static int pci_resume(struct pci_dev *pdev)
+{
+		int rv = 0;
+		struct driver_data	 *dd;
+
+		dd = pci_get_drvdata(pdev);
+		if (dd == NULL)
+			printk(KERN_ERR "Driver private datastructure is
NULL\n");
+
+
+		/* Move the device to active State*/
+		pci_set_power_state(pdev, PCI_D0);
+
+		/* Restore PCI configuration space*/
+		pci_restore_state(pdev);
+
+		/* Enable the PCI device*/
+		rv = pcim_enable_device(pdev);
+		if (rv < 0) {
+			printk(KERN_ERR "Failed to enable P320 card
during resume\n");
+			goto err;
+		}
+		pci_set_master(pdev);
+
+		/*
+		 * It calls hbaReset , initPort,startPort function
+		 * and enable the interrupt
+		 */
+		rv = block_resume(dd);
+		if (rv < 0) {
+			printk(KERN_ERR "Unable to initialize port\n");
+			goto err;
+		}
+
+err:
+		resumeflag = 0;
+
+		return rv;
+}
+
+static void pci_shutdown(struct pci_dev *pdev)
+{
+	struct driver_data	*dd = pci_get_drvdata(pdev);
+	block_shutdown(dd);
+}
+
+/**
+ * This function check_for_surprise_removal is called
+ * while card is removed from the system and it will
+ * read the vendor id from the configration space
+ *
+ *
+ * @param pdev Pointer to the pci_dev structure.
+ *
+ *
+ * @return 1 if device removed, else 0
+ */
+
+int check_for_surprise_removal(struct pci_dev *pdev)
+{
+	u16 vendor_id = 0;
+
+       /*
+	* Read the vendorID from the configuration space
+	*/
+	pci_read_config_word(pdev, 0x00, &vendor_id);
+	if (vendor_id == 0xFFFF)
+		return 1; /* device removed */
+
+	return 0; /* device present */
+}
+
+/**
+ * Table of devices supported by this driver.
+ */
+static DEFINE_PCI_DEVICE_TABLE(pci_tbl) = {
+	{  PCI_DEVICE(PCI_VENDOR_ID_MICRON, CYCLONE_FPGA_DEVICE_ID) },
+
+	{0}	/* terminate list */
+};
+
+/**
+* Structure that describes the PCI driver functions.
+*/
+struct pci_driver cyclone_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= pci_tbl,
+	.probe			= pci_probe,
+	.remove			= pci_remove,
+	.suspend		= pci_suspend,
+	.resume			= pci_resume,
+	.shutdown		= pci_shutdown,
+};
+
+MODULE_DEVICE_TABLE(pci, pci_tbl);
