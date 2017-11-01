From: Taras Kondratiuk <takondra@cisco.com>
Subject: Manual unbind of ATA devices causes use-after-free
Date: Wed, 01 Nov 2017 16:24:47 -0700
Message-ID: <150957868766.7160.13267337838101258462@takondra-t460s>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:31891 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932964AbdKAXeO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 1 Nov 2017 19:34:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, xe-linux-external@cisco.com

Hi Heo,

Manual unbind/remove unconditionally invokes devres_release_all which
calls ata_host_release() and frees ata_host/ata_port memory while it is
still being referenced (e.g as a parent of SCSI host).

Is there a reason why ata_host is using derves which is not refcounted?
Does it make sense to add recounting to ata_host?

We have noticed the issue when put_device(parent) in
scsi_host_dev_release() complained about not initialized kobject.

  WARNING: CPU: 3 PID: 247 at lib/kobject.c:690 kobject_put+0x34/0x92()
  kobject: '(null)' (ffff8804040baf18): is not initialized, yet kobject_put=
() is being called.
  Modules linked in: lxc_wd(O) contdev_generic(O) pca8550(O) uhci_hcd tipc =
ip6_udp_tunnel udp_tunnel liin(O) lfts(O) ez_np5c(O) quack(O) ngio(O) ds265=
21(O) ds31408(O) astro(O) epa(O) dev_obj_lib(PO) pdmaif(O) cpp_kipc_mod(O) =
cpp_pdma_mod(O) cpp_il_mod(O) cpp_intr_mod(O) yoda_drv_mod(O) cpp_hw_drv_mo=
d(O) cpp_drv_mod(O) ich9spi(O) mtdblock mtd_blkdevs oct_drv_mcp(PO) gladden=
_edac(O) edac_core max3674(O) pmbus_ps(O) pmbus_core(O) seeprom(O) beeprom(=
O) luna_fpga(O) i2c_2kh_luna(O) i2c_2kh_reset(O) ck420(O) adm1066(O) ltc421=
5(O) ltc4151(O) pc
  CPU: 3 PID: 247 Comm: kworker/3:2 Tainted: P           O    4.4.76 #1
  Workqueue: events sg_remove_sfp_usercontext
   0000000000000006 ffffffff81294c0e ffff8804247e3c88 0000000000000009
   ffffffff81044b1e ffffffff812966ab ffff8804040baf18 ffff8804247e3ce0
   ffff880403f54300 ffff8804278a92b0 ffffffff81044b7b ffffffff818224af
  Call Trace:
   [<ffffffff81294c0e>] ? dump_stack+0x5e/0x84
   [<ffffffff81044b1e>] ? warn_slowpath_common+0x93/0xa8
   [<ffffffff812966ab>] ? kobject_put+0x34/0x92
   [<ffffffff81044b7b>] ? warn_slowpath_fmt+0x48/0x50
   [<ffffffff8134d618>] ? scsi_host_dev_release+0xe2/0x107
   [<ffffffff812966ab>] ? kobject_put+0x34/0x92
   [<ffffffff8134d631>] ? scsi_host_dev_release+0xfb/0x107
   [<ffffffff8133d0a2>] ? device_release+0x54/0x86
   [<ffffffff812966f3>] ? kobject_put+0x7c/0x92
   [<ffffffff8133d0a2>] ? device_release+0x54/0x86
   [<ffffffff812966f3>] ? kobject_put+0x7c/0x92
   [<ffffffff81056f56>] ? execute_in_process_context+0x20/0x59
   [<ffffffff8133d0a2>] ? device_release+0x54/0x86
   [<ffffffff812966f3>] ? kobject_put+0x7c/0x92
   [<ffffffff813600d5>] ? sg_remove_sfp_usercontext+0xcc/0xef
   [<ffffffff81057706>] ? process_one_work+0x1c4/0x333
   [<ffffffff810582a5>] ? worker_thread+0x264/0x347
   [<ffffffff81058041>] ? rescuer_thread+0x274/0x274
   [<ffffffff8105c028>] ? kthread+0xd0/0xd8
   [<ffffffff8105bf58>] ? kthread_worker_fn+0x129/0x129
   [<ffffffff8152832f>] ? ret_from_fork+0x3f/0x70
   [<ffffffff8105bf58>] ? kthread_worker_fn+0x129/0x129

This happens if freed memory is already zeroed by the next user. Otherwise =

put_device() just silently corrupts memory. KASAN reports issues in
several other places where freed ata_host memory is accessed.

My setup has v4.4 kernel, but the related code seems to be the same in
v4.14.  I'm reproducing the issue by manually removing or unbinding
device. KASAN starts to complain about use-after-free within 10 cycles.

while true;
    do echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.0/rescan
    sleep 5
    echo 1 > /sys/devices/pci0000\:00/0000\:00\:1c.0/0000\:05\:00.0/remove
    sleep 5
done

