From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11044] New: PATA DVD Drive inaccesible with latest kernels
Date: Sun,  6 Jul 2008 07:31:41 -0700 (PDT)
Message-ID: <bug-11044-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58700 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756736AbYGFObp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jul 2008 10:31:45 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m66EVfqR002417
	for <linux-ide@vger.kernel.org>; Sun, 6 Jul 2008 07:31:42 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11044

           Summary: PATA DVD Drive inaccesible with latest kernels
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25.10
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: jb@scorpion77.cjb.net


Latest working kernel version:
Earliest failing kernel version: 2.6.25.10 (and all Fedora 9 kernels) 
Distribution: Fedora 9 X86_64
Hardware Environment: Asus P5N-T Deluxe (Nvidia 780I SLI board), Q9450 Intel
CPU, 4Gig RAM and a 20x Aopen IDE DVD Writer
Software Environment: vanilla kernel 2.6.25.10, Fedora 9 x86_64, Gnome 2.22
Problem Description:

My PATA DVD Writer is completely unusable with Fedora 9, this is both with the
Fedora kernels as with the latest stable vanilla kernel release (2.6.25.10).
/var/log/messages shows entries like these:

Jul  6 00:56:27 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:56:27 morphius kernel: ata7.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Jul  6 00:56:27 morphius kernel:          cdb 4a 01 00 00 10 00 00 00  08 00 00
00 00 00 00 00
Jul  6 00:56:27 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:56:27 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:56:27 morphius kernel: ata7: soft resetting link
Jul  6 00:56:27 morphius kernel: ata7.00: configured for UDMA/66
Jul  6 00:56:27 morphius kernel: ata7: EH complete
Jul  6 00:56:34 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:56:34 morphius kernel: ata7.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Jul  6 00:56:34 morphius kernel:          cdb 4a 01 00 00 10 00 00 00  08 00 00
00 00 00 00 00
Jul  6 00:56:34 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:56:34 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:56:34 morphius kernel: ata7: soft resetting link
Jul  6 00:56:34 morphius kernel: ata7.00: configured for UDMA/66
Jul  6 00:56:34 morphius kernel: ata7: EH complete
Jul  6 00:56:41 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:56:41 morphius kernel: ata7.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Jul  6 00:56:41 morphius kernel:          cdb 4a 01 00 00 10 00 00 00  08 00 00
00 00 00 00 00
Jul  6 00:56:41 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:56:41 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:56:41 morphius kernel: ata7: soft resetting link
Jul  6 00:56:42 morphius kernel: ata7.00: configured for UDMA/66
Jul  6 00:56:42 morphius kernel: ata7: EH complete
Jul  6 00:56:49 morphius ntpd[3125]: Listening on interface #7 eth0,
fe80::21e:8cff:feb4:ac26#123 Enabled
Jul  6 00:56:49 morphius kernel: ata7.00: limiting speed to UDMA/44:PIO4
Jul  6 00:56:49 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:56:49 morphius kernel: ata7.00: cmd
a0/00:00:00:08:00/00:00:00:00:00/a0 tag 0 pio 16392 in
Jul  6 00:56:49 morphius kernel:          cdb 4a 01 00 00 10 00 00 00  08 00 00
00 00 00 00 00
Jul  6 00:56:49 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:56:49 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:56:49 morphius kernel: ata7: soft resetting link
Jul  6 00:56:49 morphius kernel: ata7.00: configured for UDMA/44
Jul  6 00:56:49 morphius kernel: ata7: EH complete
Jul  6 00:56:49 morphius kernel: sr1: CDROM (ioctl) error, command: Get event
status notification 4a 01 00 00 10 00 00 00 08 00
Jul  6 00:56:49 morphius kernel: sr: Sense Key : Aborted Command [current]
[descriptor]
Jul  6 00:56:49 morphius kernel: sr: Add. Sense: No additional sense
information
Jul  6 00:56:59 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:56:59 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:56:59 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:56:59 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:56:59 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:56:59 morphius kernel: ata7: soft resetting link
Jul  6 00:57:00 morphius kernel: ata7.00: configured for UDMA/44
Jul  6 00:57:00 morphius kernel: ata7: EH complete
Jul  6 00:57:10 morphius kernel: ata7.00: limiting speed to UDMA/33:PIO4
Jul  6 00:57:10 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:57:10 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:57:10 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:57:10 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:57:10 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:57:10 morphius kernel: ata7: soft resetting link
Jul  6 00:57:10 morphius kernel: ata7.00: configured for UDMA/33
Jul  6 00:57:10 morphius kernel: ata7: EH complete
Jul  6 00:57:20 morphius kernel: ata7.00: limiting speed to PIO4
Jul  6 00:57:20 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:57:20 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:57:20 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:57:20 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:57:20 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:57:20 morphius kernel: ata7: soft resetting link
Jul  6 00:57:21 morphius kernel: ata7.00: configured for PIO4
Jul  6 00:57:21 morphius kernel: ata7: EH complete
Jul  6 00:57:31 morphius kernel: ata7.00: limiting speed to PIO3
Jul  6 00:57:31 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:57:31 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:57:31 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:57:31 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:57:31 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:57:31 morphius kernel: ata7: soft resetting link
Jul  6 00:57:31 morphius kernel: ata7.00: configured for PIO3
Jul  6 00:57:31 morphius kernel: ata7: EH complete
Jul  6 00:57:41 morphius kernel: ata7.00: limiting speed to PIO0
Jul  6 00:57:41 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:57:41 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:57:41 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:57:41 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:57:41 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:57:41 morphius kernel: ata7: soft resetting link
Jul  6 00:57:42 morphius kernel: ata7.00: configured for PIO0
Jul  6 00:57:42 morphius kernel: ata7: EH complete
Jul  6 00:57:42 morphius pulseaudio[3840]: module-alsa-sink.c: Error opening
PCM device front:0: Ongeldig argument
Jul  6 00:57:52 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:57:52 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:57:52 morphius kernel:          cdb 1e 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:57:52 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:57:52 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:57:52 morphius kernel: ata7: soft resetting link
Jul  6 00:57:52 morphius kernel: ata7.00: configured for PIO0
Jul  6 00:57:52 morphius kernel: ata7: EH complete
Jul  6 00:57:52 morphius kernel: sr 6:0:0:0: ioctl_internal_command return code
= 8000002
Jul  6 00:57:52 morphius kernel:    : Sense Key : Aborted Command [current]
[descriptor]
Jul  6 00:57:52 morphius kernel:    : Add. Sense: No additional sense
information
Jul  6 00:58:22 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:58:22 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:58:22 morphius kernel:          cdb 00 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:58:22 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:58:22 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:58:22 morphius kernel: ata7: soft resetting link
Jul  6 00:58:23 morphius kernel: ata7.00: configured for PIO0
Jul  6 00:58:23 morphius kernel: ata7: EH complete
Jul  6 00:58:53 morphius kernel: ata7.00: exception Emask 0x0 SAct 0x0 SErr 0x0
action 0x2 frozen
Jul  6 00:58:53 morphius kernel: ata7.00: cmd
a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
Jul  6 00:58:53 morphius kernel:          cdb 00 00 00 00 00 00 00 00  00 00 00
00 00 00 00 00
Jul  6 00:58:53 morphius kernel:          res
40/00:03:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
Jul  6 00:58:53 morphius kernel: ata7.00: status: { DRDY }
Jul  6 00:58:53 morphius kernel: ata7: soft resetting link
Jul  6 00:58:53 morphius acpid: client connected from 3371[0:0]
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_intel.c:1293:
azx_pcm_prepare: bufsize=0x4400, fragsize=0x1100, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_intel.c:1293:
azx_pcm_prepare: bufsize=0x4400, fragsize=0x1100, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x8, stream=0x1, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_intel.c:1293:
azx_pcm_prepare: bufsize=0x4400, fragsize=0x1100, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0xa, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_intel.c:1293:
azx_pcm_prepare: bufsize=0x4400, fragsize=0x1100, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x4, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x6, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0x5, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ALSA sound/pci/hda/hda_codec.c:686:
hda_codec_setup_stream: NID=0xa, stream=0x5, channel=0, format=0x4011
Jul  6 00:58:53 morphius kernel: ata7.00: configured for PIO0
Jul  6 00:58:53 morphius kernel: ata7: EH complete

