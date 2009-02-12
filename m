From: Chuck Ebbert <cebbert@redhat.com>
Subject: sata_nv frees DMA memory with different size (possibly a generic
 libata bug)
Date: Thu, 12 Feb 2009 16:39:52 -0500
Message-ID: <20090212163952.78ca7d4f@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60638 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756181AbZBLVmZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 16:42:25 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Fedora rawhide has the DMA API debug patch applied and it has found this...

>From https://bugzilla.redhat.com/show_bug.cgi?id=485172

WARNING: at lib/dma-debug.c:439 check_unmap+0x16a/0x3dd() (Tainted: G        W
)
Hardware name: System Product Name
sata_nv 0000:00:0d.0: DMA-API: device driver frees DMA memory with different
size [device address=0x00000000da031000] [map size=4096 bytes] [unmap
size=8192bytes]
Modules linked in: bridge stp llc bnep sco l2cap bluetooth sunrpc ip6t_REJECT
nf_conntrack_ipv6 ip6table_filter ip6_tables ipv6 cpufreq_ondemand
powernow_k8freq_table dm_multipath uinput snd_hda_codec_analog snd_hda_intel
snd_hda_codec snd_hwdep snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
snd_seq_device snd_pcm_oss ppdev snd_mixer_oss snd_pcm snd_timer firewire_ohci
snd firewire_core soundcore aic7xxx snd_page_alloc jedec_probe crc_itu_t
forcedeth scsi_transport_spi pcspkr cfi_probe gen_probe sata_sil24 parport_pc
cfi_util parport mtd chipreg i2c_nforce2 map_funcs asus_atk0110 pata_amd
i2c_core hwmon ata_generic pata_acpi sata_nv raid456 async_xor async_memcpy
async_tx xor raid1 sha256_generic cbc aes_x86_64 aes_generic dm_crypt ext4 jbd2
crc16 [last unloaded: scsi_wait_scan]
Pid: 0, comm: swapper Tainted: G        W  2.6.29-0.99.rc4.git1.fc11.x86_64 #1
Call Trace:
<IRQ>  [<ffffffff81048822>] warn_slowpath+0xb7/0xe7
[<ffffffff8137bc4f>] ? _spin_lock_irqsave+0x78/0x86
[<ffffffff8119851b>] ? get_hash_bucket+0x28/0x34
[<ffffffff8106a5ae>] ? trace_hardirqs_off_caller+0x1f/0xac
[<ffffffff81198a15>] check_unmap+0x16a/0x3dd
[<ffffffff810388a7>] ? resched_task+0x2e/0x74
[<ffffffff81198d66>] debug_dma_unmap_sg+0x7c/0x9b
[<ffffffff8106a648>] ? trace_hardirqs_off+0xd/0xf
[<ffffffff8124fef9>] ata_sg_clean+0x96/0xd0
[<ffffffff8124ff89>] __ata_qc_complete+0x56/0xc9
[<ffffffff8125018b>] ata_qc_complete+0x18f/0x198
[<ffffffffa00cb249>] nv_swncq_interrupt+0x358/0x688 [sata_nv]
[<ffffffff8137b8fe>] ? _spin_unlock_irqrestore+0x3c/0x53
[<ffffffff8106a5ae>] ? trace_hardirqs_off_caller+0x1f/0xac
[<ffffffff81016d7d>] ? read_tsc+0x9/0x1a
[<ffffffff81063eb1>] ? getnstimeofday+0x5a/0xae
[<ffffffff81093288>] handle_IRQ_event+0x22/0x5e
[<ffffffff81094ba0>] handle_fasteoi_irq+0x8b/0xd7
[<ffffffff81013a55>] do_IRQ+0xd4/0x14b
[<ffffffff81011d93>] ret_from_intr+0x0/0x2e
<EOI>  [<ffffffff810179fe>] ? default_idle+0x47/0x77
[<ffffffff8106b61f>] ? trace_hardirqs_on+0xd/0xf
[<ffffffff81029282>] ? native_safe_halt+0x6/0x8
[<ffffffff8106b61f>] ? trace_hardirqs_on+0xd/0xf
[<ffffffff81017a03>] ? default_idle+0x4c/0x77
[<ffffffff810666fb>] ? clockevents_notify+0x5d/0x62
[<ffffffff81017b2d>] ? c1e_idle+0xf1/0x126
[<ffffffff81010220>] ? cpu_idle+0x63/0xae
[<ffffffff813754d1>] ? start_secondary+0x199/0x19e
