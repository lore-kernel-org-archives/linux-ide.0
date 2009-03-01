From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: Can I set 8KB hardware sector size in blk_queue_hardsect_size() ?
Date: Sun, 1 Mar 2009 22:54:46 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE3130249664B2@pdsmsx503.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24755 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbZCAOxv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 09:53:51 -0500
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>


I'm developing a standalone nand flash driver. The driver use blk_queue_hardsect_size() to set hardware sector size. Usually I set it to the actuall nand flash page size. When I use a 4KB page nand part, it works well. But when I tried a new type nand part (which has 8KB page), it reports the BUG as below (the kernel is linux 2.6.29 rc3):
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
[    8.092337] In GLOB_SBD_init: Num blocks=8192, pagesperblock=128, pagedatasize=8192, ECCBytesPerSector=52, SizeofGlobalMem=7537298
        ... ...
[   10.722900] drivers/block/spectra/ffsport.c, Line 679, Function: SBD_setup_device
        ... ...
[   10.762575] Capacity sects: 14983168
[   10.772499] drivers/block/spectra/ffsport.c, Line 741
[   10.785306] drivers/block/spectra/ffsport.c, Line 515, Function: GLOB_SBD_open
[   10.804700]  nda:<1>BUG: unable to handle kernel NULL pointer dereference at (null)
[   10.826715] IP: [<c0187ce7>] create_empty_buffers+0x16/0x88
[   10.839146] *pde = 00000000
[   10.849146] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
[   10.849146] last sysfs file:
[   10.849146]
[   10.849146] Pid: 1, comm: swapper Not tainted (2.6.29-rc3-developer #60)
[   10.849146] EIP: 0060:[<c0187ce7>] EFLAGS: 00010292 CPU: 0
[   10.849146] EIP is at create_empty_buffers+0x16/0x88
[   10.849146] EAX: 00000000 EBX: c16ee65c ECX: 00000001 EDX: 00002000
[   10.849146] ESI: 00000000 EDI: 00000000 EBP: cecc7d30 ESP: cecc7d24
[   10.849146]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   10.849146] Process swapper (pid: 1, ti=cecc6000 task=cecc4020 task.ti=cecc6000)
[   10.849146] Stack:
[   10.849146]  c16ee65c c16ee65c cebc2eb0 cecc7d98 c018a399 c0140734 c018bbca cebc2d74
[   10.849146]  cebc2eb0 cecc7d58 c01408fd 00002000 00000000 cecc7d60 c0140933 cecc7d6c
[   10.849146]  c0467e4d c16ee65c cecc7d88 c014ecb9 00000000 cebc2ec0 c16ee65c c16ee65c
[   10.849146] Call Trace:
[   10.849146]  [<c018a399>] ? block_read_full_page+0x41/0x23c
[   10.849146]  [<c0140734>] ? mark_held_locks+0x53/0x6a
[   10.849146]  [<c018bbca>] ? blkdev_get_block+0x0/0x84
[   10.849146]  [<c01408fd>] ? trace_hardirqs_on_caller+0x111/0x13c
[   10.849146]  [<c0140933>] ? trace_hardirqs_on+0xb/0xd
[   10.849146]  [<c0467e4d>] ? _spin_unlock_irq+0x22/0x26
[   10.849146]  [<c014ecb9>] ? add_to_page_cache_locked+0x82/0x8b
[   10.849146]  [<c018cf38>] ? blkdev_readpage+0xf/0x11
[   10.849146]  [<c014ee23>] ? read_cache_page_async+0x7b/0x101
[   10.849146]  [<c018cf29>] ? blkdev_readpage+0x0/0x11
[   10.849146]  [<c014eeb5>] ? read_cache_page+0xc/0x3f
[   10.849146]  [<c01a2fe1>] ? read_dev_sector+0x24/0x56
[   10.849146]  [<c01a3b46>] ? msdos_partition+0x44/0x4e2
[   10.849146]  [<c0264d60>] ? snprintf+0x15/0x17
[   10.849146]  [<c0465160>] ? printk+0xf/0x11
[   10.849146]  [<c01a396b>] ? rescan_partitions+0x13c/0x297
[   10.849146]  [<c01a3b02>] ? msdos_partition+0x0/0x4e2
[   10.849146]  [<c018ca0a>] ? __blkdev_get+0x21b/0x2bb
[   10.849146]  [<c018cab4>] ? blkdev_get+0xa/0xc
[   10.849146]  [<c01a30d3>] ? register_disk+0xc0/0x114
[   10.849146]  [<c025d244>] ? add_disk+0xaf/0x108
[   10.849146]  [<c025c9f7>] ? exact_match+0x0/0xb
[   10.849146]  [<c025cd4d>] ? exact_lock+0x0/0x11
[   10.849146]  [<c02b675c>] ? SBD_setup_device+0x414/0x450
[   10.849146]  [<c02b7b89>] ? GLOB_SBD_init+0x1e5/0x25c
[   10.849146]  [<c010104a>] ? _stext+0x4a/0x111
[   10.849146]  [<c02b79a4>] ? GLOB_SBD_init+0x0/0x25c
[   10.849146]  [<c014b154>] ? register_irq_proc+0x7f/0x9b
[   10.849146]  [<c014b1c3>] ? init_irq_proc+0x53/0x60
[   10.849146]  [<c05f75d6>] ? kernel_init+0x101/0x152
[   10.849146]  [<c05f74d5>] ? kernel_init+0x0/0x152
[   10.849146]  [<c0103617>] ? kernel_thread_helper+0x7/0x10
[   10.849146] Code: 31 f6 bf 00 10 00 00 eb cf 31 f6 83 c4 0c 89 f0 5b 5e 5f 5d c3 55 89 e5 57 89 cf b9 01 00 00 00 56 53 89 c3 e8 44 ff ff ff 89 c6 <09> 38 89 c2 8b 40 04 85 c0 75 f5 89 72 04 8b 43 10 05 84 00 00
[   10.849146] EIP: [<c0187ce7>] create_empty_buffers+0x16/0x88 SS:ESP 0068:cecc7d24
[   11.527298] ---[ end trace 475a62a863f09a96 ]---
[   11.539214] swapper used greatest stack depth: 5840 bytes left
[   11.554193] Kernel panic - not syncing: Attempted to kill init!
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