Booting with 'noapic' fixes this behaviour. I also lose all means of input
after a short while (5 mins or less), that is my mouse stops responding and the
system does not respond to key combo's like CTRL-ALT-F1. If I then login
remotely via ssh I can enter at most a command or two before it stops
responding to any kind of input again. There are no errors logged regarding
this. Noapic also fixes this.  

Steps to reproduce:

1 Boot Linux on a NForce 780I SLI (possibly also 680I) motherboard with an PATA
DVD or CDROM attached
2 The drive becomes unasable after a short while or does not work at all.
3 Boot Linux with 'noapic' and the drives works as it should.

Additional info:

# uname -a
Linux morphius.lokaal.net 2.6.25.10 #2 SMP Sat Jul 5 23:50:48 CEST 2008 x86_64
x86_64 x86_64 GNU/Linux

# lsmod
Module                  Size  Used by
nls_utf8               10624  0 
ipt_MASQUERADE         11776  1 
iptable_nat            14864  1 
nf_nat                 26008  2 ipt_MASQUERADE,iptable_nat
bridge                 59560  0 
bnep                   21888  2 
rfcomm                 44704  4 
l2cap                  29568  16 bnep,rfcomm
bluetooth              59300  5 bnep,rfcomm,l2cap
ib_iser                38632  0 
rdma_cm                33892  1 ib_iser
ib_cm                  39960  1 rdma_cm
iw_cm                  17160  1 rdma_cm
ib_sa                  28016  2 rdma_cm,ib_cm
ib_mad                 42536  2 ib_cm,ib_sa
ib_core                56320  6 ib_iser,rdma_cm,ib_cm,iw_cm,ib_sa,ib_mad
ib_addr                14856  1 rdma_cm
iscsi_tcp              26372  0 
libiscsi               33152  2 ib_iser,iscsi_tcp
scsi_transport_iscsi    39328  4 ib_iser,iscsi_tcp,libiscsi
coretemp               15232  0 
it87                   31768  0 
hwmon_vid              11264  1 it87
hwmon                  11320  2 coretemp,it87
fuse                   51264  3 
sunrpc                185256  3 
ipt_REJECT             12032  4 
nf_conntrack_ipv4      17672  9 iptable_nat,nf_nat
iptable_filter         11648  1 
ip_tables              25488  2 iptable_nat,iptable_filter
ip6t_REJECT            12800  2 
xt_tcpudp              11904  10 
nf_conntrack_ipv6      23368  4 
xt_state               11008  10 
nf_conntrack           64784  6
ipt_MASQUERADE,iptable_nat,nf_nat,nf_conntrack_ipv4,nf_conntrack_ipv6,xt_state
ip6table_filter        11520  1 
ip6_tables             26896  1 ip6table_filter
x_tables               26504  8
ipt_MASQUERADE,iptable_nat,ipt_REJECT,ip_tables,ip6t_REJECT,xt_tcpudp,xt_state,ip6_tables
cpufreq_ondemand       16016  4 
acpi_cpufreq           17040  1 
freq_table             13696  2 cpufreq_ondemand,acpi_cpufreq
sha256_generic         17920  0 
aes_x86_64             16768  2 
aes_generic            35624  1 aes_x86_64
cbc                    12416  1 
dm_crypt               21384  1 
crypto_blkcipher       24580  3 cbc,dm_crypt
ipv6                  276488  30 ip6t_REJECT,nf_conntrack_ipv6
dm_mirror              32260  0 
dm_multipath           25232  0 
dm_mod                 62360  14 dm_crypt,dm_mirror,dm_multipath
kvm_intel              31040  0 
kvm                   108632  1 kvm_intel
tuner                  45156  0 
tea5767                14468  1 tuner
tda8290                21764  1 tuner
tda18271               39176  1 tda8290
tda827x                18436  1 tda8290
tuner_xc2028           26384  1 tuner
xc5000                 18692  1 tuner
tda9887                18052  1 tuner
tuner_simple           16008  1 tuner
mt20xx                 20104  1 tuner
tea5761                13188  1 tuner
tvaudio                32200  0 
pata_marvell           13952  0 
raid1                  29312  1 
raid0                  15104  1 
bttv                  195236  0 
i2c_nforce2            15104  0 
ir_common              43012  1 bttv
compat_ioctl32         16768  1 bttv
videodev               40064  3 tuner,bttv,compat_ioctl32
v4l1_compat            20356  1 videodev
i2c_algo_bit           14468  1 bttv
v4l2_common            19072  3 tuner,tvaudio,bttv
videobuf_dma_sg        20356  1 bttv
videobuf_core          25220  2 bttv,videobuf_dma_sg
btcx_risc              12808  1 bttv
tveeprom               24848  1 bttv
i2c_core               28704  17
tuner,tea5767,tda8290,tda18271,tda827x,tuner_xc2028,xc5000,tda9887,tuner_simple,mt20xx,tea5761,tvaudio,bttv,i2c_nforce2,i2c_algo_bit,v4l2_common,tveeprom
snd_hda_intel         448052  3 
firewire_ohci          25600  0 
snd_seq_dummy          11780  0 
button                 16032  0 
snd_seq_oss            39488  0 
snd_seq_midi_event     15360  1 snd_seq_oss
snd_seq                62096  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
ahci                   36232  0 
snd_seq_device         15764  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            52352  0 
snd_mixer_oss          23552  1 snd_pcm_oss
snd_pcm                86280  2 snd_hda_intel,snd_pcm_oss
snd_timer              29840  2 snd_seq,snd_pcm
snd_page_alloc         17168  2 snd_hda_intel,snd_pcm
snd_hwdep              16776  1 snd_hda_intel
pata_amd               21124  0 
pcspkr                 11392  0 
forcedeth              56460  0 
firewire_core          47040  1 firewire_ohci
crc_itu_t              10624  1 firewire_core
snd                    67064  16
snd_hda_intel,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_hwdep
soundcore              15120  1 snd
usb_storage            95392  0 
sr_mod                 23988  0 
sg                     40784  0 
floppy                 66408  0 
cdrom                  40872  1 sr_mod
pata_acpi              13824  0 
sata_nv                31624  5 
ata_generic            14724  0 
libata                149024  6
pata_marvell,ahci,pata_amd,pata_acpi,sata_nv,ata_generic
sd_mod                 33200  7 
scsi_mod              150360  9
ib_iser,iscsi_tcp,libiscsi,scsi_transport_iscsi,usb_storage,sr_mod,sg,libata,sd_mod
ext3                  129808  5 
jbd                    52904  1 ext3
mbcache                15876  1 ext3
uhci_hcd               29984  0 
ohci_hcd               29060  0 
ehci_hcd               40460  0 

