From: eyurtese@abo.fi
Subject: Carrizo FCH SATA performance problems
Date: Sat, 03 Sep 2016 01:16:36 +0300
Message-ID: <20160903011636.xlu5lgp5kcs4w0wo@webmail3.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1;
        DelSp="Yes";
        format="flowed"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp5.abo.fi ([130.232.213.120]:48638 "EHLO smtp5.abo.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbcIBWXm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Fri, 2 Sep 2016 18:23:42 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

[1.] One line summary of the problem:

Bad disk performance with AMD Carrizo FCH controllers

[2.] Full description of the problem/report:

Find an AMD Carrizo laptop with a sata drive. Install
linux in virtualbox and test performance with sysbench with
diskio benchmarking.

Then install linux natively on a partition and boot
the latest mainline kernel then run sysbench again. Linux
kernel running directly on AMD Carrizo performs 1/3rd to 1/10th
performance of linux on virtualbox.

For example:

* Linux Guest in VirtualBox *

Operations performed: 317520 Read, 211680 Write, 677315 Other = 1206515 Total
Read 4.845Gb Written 3.23Gb Total transferred 8.075Gb (27.562Mb/sec)
  1764.00 Requests/sec executed

Test execution summary:
     total time: 300.0004s
     total number of events: 529200
     total time taken by event execution: 78.9470
     per-request statistics:
          min: 0.01ms
          avg: 0.15ms
          max: 26.87ms
          approx. 95 percentile: 0.34ms

Threads fairness:
     events (avg/stddev): 529200.0000/0.00
     execution time (avg/stddev): 78.9470/0.00



* Native Linux *

Operations performed: 15360 Read, 10240 Write, 32675 Other = 58275 Total
Read 240Mb Written 160Mb Total transferred 400Mb (1.3333Mb/sec)
    85.33 Requests/sec executed

Test execution summary:
     total time: 300.0046s
     total number of events: 25600
     total time taken by event execution: 181.6251
     per-request statistics:
          min: 0.01ms
          avg: 7.09ms
          max: 73.11ms
          approx. 95 percentile: 17.50ms

Threads fairness:
     events (avg/stddev): 25600.0000/0.00
     execution time (avg/stddev): 181.6251/0.00

In addition, maybe it may be relevant:

The keyboard forgets keypresses. For example I can keep
my finger on CTRL then at the same time push C. It prints few ^C
characters then starts printing C character only.

The AMDGPU-PRO driver causes display corruption and crashes. At
one point it was showing screen from previous crashed session when
the machine rebooted. AMDGPU kernel module seem to function OK.

The touchpad is over sensitive and palm detection does not work.
It printed some disconnection messages at some point (cant remember
exactly what it said).

The wireless driver RT8723BE does not function due to an antenna
problem, needs the rtlwifi_new module from github with antenna
selection option.


Also, I had to boot the mainline kernel in recovery mode because
I could not login when I made a normal boot.

[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):

$ cat /proc/version
Linux version 4.8.0-040800rc4-generic (kernel@gomeisa) (gcc version  
6.2.0 20160824 (Ubuntu 6.2.0-1ubuntu12) ) #201608312129 SMP Thu Sep 1  
01:31:59 UTC 2016

Note: I tried few kernels back till 4.2.0-27 and results were same.

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
      problem (if possible)

sysbench --test=fileio --file-total-size=32G prepare
sysbench --test=fileio --file-total-size=32G --file-test-mode=rndrw  
--init-rng=on --max-time=300 --max-requests=0 run


[7.] Environment

$ lsb_release -rd
Description:	Ubuntu 16.04.1 LTS
Release:	16.04

[7.1.] Software (add the output of the ver_linux script here)

$ /usr/src/linux-headers-4.8.0-040800rc4/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux jobgo 4.8.0-040800rc4-generic #201608312129 SMP Thu Sep 1  
01:31:59 UTC 2016 x86_64 x86_64 x86_64 GNU/Linux

GNU C			5.4.0
GNU Make		4.1
Binutils		2.26.1
Util-linux		2.27.1
Mount			2.27.1
Linux C Library		2.23
Dynamic linker (ldd)	2.23
Procps			3.3.10
Kbd			1.15.5
Console-tools		1.15.5
Sh-utils		8.25
Udev			229
Modules Loaded		ablk_helper ac acpi_cpufreq aesni_intel aes_x86_64  
ahci arc4 async_memcpy async_pq async_raid6_recov async_tx async_xor  
autofs4 battery bluetooth btbcm btcoexist btintel btrfs btrtl btusb  
button ccm cdc_ether cdrom cfg80211 configfs crc16 crc32c_generic  
crc32c_intel crc32_pclmul crct10dif_pclmul cryptd ctr drm  
drm_kms_helper efi_pstore efivarfs efivars ehci_hcd ehci_pci evdev  
ext4 fam15h_power fat fjes fscrypto fuse gf128mul ghash_clmulni_intel  
glue_helper hp_accel hp_wireless hp_wmi i2c_algo_bit i2c_piix4 ib_cm  
ib_core ib_iser input_polldev irqbypass iscsi_tcp iw_cm jbd2 joydev  
k10temp kvm kvm_amd libahci libata libcrc32c libiscsi libiscsi_tcp  
linear lis3lv02d lrw mac80211 mbcache md_mod media memstick mfd_core  
mii mmc_core multipath nls_cp437 nls_utf8 psmouse r8169 raid0 raid10  
raid1 raid456 raid6_pq rdma_cm rfkill rndis_host rtl8723be  
rtl8723_common rtl_pci rtlwifi rtsx_pci rtsx_pci_ms rtsx_pci_sdmmc  
scsi_mod scsi_transport_iscsi sd_mod serio_raw sg shpchp snd  
snd_hda_codec snd_hda_codec_generic snd_hda_codec_hdmi  
snd_hda_codec_realtek snd_hda_core snd_hda_intel snd_hwdep snd_pcm  
snd_timer soundcore sparse_keymap sr_mod thermal tpm tpm_tis  
tpm_tis_core ttm usb_common usbcore usbnet uvcvideo vfat video  
videobuf2_core videobuf2_memops videobuf2_v4l2 videobuf2_vmalloc  
videodev wmi xhci_hcd xhci_pci xor

[7.2.] Processor information (from /proc/cpuinfo):

$ cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 96
model name	: AMD A10-8700P Radeon R6, 10 Compute Cores 4C+6G
stepping	: 1
microcode	: 0x6006110
cpu MHz		: 1300.000
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 16
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov  
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt  
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc  
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16  
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm  
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop  
skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb  
bpext ptsc mwaitx cpb hw_pstate vmmcall fsgsbase bmi1 avx2 smep bmi2  
xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean  
flushbyasid decodeassists pausefilter pfthreshold avic overflow_recov
bugs		: fxsave_leak sysret_ss_attrs null_seg
bogomips	: 3593.06
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro  
acc_power [13]

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 96
model name	: AMD A10-8700P Radeon R6, 10 Compute Cores 4C+6G
stepping	: 1
microcode	: 0x6006110
cpu MHz		: 1300.000
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 2
apicid		: 17
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov  
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt  
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc  
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16  
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm  
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop  
skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb  
bpext ptsc mwaitx cpb hw_pstate vmmcall fsgsbase bmi1 avx2 smep bmi2  
xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean  
flushbyasid decodeassists pausefilter pfthreshold avic overflow_recov
bugs		: fxsave_leak sysret_ss_attrs null_seg
bogomips	: 3592.19
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro  
acc_power [13]

processor	: 2
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 96
model name	: AMD A10-8700P Radeon R6, 10 Compute Cores 4C+6G
stepping	: 1
microcode	: 0x6006110
cpu MHz		: 1300.000
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 18
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov  
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt  
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc  
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16  
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm  
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop  
skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb  
bpext ptsc mwaitx cpb hw_pstate vmmcall fsgsbase bmi1 avx2 smep bmi2  
xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean  
flushbyasid decodeassists pausefilter pfthreshold avic overflow_recov
bugs		: fxsave_leak sysret_ss_attrs null_seg
bogomips	: 3592.19
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro  
acc_power [13]

processor	: 3
vendor_id	: AuthenticAMD
cpu family	: 21
model		: 96
model name	: AMD A10-8700P Radeon R6, 10 Compute Cores 4C+6G
stepping	: 1
microcode	: 0x6006110
cpu MHz		: 1300.000
cache size	: 1024 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 19
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov  
pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt  
pdpe1gb rdtscp lm constant_tsc rep_good acc_power nopl nonstop_tsc  
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 fma cx16  
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm  
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop  
skinit wdt lwp fma4 tce nodeid_msr tbm topoext perfctr_core perfctr_nb  
bpext ptsc mwaitx cpb hw_pstate vmmcall fsgsbase bmi1 avx2 smep bmi2  
xsaveopt arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean  
flushbyasid decodeassists pausefilter pfthreshold avic overflow_recov
bugs		: fxsave_leak sysret_ss_attrs null_seg
bogomips	: 3592.19
TLB size	: 1536 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 48 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro  
acc_power [13]

[7.3.] Module information (from /proc/modules):

$ cat /proc/modules
rndis_host 16384 0 - Live 0x0000000000000000
cdc_ether 16384 1 rndis_host, Live 0x0000000000000000
usbnet 45056 2 rndis_host,cdc_ether, Live 0x0000000000000000
ctr 16384 0 - Live 0x0000000000000000
ccm 20480 0 - Live 0x0000000000000000
fuse 98304 3 - Live 0x0000000000000000
nls_utf8 16384 1 - Live 0x0000000000000000
nls_cp437 20480 1 - Live 0x0000000000000000
vfat 20480 1 - Live 0x0000000000000000
fat 69632 1 vfat, Live 0x0000000000000000
uvcvideo 90112 0 - Live 0x0000000000000000
hp_wmi 16384 0 - Live 0x0000000000000000
sparse_keymap 16384 1 hp_wmi, Live 0x0000000000000000
kvm_amd 73728 0 - Live 0x0000000000000000
kvm 593920 1 kvm_amd, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
videobuf2_vmalloc 16384 1 uvcvideo, Live 0x0000000000000000
irqbypass 16384 1 kvm, Live 0x0000000000000000
rtl8723be 90112 0 - Live 0x0000000000000000
btusb 45056 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btcoexist 53248 1 rtl8723be, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
btintel 16384 1 btusb, Live 0x0000000000000000
videobuf2_memops 16384 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_v4l2 24576 1 uvcvideo, Live 0x0000000000000000
videobuf2_core 40960 2 uvcvideo,videobuf2_v4l2, Live 0x0000000000000000
rtl8723_common 24576 1 rtl8723be, Live 0x0000000000000000
bluetooth 544768 5 btusb,btrtl,btbcm,btintel, Live 0x0000000000000000
rtl_pci 28672 1 rtl8723be, Live 0x0000000000000000
videodev 176128 3 uvcvideo,videobuf2_v4l2,videobuf2_core, Live  
0x0000000000000000
rtlwifi 77824 2 rtl8723be,rtl_pci, Live 0x0000000000000000
mac80211 663552 3 rtl8723be,rtl_pci,rtlwifi, Live 0x0000000000000000
media 40960 2 uvcvideo,videodev, Live 0x0000000000000000
cfg80211 589824 2 rtlwifi,mac80211, Live 0x0000000000000000
snd_hda_codec_realtek 86016 1 - Live 0x0000000000000000
snd_hda_codec_generic 69632 1 snd_hda_codec_realtek, Live 0x0000000000000000
snd_hda_codec_hdmi 45056 1 - Live 0x0000000000000000
efi_pstore 16384 0 - Live 0x0000000000000000
snd_hda_intel 36864 5 - Live 0x0000000000000000
snd_hda_codec 131072 4  
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,  
Live 0x0000000000000000
joydev 20480 0 - Live 0x0000000000000000
rfkill 24576 4 hp_wmi,bluetooth,cfg80211, Live 0x0000000000000000
rtsx_pci_ms 20480 0 - Live 0x0000000000000000
serio_raw 16384 0 - Live 0x0000000000000000
memstick 20480 1 rtsx_pci_ms, Live 0x0000000000000000
efivars 20480 1 efi_pstore, Live 0x0000000000000000
sg 32768 0 - Live 0x0000000000000000
snd_hda_core 81920 5  
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live  
0x0000000000000000
snd_hwdep 16384 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 110592 4  
snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core, Live  
0x0000000000000000
k10temp 16384 0 - Live 0x0000000000000000
fam15h_power 16384 0 - Live 0x0000000000000000
i2c_piix4 24576 0 - Live 0x0000000000000000
acpi_cpufreq 20480 0 - Live 0x0000000000000000
tpm_tis 16384 0 - Live 0x0000000000000000
snd_timer 32768 1 snd_pcm, Live 0x0000000000000000
tpm_tis_core 20480 1 tpm_tis, Live 0x0000000000000000
battery 16384 0 - Live 0x0000000000000000
snd 86016 18  
snd_hda_codec_realtek,snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_timer, Live  
0x0000000000000000
tpm 45056 2 tpm_tis,tpm_tis_core, Live 0x0000000000000000
hp_accel 28672 0 - Live 0x0000000000000000
lis3lv02d 20480 1 hp_accel, Live 0x0000000000000000
input_polldev 16384 1 lis3lv02d, Live 0x0000000000000000
evdev 24576 26 - Live 0x0000000000000000
shpchp 36864 0 - Live 0x0000000000000000
soundcore 16384 1 snd, Live 0x0000000000000000
hp_wireless 16384 0 - Live 0x0000000000000000
ac 16384 0 - Live 0x0000000000000000
ib_iser 49152 0 - Live 0x0000000000000000
rdma_cm 57344 1 ib_iser, Live 0x0000000000000000
iw_cm 49152 1 rdma_cm, Live 0x0000000000000000
ib_cm 45056 1 rdma_cm, Live 0x0000000000000000
ib_core 208896 4 ib_iser,rdma_cm,iw_cm,ib_cm, Live 0x0000000000000000
configfs 40960 2 rdma_cm, Live 0x0000000000000000
iscsi_tcp 20480 0 - Live 0x0000000000000000
libiscsi_tcp 24576 1 iscsi_tcp, Live 0x0000000000000000
libiscsi 53248 3 ib_iser,iscsi_tcp,libiscsi_tcp, Live 0x0000000000000000
scsi_transport_iscsi 98304 4 ib_iser,iscsi_tcp,libiscsi, Live  
0x0000000000000000
efivarfs 16384 1 - Live 0x0000000000000000
autofs4 40960 2 - Live 0x0000000000000000
ext4 589824 1 - Live 0x0000000000000000
crc16 16384 2 bluetooth,ext4, Live 0x0000000000000000
jbd2 110592 1 ext4, Live 0x0000000000000000
fscrypto 28672 1 ext4, Live 0x0000000000000000
mbcache 16384 2 ext4, Live 0x0000000000000000
btrfs 1048576 0 - Live 0x0000000000000000
raid10 49152 0 - Live 0x0000000000000000
raid456 110592 0 - Live 0x0000000000000000
async_raid6_recov 20480 1 raid456, Live 0x0000000000000000
async_memcpy 16384 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_pq 16384 2 raid456,async_raid6_recov, Live 0x0000000000000000
async_xor 16384 3 raid456,async_raid6_recov,async_pq, Live 0x0000000000000000
async_tx 16384 5  
raid456,async_raid6_recov,async_memcpy,async_pq,async_xor, Live  
0x0000000000000000
xor 24576 2 btrfs,async_xor, Live 0x0000000000000000
raid6_pq 102400 4 btrfs,raid456,async_raid6_recov,async_pq, Live  
0x0000000000000000
libcrc32c 16384 1 raid456, Live 0x0000000000000000
crc32c_generic 16384 0 - Live 0x0000000000000000
raid1 36864 0 - Live 0x0000000000000000
raid0 20480 0 - Live 0x0000000000000000
multipath 16384 0 - Live 0x0000000000000000
linear 16384 0 - Live 0x0000000000000000
md_mod 131072 6 raid10,raid456,raid1,raid0,multipath,linear, Live  
0x0000000000000000
sr_mod 24576 0 - Live 0x0000000000000000
cdrom 61440 1 sr_mod, Live 0x0000000000000000
sd_mod 45056 4 - Live 0x0000000000000000
rtsx_pci_sdmmc 24576 0 - Live 0x0000000000000000
mmc_core 143360 1 rtsx_pci_sdmmc, Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
crc32c_intel 24576 2 - Live 0x0000000000000000
ghash_clmulni_intel 16384 0 - Live 0x0000000000000000
aesni_intel 167936 0 - Live 0x0000000000000000
aes_x86_64 20480 1 aesni_intel, Live 0x0000000000000000
lrw 16384 1 aesni_intel, Live 0x0000000000000000
gf128mul 16384 1 lrw, Live 0x0000000000000000
glue_helper 16384 1 aesni_intel, Live 0x0000000000000000
ablk_helper 16384 1 aesni_intel, Live 0x0000000000000000
cryptd 24576 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live  
0x0000000000000000
ahci 36864 3 - Live 0x0000000000000000
libahci 32768 1 ahci, Live 0x0000000000000000
psmouse 131072 0 - Live 0x0000000000000000
libata 249856 2 ahci,libahci, Live 0x0000000000000000
ehci_pci 16384 0 - Live 0x0000000000000000
ehci_hcd 81920 1 ehci_pci, Live 0x0000000000000000
xhci_pci 16384 0 - Live 0x0000000000000000
scsi_mod 225280 8  
sg,ib_iser,iscsi_tcp,libiscsi,scsi_transport_iscsi,sr_mod,sd_mod,libata, Live  
0x0000000000000000
xhci_hcd 188416 1 xhci_pci, Live 0x0000000000000000
rtsx_pci 57344 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
mfd_core 16384 1 rtsx_pci, Live 0x0000000000000000
r8169 81920 0 - Live 0x0000000000000000
usbcore 253952 9  
rndis_host,cdc_ether,usbnet,uvcvideo,btusb,ehci_pci,ehci_hcd,xhci_pci,xhci_hcd, Live  
0x0000000000000000
mii 16384 2 usbnet,r8169, Live 0x0000000000000000
usb_common 16384 1 usbcore, Live 0x0000000000000000
i2c_algo_bit 16384 0 - Live 0x0000000000000000
ttm 98304 0 - Live 0x0000000000000000
drm_kms_helper 155648 0 - Live 0x0000000000000000
drm 360448 2 ttm,drm_kms_helper, Live 0x0000000000000000
video 40960 0 - Live 0x0000000000000000
wmi 16384 1 hp_wmi, Live 0x0000000000000000
fjes 28672 0 - Live 0x0000000000000000
thermal 20480 0 - Live 0x0000000000000000
button 16384 0 - Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports
0000-0000 : PCI Bus 0000:00
   0000-0000 : dma1
   0000-0000 : pic1
   0000-0000 : timer0
   0000-0000 : timer1
   0000-0000 : keyboard
   0000-0000 : PNP0800:00
   0000-0000 : PNP0C09:00
     0000-0000 : EC data
   0000-0000 : keyboard
   0000-0000 : PNP0C09:00
     0000-0000 : EC cmd
   0000-0000 : rtc0
   0000-0000 : dma page reg
   0000-0000 : pic2
   0000-0000 : dma2
   0000-0000 : PNP0C04:00
     0000-0000 : fpu
0000-0000 : PCI Bus 0000:00
0000-0000 : PCI Bus 0000:00
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
     0000-0000 : ACPI PM1a_EVT_BLK
     0000-0000 : ACPI PM1a_CNT_BLK
     0000-0000 : ACPI PM_TMR
     0000-0000 : ACPI CPU throttle
     0000-0000 : ACPI GPE0_BLK
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : piix4_smbus
   0000-0000 : SMB0001:00
     0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
   0000-0000 : pnp 00:06
     0000-0000 : smba_idx
   0000-0000 : pnp 00:06
0000-0000 : PCI conf1
0000-0000 : PCI Bus 0000:00
   0000-0000 : PCI Bus 0000:04
     0000-0000 : 0000:04:00.0
   0000-0000 : PCI Bus 0000:03
     0000-0000 : 0000:03:00.0
       0000-0000 : rtl_pci
   0000-0000 : PCI Bus 0000:02
     0000-0000 : 0000:02:00.0
       0000-0000 : r8169
   0000-0000 : 0000:00:01.0
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : 0000:00:11.0
     0000-0000 : ahci
   0000-0000 : pnp 00:06

$ cat /proc/iomem
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : PCI Bus 0000:00
00000000-00000000 : System ROM
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : ACPI Tables
00000000-00000000 : ACPI Non-volatile Storage
00000000-00000000 : reserved
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : reserved
00000000-00000000 : System RAM
00000000-00000000 : RAM buffer
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : 0000:00:01.0
     00000000-00000000 : BOOTFB
   00000000-00000000 : PCI Bus 0000:04
     00000000-00000000 : 0000:04:00.0
     00000000-00000000 : 0000:04:00.0
   00000000-00000000 : PCI Bus 0000:03
   00000000-00000000 : 0000:00:01.0
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : PCI MMCONFIG 0000 [bus 00-3f]
     00000000-00000000 : reserved
       00000000-00000000 : pnp 00:00
   00000000-00000000 : pnp 00:06
   00000000-00000000 : reserved
     00000000-00000000 : amd_iommu
     00000000-00000000 : IOAPIC 0
     00000000-00000000 : IOAPIC 1
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:06
   00000000-00000000 : reserved
     00000000-00000000 : HPET 0
       00000000-00000000 : PNP0103:00
00000000-00000000 : reserved
00000000-00000000 : pnp 00:06
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:06
00000000-00000000 : reserved
   00000000-00000000 : pnp 00:06
00000000-00000000 : reserved
00000000-00000000 : PCI Bus 0000:00
   00000000-00000000 : Local APIC
     00000000-00000000 : pnp 00:06
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : PCI Bus 0000:04
     00000000-00000000 : 0000:04:00.0
     00000000-00000000 : 0000:04:00.0
   00000000-00000000 : PCI Bus 0000:03
     00000000-00000000 : 0000:03:00.0
       00000000-00000000 : rtl_pci
   00000000-00000000 : PCI Bus 0000:02
     00000000-00000000 : 0000:02:00.0
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : r8169
     00000000-00000000 : 0000:02:00.0
       00000000-00000000 : r8169
   00000000-00000000 : PCI Bus 0000:01
     00000000-00000000 : 0000:01:00.0
       00000000-00000000 : rtsx_pci
   00000000-00000000 : 0000:00:01.0
   00000000-00000000 : 0000:00:09.2
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:01.1
     00000000-00000000 : ICH HD audio
   00000000-00000000 : 0000:00:10.0
     00000000-00000000 : xhci-hcd
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : 0000:00:12.0
     00000000-00000000 : ehci_hcd
   00000000-00000000 : 0000:00:11.0
     00000000-00000000 : ahci
   00000000-00000000 : 0000:00:08.0
   00000000-00000000 : reserved
     00000000-00000000 : pnp 00:06
00000000-00000000 : System RAM
   00000000-00000000 : Kernel code
   00000000-00000000 : Kernel data
   00000000-00000000 : Kernel bss
00000000-00000000 : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)

# lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1576
	Subsystem: Hewlett-Packard Company Device 80b5
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Device 1577
	Subsystem: Hewlett-Packard Company Device 80b5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 24
	Capabilities: [40] Secure device <?>
	Capabilities: [64] MSI: Enable+ Count=1/4 Maskable- 64bit+
		Address: 00000000fee0f00c  Data: 4171
	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.  
[AMD/ATI] Carrizo (rev c5) (prog-if 00 [VGA controller])
	Subsystem: Hewlett-Packard Company Carrizo
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at d0000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at f0800000 (64-bit, prefetchable) [size=8M]
	Region 4: I/O ports at f000 [size=256]
	Region 5: Memory at ff700000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at 000c0000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF  
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] #19
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] #13
	Capabilities: [2d0 v1] #1b
	Kernel modules: amdgpu

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Kabini  
HDMI/DP Audio
	Subsystem: Hewlett-Packard Company Kabini HDMI/DP Audio
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin B routed to IRQ 47
	Region 0: Memory at ff764000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF  
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
	DeviceName:  Onboard IGD
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ff600000-ff6fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1, Exit Latency  
L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+  
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not  
Supported ARIFwd-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF  
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Subsystem: Hewlett-Packard Company Device 80b5
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 25
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: ff500000-ff5fffff
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 2.5GT/s, Width x2, ASPM L0s L1, Exit Latency  
L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+  
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not  
Supported ARIFwd-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF  
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] Subsystem: Hewlett-Packard Company Device 80b5
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 26
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ff400000-ff4fffff
	Prefetchable memory behind bridge: 00000000f0200000-00000000f03fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #2, Speed 2.5GT/s, Width x2, ASPM L0s L1, Exit Latency  
