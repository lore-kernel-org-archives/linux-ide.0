From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_nv frees DMA memory with different size (possibly a generic
 libata bug)
Date: Thu, 12 Feb 2009 21:03:38 -0600
Message-ID: <4994E30A.3040501@gmail.com>
References: <20090212163952.78ca7d4f@dhcp-100-2-144.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:24915 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZBMDDm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Feb 2009 22:03:42 -0500
Received: by yw-out-2324.google.com with SMTP id 5so556295ywh.1
        for <linux-ide@vger.kernel.org>; Thu, 12 Feb 2009 19:03:41 -0800 (PST)
In-Reply-To: <20090212163952.78ca7d4f@dhcp-100-2-144.bos.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org

Chuck Ebbert wrote:
> Fedora rawhide has the DMA API debug patch applied and it has found this...
> 
> From https://bugzilla.redhat.com/show_bug.cgi?id=485172
> 
> WARNING: at lib/dma-debug.c:439 check_unmap+0x16a/0x3dd() (Tainted: G        W
> )
> Hardware name: System Product Name
> sata_nv 0000:00:0d.0: DMA-API: device driver frees DMA memory with different
> size [device address=0x00000000da031000] [map size=4096 bytes] [unmap
> size=8192bytes]
> Modules linked in: bridge stp llc bnep sco l2cap bluetooth sunrpc ip6t_REJECT
> nf_conntrack_ipv6 ip6table_filter ip6_tables ipv6 cpufreq_ondemand
> powernow_k8freq_table dm_multipath uinput snd_hda_codec_analog snd_hda_intel
> snd_hda_codec snd_hwdep snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
> snd_seq_device snd_pcm_oss ppdev snd_mixer_oss snd_pcm snd_timer firewire_ohci
> snd firewire_core soundcore aic7xxx snd_page_alloc jedec_probe crc_itu_t
> forcedeth scsi_transport_spi pcspkr cfi_probe gen_probe sata_sil24 parport_pc
> cfi_util parport mtd chipreg i2c_nforce2 map_funcs asus_atk0110 pata_amd
> i2c_core hwmon ata_generic pata_acpi sata_nv raid456 async_xor async_memcpy
> async_tx xor raid1 sha256_generic cbc aes_x86_64 aes_generic dm_crypt ext4 jbd2
> crc16 [last unloaded: scsi_wait_scan]
> Pid: 0, comm: swapper Tainted: G        W  2.6.29-0.99.rc4.git1.fc11.x86_64 #1
> Call Trace:
> <IRQ>  [<ffffffff81048822>] warn_slowpath+0xb7/0xe7
> [<ffffffff8137bc4f>] ? _spin_lock_irqsave+0x78/0x86
> [<ffffffff8119851b>] ? get_hash_bucket+0x28/0x34
> [<ffffffff8106a5ae>] ? trace_hardirqs_off_caller+0x1f/0xac
> [<ffffffff81198a15>] check_unmap+0x16a/0x3dd
> [<ffffffff810388a7>] ? resched_task+0x2e/0x74
> [<ffffffff81198d66>] debug_dma_unmap_sg+0x7c/0x9b
> [<ffffffff8106a648>] ? trace_hardirqs_off+0xd/0xf
> [<ffffffff8124fef9>] ata_sg_clean+0x96/0xd0
> [<ffffffff8124ff89>] __ata_qc_complete+0x56/0xc9
> [<ffffffff8125018b>] ata_qc_complete+0x18f/0x198
> [<ffffffffa00cb249>] nv_swncq_interrupt+0x358/0x688 [sata_nv]

That's rather curious. It seems to be saying that the sg length is 
different between the map and unmap, but it doesn't look like sata_nv 
mucks with that anywhere, and neither does libata core..