# lspci
00:00.0 Host bridge: nVidia Corporation C55 Host Bridge (rev a2)
00:00.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.3 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.4 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.5 RAM memory: nVidia Corporation C55 Memory Controller (rev a2)
00:00.6 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:00.7 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.0 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.3 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.4 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.5 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:01.6 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.0 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.1 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:02.2 RAM memory: nVidia Corporation C55 Memory Controller (rev a1)
00:03.0 PCI bridge: nVidia Corporation C55 PCI Express bridge (rev a1)
00:09.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:0a.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a3)
00:0a.1 SMBus: nVidia Corporation MCP55 SMBus (rev a3)
00:0b.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
00:0b.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
00:0d.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:0e.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:0e.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:0e.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)
00:0f.1 Audio device: nVidia Corporation MCP55 High Definition Audio (rev a2)
00:11.0 Bridge: nVidia Corporation MCP55 Ethernet (rev a3)
00:16.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
01:00.0 PCI bridge: nVidia Corporation Unknown device 05b1 (rev a2)
02:00.0 PCI bridge: nVidia Corporation Unknown device 05b1 (rev a2)
02:02.0 PCI bridge: nVidia Corporation Unknown device 05b1 (rev a2)
04:00.0 VGA compatible controller: nVidia Corporation GeForce 8800 GT (rev a2)
05:06.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture
(rev 12)
05:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller
(rev c0)
06:00.0 IDE interface: Marvell Technology Group Ltd. 88SE6121 SATA II
Controller (rev b2)


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