L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive+  
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not  
Supported ARIFwd-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF  
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Hewlett-Packard Company Device 80b5
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157b
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:03.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Device 157c  
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 28
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ff300000-ff3fffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000f01fffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x8, ASPM L0s L1, Exit Latency  
L0s <512ns, L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive+  
BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
			Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisible+
		RootCap: CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, OBFF Not  
Supported ARIFwd-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis-, LTR-, OBFF  
Disabled ARIFwd-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis+
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Hewlett-Packard Company Device 80b5
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [270 v1] #19
	Kernel driver in use: pcieport
	Kernel modules: shpchp

00:08.0 Encryption controller: Advanced Micro Devices, Inc. [AMD] Device 1578
	Subsystem: Hewlett-Packard Company Device 80b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at f1000000 (64-bit, prefetchable) [size=128K]
	Region 2: Memory at ff200000 (32-bit, non-prefetchable) [size=1M]
	Region 3: Memory at ff76f000 (32-bit, non-prefetchable) [size=4K]
	Region 5: Memory at ff76a000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [50] MSI-X: Enable- Count=2 Masked-
		Vector table: BAR=5 offset=00000000
		PBA: BAR=5 offset=00001000
	Capabilities: [5c] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR-
		AFCtrl: FLR-
		AFStatus: TP-