So, I suspect that whether the block device layer supports 8KB hardware sectors or not ?  Thanks for your time.


Best Regards,
Yunpeng Gao


Below is part of the driver's code. Just for your reference.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#define NUM_DEVICES             1
#define PARTITIONS              4
#define KERNEL_SECTOR_SIZE      512
#define GLOB_SBD_NAME          "nd"
#define GLOB_SBD_IOCTL_FLUSH_CACHE                             (0x7705)

int nand_debug_level;
module_param(nand_debug_level, int, 0644);
MODULE_PARM_DESC(nand_debug_level, "debug level value: 1-3");

MODULE_LICENSE("GPL");

struct spectra_nand_dev {
        struct pci_dev *dev;
        u64 size;
        u16 users;
        spinlock_t qlock;
        void __iomem *ioaddr;  /* Mapped address */
        struct request_queue *queue;
        struct task_struct *thread;
        struct gendisk *gd;
};

static int GLOB_SBD_majornum;

static struct spectra_nand_dev nand_device[NUM_DEVICES];

/* Because the driver will allocate a lot of memory and kmalloc can not */
/* allocat memory more than 4M bytes, here we use static array as */
/* memory pool. This is simple but ugly. It should only be used during */
/* development.*/
static u8 local_mem_pool[1024*1024*16];

static int dev_num;

static struct mutex spectra_lock;

struct spectra_indentfy_dev_tag IdentifyDeviceData;

#define SBD_SECTOR_SIZE         (IdentifyDeviceData.PageDataSize)
#define SBD_BLOCK_SIZE          (IdentifyDeviceData.PageDataSize * IdentifyDeviceData.PagesPerBlock)

u8 *mem_pool_ptr;

#define SECTOR_SIZE_RATIO       (SBD_SECTOR_SIZE/KERNEL_SECTOR_SIZE)

static int force_flush_cache(void)
{
        if (ERR == GLOB_FTL_Flush_Cache()) {
                printk(KERN_ERR "Fail to Flush FTL Cache!\n");
                return -EFAULT;
        }

        return 0;
}

static void SBD_prepare_flush(struct request_queue *q, struct request *rq)
{
        rq->cmd_type = REQ_TYPE_LINUX_BLOCK;
        /* rq->timeout = 5 * HZ; */
        rq->cmd[0] = REQ_LB_OP_FLUSH;
}

