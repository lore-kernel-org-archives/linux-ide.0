From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: kernel problems with smart on LSI-92xx
Date: Thu, 11 Nov 2010 15:06:48 +0100
Message-ID: <87y690hs3r.fsf@nemi.mork.no>
References: <4CD9A09D.7000508@ngs.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36884 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752469Ab0KKOHH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 11 Nov 2010 09:07:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-ide@m.gmane.org>)
	id 1PGXnp-00009b-Dt
	for linux-ide@vger.kernel.org; Thu, 11 Nov 2010 15:07:01 +0100
Received: from 193.160.199.2 ([193.160.199.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2010 15:07:01 +0100
Received: from bjorn by 193.160.199.2 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Thu, 11 Nov 2010 15:07:01 +0100
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bokhan Artem <aptem@ngs.ru>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Bokhan Artem <aptem@ngs.ru> writes:

> Hello.
>
> I have kernel problems when trying to run smart commands on LSI-92xx
> controller.
>
> Running self-test  on SAS disk (smartctl /dev/sda -dmegaraid,24 -t
> long) with smartmontools causes kernel oops (?) (and segfault). Look
> in attachment for dmesg.
>
> strace of smartctl:
>
> mknod("/dev/megaraid_sas_ioctl_node", S_IFCHR, makedev(251, 0)) = -1 EEXIST
> (File exists)
> close(4)                                = 0
> munmap(0x7f4be3a9f000, 4096)            = 0
> open("/dev/megaraid_sas_ioctl_node", O_RDWR) = 4
> ioctl(4, MTRRIOC_SET_ENTRY, 0x7fffa574ed30) = 0
> ioctl(4, MTRRIOC_SET_ENTRY, 0x7fffa574eb30) = 0
> ioctl(4, MTRRIOC_SET_ENTRY <unfinished ...>
> +++ killed by SIGSEGV +++
>
>
> Viewing  smart info is OK (smartctl /dev/sda -dmegaraid,24 -a).
> Running self-test on SATA disk on the same system is OK.
>
> The problem is reproducible with 2.6.32 and 2.6.36 kernels.

A quick look at this reveals that smartctl will happily do a
MEGASAS_IOC_FIRMWARE ioctl with sge_count = 1 and sgl[0].iov_len = 0 if
it is sending a command with dataLen == 0 :


/* Issue passthrough scsi command to PERC5/6 controllers */
bool linux_megaraid_device::megasas_cmd(int cdbLen, void *cdb, 
  int dataLen, void *data,
  int /*senseLen*/, void * /*sense*/, int /*report*/)
{
  struct megasas_pthru_frame    *pthru;
  struct megasas_iocpacket      uio;
  struct megasas_iocpacket      uio;
  int rc;

  memset(&uio, 0, sizeof(uio));
  pthru = (struct megasas_pthru_frame *)uio.frame.raw;
  pthru->cmd = MFI_CMD_PD_SCSI_IO;
  int rc;

  memset(&uio, 0, sizeof(uio));
  pthru = (struct megasas_pthru_frame *)uio.frame.raw;
  pthru->cmd = MFI_CMD_PD_SCSI_IO;
  pthru->cmd_status = 0xFF;
  pthru->scsi_status = 0x0;
  pthru->target_id = m_disknum;
  pthru->lun = 0;
  pthru->cdb_len = cdbLen;
  pthru->timeout = 0;
  pthru->flags = MFI_FRAME_DIR_READ;
  pthru->sge_count = 1;
  pthru->data_xfer_len = dataLen;
  pthru->sgl.sge32[0].phys_addr = (intptr_t)data;
  pthru->sgl.sge32[0].length = (uint32_t)dataLen;
  memcpy(pthru->cdb, cdb, cdbLen);

  uio.host_no = m_hba;
  uio.sge_count = 1;
  uio.sgl_off = offsetof(struct megasas_pthru_frame, sgl);
  uio.sgl[0].iov_base = data;
  uio.sgl[0].iov_len = dataLen;

  rc = 0;
  errno = 0;
  rc = ioctl(m_fd, MEGASAS_IOC_FIRMWARE, &uio);
  if (pthru->cmd_status || rc != 0) {
    if (pthru->cmd_status == 12) {
      return set_err(EIO, "megasas_cmd: Device %d does not exist\n", m_disknum);
    }
    return set_err((errno ? errno : EIO), "megasas_cmd result: %d.%d = %d/%d",
                   m_hba, m_disknum, errno,
                   pthru->cmd_status);
  }
  return true;
}



The kernel bug is that the zero valued sgl[0].iov_len is passed
unmodified to megasas_mgmt_fw_ioctl() which again passes it on as size
to dma_alloc_coherent():

        /*
         * For each user buffer, create a mirror buffer and copy in
         */
        for (i = 0; i < ioc->sge_count; i++) {
                kbuff_arr[i] = dma_alloc_coherent(&instance->pdev->dev,
                                                    ioc->sgl[i].iov_len,
                                                    &buf_handle, GFP_KERNEL);



And it looks like most (all?) of the dma_alloc_coherent()
implementations will use get_order(size) to compute the necessary
allocation. This will fail if size == 0.

On the other hand, I may have misunderstood this entirely....

But if you dare, you could try the attached patch (compile tested only
as I don't have the hardware) and see if it helps.  Let me know how it
goes, and I'll forward it to the megaraid manitainers if it really fixes
your problem.




Bjørn


--=-=-=
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: inline;
 filename=0001-SCSI-megaraid_sas-Sanity-check-user-supplied-length-.patch
Content-Transfer-Encoding: 8bit

>From 110053460ce4b33097b7aefe4a7e60c5494b6014 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Date: Thu, 11 Nov 2010 14:54:11 +0100
Subject: [PATCH] [SCSI] megaraid_sas: Sanity check user supplied length before passing it to dma_alloc_coherent()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ioc->sgl[i].iov_len value is supplied by the ioctl caller, and can be
zero in some cases.  Assume that's valid and continue without error.

Fixes:

[   69.162538] ------------[ cut here ]------------
[   69.162806] kernel BUG at /build/buildd/linux-2.6.32/lib/swiotlb.c:368!
[   69.163134] invalid opcode: 0000 [#1] SMP
[   69.163570] last sysfs file: /sys/devices/system/cpu/cpu3/cache/index2/shared_cpu_map
[   69.163975] CPU 0
[   69.164227] Modules linked in: fbcon tileblit font bitblit softcursor vga16fb vgastate ioatdma radeon ttm drm_kms_helper shpchp drm i2c_algo_bit lp parport floppy pata_jmicron megaraid_sas igb dca
[   69.167419] Pid: 1206, comm: smartctl Tainted: G        W  2.6.32-25-server #45-Ubuntu X8DTN
[   69.167843] RIP: 0010:[<ffffffff812c4dc5>]  [<ffffffff812c4dc5>] map_single+0x255/0x260
[   69.168370] RSP: 0018:ffff88081c0ebc58  EFLAGS: 00010246
[   69.168655] RAX: 000000000003bffc RBX: 00000000ffffffff RCX: 0000000000000002
[   69.169000] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88001dffe000
[   69.169346] RBP: ffff88081c0ebcb8 R08: 0000000000000000 R09: ffff880000030840
[   69.169691] R10: 0000000000100000 R11: 0000000000000000 R12: 0000000000000000
[   69.170036] R13: 00000000ffffffff R14: 0000000000000001 R15: 0000000000200000
[   69.170382] FS:  00007fb8de189720(0000) GS:ffff88001de00000(0000) knlGS:0000000000000000
[   69.170794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.171094] CR2: 00007fb8dd59237c CR3: 000000081a790000 CR4: 00000000000006f0
[   69.171439] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   69.171784] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[   69.172130] Process smartctl (pid: 1206, threadinfo ffff88081c0ea000, task ffff88081a760000)
[   69.194513] Stack:
[   69.205788]  0000000000000034 00000002817e3390 0000000000000000 ffff88081c0ebe00
[   69.217739] <0> 0000000000000000 000000000003bffc 0000000000000000 0000000000000000
[   69.241250] <0> 0000000000000000 00000000ffffffff ffff88081c5b4080 ffff88081c0ebe00
[   69.277310] Call Trace:
[   69.289278]  [<ffffffff812c52ac>] swiotlb_alloc_coherent+0xec/0x130
[   69.301118]  [<ffffffff81038b31>] x86_swiotlb_alloc_coherent+0x61/0x70
[   69.313045]  [<ffffffffa002d0ce>] megasas_mgmt_fw_ioctl+0x1ae/0x690 [megaraid_sas]
[   69.336399]  [<ffffffffa002d748>] megasas_mgmt_ioctl_fw+0x198/0x240 [megaraid_sas]
[   69.359346]  [<ffffffffa002f695>] megasas_mgmt_ioctl+0x35/0x50 [megaraid_sas]
[   69.370902]  [<ffffffff81153b12>] vfs_ioctl+0x22/0xa0
[   69.382322]  [<ffffffff8115da2a>] ? alloc_fd+0x10a/0x150
[   69.393622]  [<ffffffff81153cb1>] do_vfs_ioctl+0x81/0x410
[   69.404696]  [<ffffffff8155cc13>] ? do_page_fault+0x153/0x3b0
[   69.415761]  [<ffffffff811540c1>] sys_ioctl+0x81/0xa0
[   69.426640]  [<ffffffff810121b2>] system_call_fastpath+0x16/0x1b
[   69.437491] Code: fe ff ff 48 8b 3d 74 38 76 00 41 bf 00 00 20 00 e8 51 f5 d7 ff 83 e0 ff 48 05 ff 07 00 00 48 c1 e8 0b 48 89 45 c8 e9 13 fe ff ff <0f> 0b eb fe 0f 1f 80 00 00 00 00 55 48 89 e5 48 83 ec 20 4c 89
[   69.478216] RIP  [<ffffffff812c4dc5>] map_single+0x255/0x260
[   69.489668]  RSP <ffff88081c0ebc58>
[   69.500975] ---[ end trace 6a2181b634e2abc7 ]---

Reported-by: Bokhan Artem <aptem@ngs.ru>
Signed-off-by: Bjørn Mork <bjorn@mork.no>
Cc: stable@kernel.org
---
 drivers/scsi/megaraid/megaraid_sas.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.c b/drivers/scsi/megaraid/megaraid_sas.c
index eb29d50..72713c5 100644
--- a/drivers/scsi/megaraid/megaraid_sas.c
+++ b/drivers/scsi/megaraid/megaraid_sas.c
@@ -4359,6 +4359,11 @@ megasas_mgmt_fw_ioctl(struct megasas_instance *instance,
 	 * For each user buffer, create a mirror buffer and copy in
 	 */
 	for (i = 0; i < ioc->sge_count; i++) {
+		if (ioc->sgl[i].iov_len == 0) {
+			kbuff_arr[i] = NULL;
+			continue;
+		}
+
 		kbuff_arr[i] = dma_alloc_coherent(&instance->pdev->dev,
 						    ioc->sgl[i].iov_len,
 						    &buf_handle, GFP_KERNEL);
-- 
1.7.2.3


--=-=-=--