00:09.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 157d
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:09.2 Audio device: Advanced Micro Devices, Inc. [AMD] Device 157a
	Subsystem: Hewlett-Packard Company Device 80b5
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at ff760000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a4] PCI Advanced Features
		AFCap: TP+ FLR-
		AFCtrl: FLR-
		AFStatus: TP-
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB  
XHCI Controller (rev 20) (prog-if 30 [XHCI])
	Subsystem: Hewlett-Packard Company FCH USB XHCI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at ff768000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [90] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=00001000
		PBA: BAR=0 offset=00001080
	Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF  
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
	Capabilities: [100 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA  
Controller [AHCI mode] (rev 49) (prog-if 01 [AHCI 1.0])
	Subsystem: Hewlett-Packard Company FCH SATA Controller [AHCI mode]
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx+
	Latency: 32
	Interrupt: pin A routed to IRQ 38
	Region 0: I/O ports at f140 [size=8]
	Region 1: I/O ports at f130 [size=4]
	Region 2: I/O ports at f120 [size=8]
	Region 3: I/O ports at f110 [size=4]
	Region 4: I/O ports at f100 [size=16]
	Region 5: Memory at ff76d000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [60] Power Management version 3
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [70] SATA HBA v1.0 InCfgSpace
	Capabilities: [50] MSI: Enable+ Count=8/8 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Kernel driver in use: ahci
	Kernel modules: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB  
EHCI Controller (rev 49) (prog-if 20 [EHCI])
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH USB EHCI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 32, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at ff76c000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [e4] Debug port: BAR=1 offset=00e0
	Kernel driver in use: ehci-pci
	Kernel modules: ehci_pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller  
(rev 4a)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 11)
	Subsystem: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1570
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1571
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1572
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1573
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Capabilities: [f0] Secure device <?>
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1574
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Kernel driver in use: fam15h_power
	Kernel modules: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1575
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.  
RTS5229 PCI Express Card Reader (rev 01)
	DeviceName: Realtek PCIE CardReader
	Subsystem: Hewlett-Packard Company RTS5229 PCI Express Card Reader
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 32
	Region 0: Memory at ff600000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1  
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency  
L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-  
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF  
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+  
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
	Kernel driver in use: rtsx_pci
	Kernel modules: rtsx_pci

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  
RTL8101/2/6E PCI Express Fast/Gigabit Ethernet controller (rev 07)
	DeviceName: Realtek PCIe FE Family Controller
	Subsystem: Hewlett-Packard Company RTL8101/2/6E PCI Express  