/* Transfer a full request. */
static int do_transfer(struct spectra_nand_dev *tr, struct request *req)
{
        u64 addr;
        unsigned long nsect;
        char *buf;

        addr = (u64)(req->sector) * 512;
        nsect = req->current_nr_sectors / SECTOR_SIZE_RATIO;
        buf = req->buffer;

        /* Add a big enough offset to prevent the OS Image from
        *  being accessed or damaged by file system */
        addr += (SBD_BLOCK_SIZE * 50);

        if (req->cmd_type == REQ_TYPE_LINUX_BLOCK &&
                        req->cmd[0] == REQ_LB_OP_FLUSH) {
                if (force_flush_cache()) /* Fail to flush cache */
                        return 0;
                else
                        return 1;
        }

        if (!blk_fs_request(req))
                return 0;

        if (req->sector + req->current_nr_sectors > get_capacity(tr->gd))
                return 0;

        switch (rq_data_dir(req)) {
        case READ:
                for (; nsect > 0; nsect--, addr += SBD_SECTOR_SIZE,
                                        buf += SBD_SECTOR_SIZE)
                        if (GLOB_FTL_Page_Read(buf, addr))
                                return 0;
                return 1;

        case WRITE:
                for (; nsect > 0; nsect--, addr += SBD_SECTOR_SIZE,
                                        buf += SBD_SECTOR_SIZE)
                        if (GLOB_FTL_Page_Write(buf, addr))
                                return 0;
                return 1;

        default:
                printk(KERN_NOTICE "Unknown request %u\n", rq_data_dir(req));
                return 0;
        }
}

static int spectra_trans_thread(void *arg)
{
        struct spectra_nand_dev *tr = arg;
        struct request_queue *rq = tr->queue;

        current->flags |= PF_MEMALLOC;

        spin_lock_irq(rq->queue_lock);
        while (!kthread_should_stop()) {
                struct request *req;
                int res = 0;

                req = elv_next_request(rq);

                if (!req) {
                        set_current_state(TASK_INTERRUPTIBLE);
                        spin_unlock_irq(rq->queue_lock);
                        schedule();
                        spin_lock_irq(rq->queue_lock);
                        continue;
                }

                spin_unlock_irq(rq->queue_lock);

                mutex_lock(&spectra_lock);
                res = do_transfer(tr, req);
                mutex_unlock(&spectra_lock);

                spin_lock_irq(rq->queue_lock);

                end_request(req, res);
        }
        spin_unlock_irq(rq->queue_lock);

        return 0;
}


/* Request function that "handles clustering". */
static void GLOB_SBD_request(struct request_queue *rq)
{
        struct spectra_nand_dev *pdev = rq->queuedata;
        wake_up_process(pdev->thread);
}


static int GLOB_SBD_open(struct block_device *bdev, fmode_t mode)

{
        nand_dbg_print(NAND_DBG_WARN, "%s, Line %d, Function: %s\n",
                       __FILE__, __LINE__, __func__);
        return 0;
}

static int GLOB_SBD_release(struct gendisk *disk, fmode_t mode)
{
        int ret;

        nand_dbg_print(NAND_DBG_WARN, "%s, Line %d, Function: %s\n",
                       __FILE__, __LINE__, __func__);

        mutex_lock(&spectra_lock);
        ret = force_flush_cache();
        mutex_unlock(&spectra_lock);

        return 0;
}


int GLOB_SBD_ioctl(struct block_device *bdev, fmode_t mode,
                unsigned int cmd, unsigned long arg)
{
        int ret;

        switch (cmd) {
        case GLOB_SBD_IOCTL_FLUSH_CACHE:
                nand_dbg_print(NAND_DBG_DEBUG, "Spectra IOCTL: Cache flush "
                               "being performed\n");
                mutex_lock(&spectra_lock);
                ret = force_flush_cache();
                mutex_unlock(&spectra_lock);
                return ret;
        }

        return -ENOTTY;
}

static struct block_device_operations GLOB_SBD_ops = {
        .owner = THIS_MODULE,
        .open = GLOB_SBD_open,
        .release = GLOB_SBD_release,
        .locked_ioctl = GLOB_SBD_ioctl,
};

