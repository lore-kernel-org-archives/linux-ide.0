From: Chris Bruner <cryst@golden.net>
Subject: ide lockup
Date: Sat, 6 Sep 2003 12:29:00 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200309061229.00331.cryst@golden.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MtgW/oZ3hGuKgXA"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newsmtp.golden.net ([199.166.210.106]:8202 "EHLO
	newsmtp.golden.net") by vger.kernel.org with ESMTP id S261352AbTIFQ0P
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Sep 2003 12:26:15 -0400
Received: from 183-55.speede.golden.net ([216.75.183.55] helo=localhost)
	by newsmtp.golden.net with esmtp (Exim 4.22)
	id 19vft5-00075n-PI
	for linux-ide@vger.kernel.org; Sat, 06 Sep 2003 12:26:11 -0400
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


I am having an occasional problem with the 2.57 through 2.6.0-test3-mm3  (I 
haven't tested pre 2.57). The problem never occured under 2.4 series so I'm 
guessing that it's something new. 

The problem is that occasionally the light on the hard disk lights up, and 
stays on. I then can't access the hard disk, although I can still type. 

There is no log file created as far as I know, and I'm not sure how to 
diagonois this further.

I've included some of the /proc files (including the ikconfig directory) in 
the hopes that this give a clue. Let me know if there is anything else I can 
provide.

Chris Bruner


-- 
I WILL NOT SPIN THE TURTLE
I WILL NOT SPIN THE TURTLE
I WILL NOT SPIN THE TURTLE
I WILL NOT SPIN THE TURTLE

	Bart Simpson on chalkboard in episode 8F21

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="dma"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dma"

 4: cascade

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="misc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="misc"

  1 psaux
175 agpgart

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="modules"

nvidia 1701580 10 - Live 0xdbad1000

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="mounts"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mounts"

rootfs / rootfs rw 0 0
/dev/root / reiserfs rw,noatime 0 0
none /dev devfs rw 0 0
none /proc proc rw 0 0
none /sys sysfs rw 0 0
none /dev/pts devpts rw 0 0
/dev/hda1 /mnt/win_c vfat rw,nosuid,nodev,noexec,gid=1001,fmask=0000,dmask=0000,codepage=cp437 0 0
/dev/hda2 /mnt/win_e vfat rw,nosuid,nodev,noexec,gid=1001,fmask=0000,dmask=0000,codepage=cp437 0 0
/dev/hdb1 /mnt/win_d vfat rw,nosuid,nodev,noexec,gid=1001,fmask=0000,dmask=0000,codepage=cp437 0 0
none /dev/shm tmpfs rw 0 0
none /proc/bus/usb usbfs rw 0 0

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="mtrr"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mtrr"

reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0x10000000 ( 256MB), size= 128MB: write-back, count=1
reg02: base=0xfc000000 (4032MB), size=  32MB: write-combining, count=1
reg03: base=0xf8000000 (3968MB), size=  64MB: write-combining, count=1

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="partitions"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="partitions"

major minor  #blocks  name

   3     0   39121488 hda
   3     1    5630751 hda1
   3     2   16442527 hda2
   3     3          1 hda3
   3     5      16033 hda5
   3     6   17028868 hda6
   3    64   20016348 hdb
   3    65   19269936 hdb1
   3    66          1 hdb2
   3    69      16033 hdb5
   3    70     722893 hdb6

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="pci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pci"

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX/DX - 82443B (rev 3).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX/DX - 82443B (rev 3).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4  (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4  (rev 1).
      Master Capable.  Latency=64.  
      I/O at 0x1060 [0x106f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4  (rev 1).
      IRQ 9.
      Master Capable.  Latency=64.  
      I/O at 0x1000 [0x101f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4  (rev 2).
      IRQ 9.
  Bus  0, device  12, function  0:
    Multimedia audio controller: Yamaha Corporation YMF-740C [DS-1L Audi (rev 3).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=5.Max Lat=25.
      Non-prefetchable 32 bit memory at 0xf4000000 [0xf4007fff].
  Bus  0, device  14, function  0:
    Ethernet controller: Realtek Semiconducto RTL-8029(AS) (rev 0).
      IRQ 5.
      I/O at 0x1020 [0x103f].
  Bus  0, device  15, function  0:
    Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 5).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=20.
      I/O at 0x1040 [0x105f].
  Bus  0, device  15, function  1:
    Input device controller: Creative Labs SB Live! MIDI/Game P (rev 5).
      Master Capable.  Latency=64.  
      I/O at 0x1070 [0x1077].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64 (rev 17).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5ffffff].
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="slabinfo"

slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
rpc_buffers            8      8   2048    2    1 : tunables   24   12    0 : slabdata      4      4      0
rpc_tasks              8     24    160   24    1 : tunables  120   60    0 : slabdata      1      1      0
rpc_inode_cache        0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
unix_sock            264    264    352   11    1 : tunables   54   27    0 : slabdata     24     24      0
tcp_tw_bucket          1     40     96   40    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket        7    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          14     15    256   15    1 : tunables  120   60    0 : slabdata      1      1      0
arp_cache              4     30    128   30    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               1      9    416    9    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              11     18    832    9    2 : tunables   54   27    0 : slabdata      2      2      0
flow_cache             0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
uhci_urb_priv          0      0     60   63    1 : tunables  120   60    0 : slabdata      0      0      0
udf_inode_cache        0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
reiser_inode_cache  19610  19610    384   10    1 : tunables   54   27    0 : slabdata   1961   1961      0
cifs_request           0      0  16640    1    8 : tunables    8    4    0 : slabdata      0      0      0
cifs_oplock_structs      0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
cifs_mpx_ids           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
cifs_inode_cache       0      0    384   10    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_write_data        36     36    416    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_read_data         32     36    416    9    1 : tunables   54   27    0 : slabdata      4      4      0
nfs_inode_cache        0      0    608    6    1 : tunables   54   27    0 : slabdata      0      0      0
nfs_page               0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
devfsd_event           0      0     20  169    1 : tunables  120   60    0 : slabdata      0      0      0
isofs_inode_cache      0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        3     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
ext2_inode_cache       0      0    448    9    1 : tunables   54   27    0 : slabdata      0      0      0
ext2_xattr             0      0     44   84    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_pwq          0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   24    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0    224   17    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        189    338     20  169    1 : tunables  120   60    0 : slabdata      2      2      0
file_lock_cache        3     42     92   42    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           1    202     16  202    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache     17     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
idr_layer_cache        0      0    136   28    1 : tunables  120   60    0 : slabdata      0      0      0
posix_timers_cache      0      0     80   48    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              2    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
cfq_pool              64    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  101    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   78    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq                36     63     60   63    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_requests       26     26    152   26    1 : tunables  120   60    0 : slabdata      1      1      0
biovec-BIO_MAX_PAGES    256    260   3072    5    4 : tunables   24   12    0 : slabdata     52     52      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    295     64   59    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             272    404     16  202    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  272    295     64   59    1 : tunables  120   60    0 : slabdata      5      5      0
sock_inode_cache     280    280    384   10    1 : tunables   54   27    0 : slabdata     28     28      0
skbuff_head_cache    108    408    160   24    1 : tunables  120   60    0 : slabdata     17     17      0
sock                   2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     165    165    352   11    1 : tunables   54   27    0 : slabdata     15     15      0
sigqueue              27     27    144   27    1 : tunables  120   60    0 : slabdata      1      1      0
radix_tree_node     3360   3360    260   15    1 : tunables   54   27    0 : slabdata    224    224      0
bdev_cache          4026   4032    416    9    1 : tunables   54   27    0 : slabdata    448    448      0
mnt_cache             23     59     64   59    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         8404   8404    352   11    1 : tunables   54   27    0 : slabdata    764    764      0
dentry_cache       27192  27192    160   24    1 : tunables  120   60    0 : slabdata   1133   1133      0
filp                1860   1890    128   30    1 : tunables  120   60    0 : slabdata     63     63      0
names_cache            5      5   4096    1    1 : tunables   24   12    0 : slabdata      5      5      0
buffer_head         8424   8424     48   78    1 : tunables  120   60    0 : slabdata    108    108      0
mm_struct             63     63    416    9    1 : tunables   54   27    0 : slabdata      7      7      0
vm_area_struct      3949   4012     64   59    1 : tunables  120   60    0 : slabdata     68     68      0
fs_cache             109    113     32  113    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           63     63    416    9    1 : tunables   54   27    0 : slabdata      7      7      0
signal_cache         118    118     64   59    1 : tunables  120   60    0 : slabdata      2      2      0
sighand_cache         66     66   1312    3    1 : tunables   24   12    0 : slabdata     22     22      0
task_struct           80     80   1584    5    2 : tunables   24   12    0 : slabdata     16     16      0
pte_chain          30570  30623     32  113    1 : tunables  120   60    0 : slabdata    271    271      0
pgd                   59     59   4096    1    1 : tunables   24   12    0 : slabdata     59     59      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             4      4  65536    1   16 : tunables    8    4    0 : slabdata      4      4      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             1      1  32768    1    8 : tunables    8    4    0 : slabdata      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables    8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             77     77   8192    1    2 : tunables    8    4    0 : slabdata     77     77      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096             62     62   4096    1    1 : tunables   24   12    0 : slabdata     62     62      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048             21     24   2048    2    1 : tunables   24   12    0 : slabdata     12     12      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024             84     84   1024    4    1 : tunables   54   27    0 : slabdata     21     21      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             245    264    512    8    1 : tunables   54   27    0 : slabdata     33     33      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             195    195    256   15    1 : tunables  120   60    0 : slabdata     13     13      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             240    360    192   20    1 : tunables  120   60    0 : slabdata     18     18      0
size-128(DMA)          0      0    128   30    1 : tunables  120   60    0 : slabdata      0      0      0
size-128             238    240    128   30    1 : tunables  120   60    0 : slabdata      8      8      0
size-96(DMA)           0      0     96   40    1 : tunables  120   60    0 : slabdata      0      0      0
size-96             9160   9160     96   40    1 : tunables  120   60    0 : slabdata    229    229      0
size-64(DMA)           0      0     64   59    1 : tunables  120   60    0 : slabdata      0      0      0
size-64              944    944     64   59    1 : tunables  120   60    0 : slabdata     16     16      0
size-32(DMA)           0      0     32  113    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             3676   3729     32  113    1 : tunables  120   60    0 : slabdata     33     33      0
kmem_cache           132    132    116   33    1 : tunables  120   60    0 : slabdata      4      4      0

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="cpuinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cpuinfo"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 7
model name	: Pentium III (Katmai)
stepping	: 2
cpu MHz		: 449.009
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 886.78


--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="diskstats"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diskstats"

   2    0 fd0 0 0 0 0 0 0 0 0 0 0 0
   1    0 ram0 0 0 0 0 0 0 0 0 0 0 0
   1    1 ram1 0 0 0 0 0 0 0 0 0 0 0
   1    2 ram2 0 0 0 0 0 0 0 0 0 0 0
   1    3 ram3 0 0 0 0 0 0 0 0 0 0 0
   1    4 ram4 0 0 0 0 0 0 0 0 0 0 0
   1    5 ram5 0 0 0 0 0 0 0 0 0 0 0
   1    6 ram6 0 0 0 0 0 0 0 0 0 0 0
   1    7 ram7 0 0 0 0 0 0 0 0 0 0 0
   1    8 ram8 0 0 0 0 0 0 0 0 0 0 0
   1    9 ram9 0 0 0 0 0 0 0 0 0 0 0
   1   10 ram10 0 0 0 0 0 0 0 0 0 0 0
   1   11 ram11 0 0 0 0 0 0 0 0 0 0 0
   1   12 ram12 0 0 0 0 0 0 0 0 0 0 0
   1   13 ram13 0 0 0 0 0 0 0 0 0 0 0
   1   14 ram14 0 0 0 0 0 0 0 0 0 0 0
   1   15 ram15 0 0 0 0 0 0 0 0 0 0 0
   1  250 initrd 0 0 0 0 0 0 0 0 0 0 0
   7    0 loop0 0 0 0 0 0 0 0 0 0 0 0
   7    1 loop1 0 0 0 0 0 0 0 0 0 0 0
   7    2 loop2 0 0 0 0 0 0 0 0 0 0 0
   7    3 loop3 0 0 0 0 0 0 0 0 0 0 0
   7    4 loop4 0 0 0 0 0 0 0 0 0 0 0
   7    5 loop5 0 0 0 0 0 0 0 0 0 0 0
   7    6 loop6 0 0 0 0 0 0 0 0 0 0 0
   7    7 loop7 0 0 0 0 0 0 0 0 0 0 0
   3    0 hda 9493 250 260358 204127 2123 1829 31616 15914 0 86042 220041
   3    1 hda1 29 29 0 0
   3    2 hda2 35 35 0 0
   3    3 hda3 0 0 0 0
   3    5 hda5 8 8 0 0
   3    6 hda6 9668 260262 3952 31616
   3   64 hdb 39 0 67 72 0 0 0 0 0 72 72
   3   65 hdb1 35 35 0 0
   3   66 hdb2 0 0 0 0
   3   69 hdb5 0 0 0 0
   3   70 hdb6 1 8 0 0
  22    0 hdc 0 0 0 0 0 0 0 0 0 0 0
  22   64 hdd 1 0 8 644 0 0 0 0 0 644 644

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="devices"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="devices"

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
 29 fb
116 alsa
128 ptm
136 pts
180 usb
195 nvidia

Block devices:
  1 ramdisk
  2 fd
  3 ide0
  7 loop
 22 ide1

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: application/x-zerosize;
  name="built_with"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="built_with"

Kernel:    Linux 2.6.0-test4-mm4 #4 Thu Sep 4 01:04:44 EDT 2003 i686
Compiler:  gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)
Version_in_Makefile: 2.6.0-test4-mm4

--Boundary-00=_MtgW/oZ3hGuKgXA
Content-Type: text/plain;
  charset="us-ascii";
  name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="config"

CONFIG_BEGIN=n
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
# CONFIG_BROKEN is not set
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
CONFIG_MPENTIUMIII=y
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_HPET_TIMER=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCE_NONFATAL is not set
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
# CONFIG_X86_CPUID is not set
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_ACPI_HT is not set
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y
# CONFIG_CPU_FREQ is not set
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y
# CONFIG_MTD is not set
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_SERIAL=y
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
# CONFIG_LBD is not set
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=m
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_SCSI is not set
# CONFIG_CD_NO_IDESCSI is not set
# CONFIG_MD is not set
# CONFIG_IEEE1394 is not set
# CONFIG_I2O is not set
CONFIG_NET=y
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=y
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_WAN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_ISDN_BOOL is not set
# CONFIG_PHONE is not set
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_PS2_SYNAPTICS is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_UINPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set
# CONFIG_I2C is not set
# CONFIG_I2C_SENSOR is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_FTAPE is not set
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
# CONFIG_AGP_AMD is not set
# CONFIG_AGP_AMD_8151 is not set
CONFIG_AGP_INTEL=y
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set
# CONFIG_VIDEO_DEV is not set
# CONFIG_DVB is not set
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
# CONFIG_EXT2_FS_POSIX_ACL is not set
# CONFIG_EXT2_FS_SECURITY is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=m
# CONFIG_SMB_NLS_DEFAULT is not set
CONFIG_CIFS=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_VESA is not set
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
CONFIG_FB_RIVA=y
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=m
CONFIG_PCI_CONSOLE=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_DUMMY is not set
CONFIG_SND_VIRMIDI=m
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
CONFIG_SND_YMFPCI=y
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set
CONFIG_SND_USB_AUDIO=y
# CONFIG_SOUND_PRIME is not set
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_HID is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_AX8817X is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set
# CONFIG_BT is not set
# CONFIG_PROFILING is not set
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
# CONFIG_SECURITY is not set
# CONFIG_CRYPTO is not set
CONFIG_CRC32=m
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_END=n

--Boundary-00=_MtgW/oZ3hGuKgXA--