Fast/Gigabit Ethernet controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 30
	Region 0: I/O ports at e000 [size=256]
	Region 2: Memory at ff514000 (64-bit, prefetchable) [size=4K]
	Region 4: Memory at ff510000 (64-bit, prefetchable) [size=16K]
	Expansion ROM at ff500000 [disabled] [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency  
L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-  
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, OBFF Via  
message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
		Not readable
	Capabilities: [100 v1] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+  
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=01
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Kernel driver in use: r8169
	Kernel modules: r8169

03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE  
PCIe Wireless Network Adapter
	DeviceName: Realtek RTL8723BE 802.11b/g/n Wi-Fi + BT 4.0 Combo Adapter
	Subsystem: Hewlett-Packard Company RTL8723BE PCIe Wireless Network Adapter
	Physical Slot: 0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ 49
	Region 0: I/O ports at d000 [size=256]
	Region 2: Memory at ff400000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency  
L0s <512ns, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
		LnkCtl:	ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive-  
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, OBFF  
Via message/WAKE#
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+  
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [140 v1] Device Serial Number 00-23-b7-fe-ff-4c-e0-00
	Capabilities: [150 v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [158 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
	Kernel driver in use: rtl8723be
	Kernel modules: rtl8723be

04:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI]  
Topaz XT [Radeon R7 M260/M265] (rev 81)
	DeviceName: AMD Radeon (TM) R7 M260
	Subsystem: Hewlett-Packard Company Topaz XT [Radeon R7 M260/M265]
	Physical Slot: 0-1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-  
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-  
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	Region 0: Memory at e0000000 (64-bit, prefetchable) [disabled] [size=256M]
	Region 2: Memory at f0000000 (64-bit, prefetchable) [disabled] [size=2M]
	Region 4: I/O ports at c000 [disabled] [size=256]
	Region 5: Memory at ff300000 (32-bit, non-prefetchable) [disabled]  
[size=256K]
	Expansion ROM at ff340000 [disabled] [size=128K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x8, ASPM L0s L1, Exit Latency  
L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x8, TrErr- Train- SlotClk+ DLActive-  
BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-, OBFF  
Not Supported
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance-  
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-,  
EqualizationPhase1-
			 EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
	Capabilities: [150 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-  
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+  
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
		AERCap:	First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
	Capabilities: [270 v1] #19
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] #13
	Capabilities: [2d0 v1] #1b
	Kernel modules: amdgpu


[7.6.] SCSI information (from /proc/scsi/scsi)

$ cat /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory


[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

$ ls /proc
1     22    3493  3820  3947  4439  725        driver       pagetypeinfo
10    23    3494  3827  3948  4564  75         execdomains  partitions
11    25    3499  3863  3951  47    753        fb           sched_debug
1137  2555  35    3866  396   4774  760        filesystems  self
12    26    3500  3867  3977  4779  761        fs           slabinfo
13    27    3523  3877  3983  4783  772        interrupts   softirqs
137   2735  3525  3881  3986  4785  8          iomem        stat
14    28    3528  3884  3989  4791  845        ioports      swaps
15    2864  3533  3885  3991  48    882        irq          sys
16    2865  3571  3887  40    4812  9          kallsyms     sysrq-trigger
18    2867  3576  3888  400   4813  913        kcore        sysvipc
1840  2883  3590  3890  4004  4814  948        keys         thread-self
1875  29    3594  3894  4010  4815  949        key-users    timer_list
2     3     3597  39    4032  4817  989        kmsg         timer_stats
20    31    36    3900  4037  4819  acpi       kpagecgroup  tty
2013  32    3623  3902  4039  4821  asound     kpagecount   uptime
2017  33    3692  3916  404   49    buddyinfo  kpageflags   version
2018  3324  37    392   4054  5     bus        loadavg      vmallocinfo
2019  34    3702  3925  4086  50    cgroups    locks        vmstat
2020  343   3772  393   41    51    cmdline    mdstat       zoneinfo
2021  3437  3773  3933  42    52    consoles   meminfo
2022  3438  3774  3934  4204  67    cpuinfo    misc
2023  3474  3775  3936  4220  68    crypto     modules
2024  348   3776  3939  43    7     devices    mounts
2081  3485  38    3942  4347  70    diskstats  mtrr
21    3491  3819  3945  4355  724   dma        net


[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1616830