static int SBD_setup_device(struct spectra_nand_dev *dev, int which)
{
        int res_blks;

        nand_dbg_print(NAND_DBG_TRACE, "%s, Line %d, Function: %s\n",
                       __FILE__, __LINE__, __func__);

        memset(dev, 0, sizeof(struct spectra_nand_dev));

        dev->size = (u64)IdentifyDeviceData.PageDataSize *
                IdentifyDeviceData.PagesPerBlock *
                (IdentifyDeviceData.wDataBlockNum - 50);

        spin_lock_init(&dev->qlock);

        dev->queue = blk_init_queue(GLOB_SBD_request, &dev->qlock);
        if (dev->queue == NULL) {
                printk(KERN_ERR
                       "Spectra: Request queue could not be initialized."
                        " Aborting\n ");
                goto out_vfree;
        }
        dev->queue->queuedata = dev;

        blk_queue_hardsect_size(dev->queue, SBD_SECTOR_SIZE);
        blk_queue_ordered(dev->queue, QUEUE_ORDERED_DRAIN_FLUSH,
                                                SBD_prepare_flush);

        dev->thread = kthread_run(spectra_trans_thread, dev, "nand_thd");
        if (IS_ERR(dev->thread)) {
                blk_cleanup_queue(dev->queue);
                unregister_blkdev(GLOB_SBD_majornum, GLOB_SBD_NAME);
                return PTR_ERR(dev->thread);
        }

        dev->gd = alloc_disk(PARTITIONS);
        if (!dev->gd) {
                printk(KERN_ERR
                       "Spectra: Could not allocate disk. Aborting \n ");
                goto out_vfree;
        }
        dev->gd->major = GLOB_SBD_majornum;
        dev->gd->first_minor = which * PARTITIONS;
        dev->gd->fops = &GLOB_SBD_ops;
        dev->gd->queue = dev->queue;
        dev->gd->private_data = dev;
        snprintf(dev->gd->disk_name, 32, "%s%c", GLOB_SBD_NAME, which + 'a');

        u32 sects = dev->size >> 9;
        nand_dbg_print(NAND_DBG_WARN, "Capacity sects: %d\n", sects);
        set_capacity(dev->gd, sects);
        nand_dbg_print(NAND_DBG_DEBUG, "%s, Line %d\n", __FILE__, __LINE__);
        add_disk(dev->gd);
        nand_dbg_print(NAND_DBG_DEBUG, "%s, Line %d\n", __FILE__, __LINE__);

        return 0;
out_vfree:
        return -ENOMEM;
}


static const struct pci_device_id nand_pci_ids[] = {
        {
         .vendor = 0x8086,
         .device = 0x0809,
         .subvendor = PCI_ANY_ID,
         .subdevice = PCI_ANY_ID,
         },
        { /* end: all zeroes */ }
};

static int nand_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
{
        int ret = -ENODEV;
        unsigned long csr_base;
        unsigned long csr_len;
        struct spectra_nand_dev *pndev = &nand_device[dev_num];

        ret = pci_enable_device(dev);
        if (ret) {
                printk(KERN_ERR "Spectra: pci_enable_device failed.\n");
                return ret;
        }

        pci_set_master(dev);
        pndev->dev = dev;

        csr_base = pci_resource_start(dev, 0);
        if (!csr_base) {
                printk(KERN_ERR "Spectra: pci_resource_start failed!\n");
                return -ENODEV;
        }

        csr_len = pci_resource_len(dev, 0);
        if (!csr_len) {
                printk(KERN_ERR "Spectra: pci_resource_len failed!\n");
                return -ENODEV;
        }

        ret = pci_request_regions(dev, GLOB_SBD_NAME);
        if (ret) {
                printk(KERN_ERR "Spectra: Unable to request "
                       "memory region\n");
                goto failed_req_csr;
        }

        pndev->ioaddr = ioremap_nocache(csr_base, csr_len);
        if (!pndev->ioaddr) {
                printk(KERN_ERR "Spectra: Unable to remap memory region\n");
                ret = -ENOMEM;
                goto failed_remap_csr;
        }
        nand_dbg_print(NAND_DBG_DEBUG, "Spectra: CSR 0x%08lx -> 0x%p (0x%lx)\n",
                       csr_base, pndev->ioaddr, csr_len);

        pci_set_drvdata(dev, pndev);

        dev_num++;

        return 0;

failed_remap_csr:
        pci_release_regions(dev);
failed_req_csr:

        return ret;
}

static void nand_pci_remove(struct pci_dev *dev)
{
        struct spectra_nand_dev *pndev = pci_get_drvdata(dev);

        iounmap(pndev->ioaddr);
        pci_release_regions(dev);
        pci_disable_device(dev);
}

MODULE_DEVICE_TABLE(pci, nand_pci_ids);

static struct pci_driver nand_pci_driver = {
        .name = GLOB_SBD_NAME,
        .id_table = nand_pci_ids,
        .probe = nand_pci_probe,
        .remove = nand_pci_remove,
};

static int GLOB_SBD_init(void)
{
        int i, retval;

        nand_debug_level = 3; /* Set level value for debug output */

        mutex_init(&spectra_lock);

        GLOB_SBD_majornum = register_blkdev(0, GLOB_SBD_NAME);
        if (GLOB_SBD_majornum <= 0) {
                printk(KERN_ERR "Unable to get the major %d for Spectra",
                       GLOB_SBD_majornum);
                return -EBUSY;
        }

        if (PASS != GLOB_FTL_Flash_Init()) {
                printk(KERN_ERR "Spectra: Unable to Initialize Flash Device. "
                       "Aborting\n");
                goto out_flash_register;
        }

        retval = pci_register_driver(&nand_pci_driver);
        if (retval)
                return -ENOMEM;

        if (PASS != GLOB_FTL_IdentifyDevice(&IdentifyDeviceData)) {
                printk(KERN_ERR "Spectra: Unable to Read Flash Device. "
                       "Aborting\n");
                goto out_flash_register;
        } else {
                nand_dbg_print(NAND_DBG_WARN, "In GLOB_SBD_init: "
                               "Num blocks=%d, pagesperblock=%d, "
                               "pagedatasize=%d, ECCBytesPerSector=%d, "
                               "SizeofGlobalMem=%d\n",
                       (int)IdentifyDeviceData.NumBlocks,
                       (int)IdentifyDeviceData.PagesPerBlock,
                       (int)IdentifyDeviceData.PageDataSize,
                       (int)IdentifyDeviceData.wECCBytesPerSector,
                       (int)IdentifyDeviceData.SizeOfGlobalMem);
        }

        if (SBD_SECTOR_SIZE % KERNEL_SECTOR_SIZE) {
                printk(KERN_ERR "Spectra: Flash page data size is not an "
                       "integral multiple of kernel sector size %d. Aborting\n",
                       KERNEL_SECTOR_SIZE);
                goto out_flash_register;
        }

        /* mem_pool_ptr = (u8 *)kmalloc(IdentifyDeviceData.SizeOfGlobalMem,
         * GFP_KERNEL);
         */

        mem_pool_ptr = local_mem_pool;
        if (!mem_pool_ptr) {
                printk(KERN_ERR "Spectra: Unable to Initialize Memory Pool. "
                       "Aborting\n");
                goto out_mempool_flash_register;
        }

        if (PASS != GLOB_FTL_Mem_Config(mem_pool_ptr)) {
                printk(KERN_ERR "Spectra: Unable to Read Flash Device. "
                       "Aborting\n");
                goto out_mempool_flash_register;
        }

        printk(KERN_ALERT "Spectra: searching block table, please wait ...\n");
        if (GLOB_FTL_Init() != PASS) {
                printk(KERN_ERR "Spectra: Unable to Initialize FTL Layer. "
                       "Aborting\n");
                goto out_ftl_flash_register;
        }

        for (i = 0; i < NUM_DEVICES; i++)
                if (SBD_setup_device(&nand_device[i], i) == -ENOMEM)
                        goto out_ftl_flash_register;

        nand_dbg_print(NAND_DBG_DEBUG,
                       "Spectra: module loaded with major number %d\n",
                       GLOB_SBD_majornum);

        return 0;

out_ftl_flash_register:
        GLOB_FTL_Cache_Release();
out_flash_register:
        GLOB_FTL_Flash_Release();
        unregister_blkdev(GLOB_SBD_majornum, GLOB_SBD_NAME);
        pci_unregister_driver(&nand_pci_driver);

out_mempool_flash_register:
        /* kfree(mem_pool_ptr); */

        printk(KERN_ERR "Spectra: Module load failed.\n");
        return -ENOMEM;
}

static void __exit GLOB_SBD_exit(void)
{
        int i;

        nand_dbg_print(NAND_DBG_TRACE, "%s, Line %d, Function: %s\n",
                       __FILE__, __LINE__, __func__);

        for (i = 0; i < NUM_DEVICES; i++) {
                struct spectra_nand_dev *dev = &nand_device[i];
                if (dev->gd) {
                        del_gendisk(dev->gd);
                        put_disk(dev->gd);
                }
                if (dev->queue)
                        blk_cleanup_queue(dev->queue);
        }

        unregister_blkdev(GLOB_SBD_majornum, GLOB_SBD_NAME);

        mutex_lock(&spectra_lock);
        force_flush_cache();
        mutex_unlock(&spectra_lock);

        GLOB_FTL_Cache_Release();

        /* kfree(mem_pool_ptr); */

        GLOB_FTL_Flash_Release();
        pci_unregister_driver(&nand_pci_driver);

        nand_dbg_print(NAND_DBG_DEBUG,
                       "Spectra FTL module (major number %d) unloaded.\n",
                       GLOB_SBD_majornum);
}

module_init(GLOB_SBD_init);
module_exit(GLOB_SBD_exit);

----------------------------------------------------------------------------------------------------------------------------------------



