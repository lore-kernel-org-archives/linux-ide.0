From: "Roger Heflin" <rheflin@atipa.com>
Subject: Seagate NCQ and Sata_Sil issues on 2.6.12
Date: Tue, 21 Jun 2005 16:26:23 -0500
Message-ID: <EXCHG2003f7nIh95XXZ000001e4@EXCHG2003.microtech-ks.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:59976 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S262538AbVFUVYg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jun 2005 17:24:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I have been trying to get a Sata SIL 3114 controller to work with
seagate 200GB disks (NCQ) on 2.6.12, with it has the boot disk,
I get massive pauses while a dd is running off of the boot disk,
the pauses are bad enough that typing the login name, results in
the password prompt never coming up (or at least not coming up
in 30+ seconds) without the dd being stopped, stopping the dd 
results in the password prompt coming up.   The behaviour is also
seen when you run any command in another window that is not expected
to be in the disk cache, the command hangs until the dd is stopped,
the performance is bad enough that I would expect the performance
to be unacceptable/non-existant under high disk loads.

Removing the disk from the blacklist appears to correct the issue,
this is with the disk not booting, I did not test the disk 
booting/installing with it removed from the blacklist.

The behavior does not seem to happen with the fedora core 3 kernel
in non-smp mode, thought the fedora core 3 kernel in smp mode has
other serious issues with our setup that results in us not being
able to test fc3 smp mode.

Here is the output from vmstat 1 for a WD and a Seagate drive with
the dd running:

The 19xxx runs are the seagate disk, the 58xxx runs are the Western disks.
 
The Western digital disk is roughly 3x as fast as the seagate
with 1/4 the interrupts, and with 1/10 of the context switches.   
This agrees with what others have seen around the seagates.
 
 
Seagate stock 2.6.12 kernel:
 0  1      0 6008384  72060 1160860    0    0 19840     0 5985 10000  0  9
75 16
 0  1      0 5988048  92028 1160912    0    0 19968     0 5989 10006  0  9
75 16
 0  1      0 5967588 111996 1160964    0    0 19968     0 5984  9994  0  9
75 16
 0  1      0 5947252 131836 1160884    0    0 19840     0 5989 10014  0  9
75 16
 0  1      0 5926792 151808 1160672    0    0 19968    28 5986 10003  0  9
75 16
 0  1      0 5906332 171776 1160724    0    0 19968     0 5982  9999  0  9
75 16
 0  1      0 5885996 191616 1160904    0    0 19840     0 5985  9995  0  9
75 16
 0  1      0 5865412 211584 1160696    0    0 19968     0 5986 10009  0  9
75 16
 0  1      0 5844952 231552 1160748    0    0 19968     0 5985  9992  0  9
75 16
 0  1      0 5824740 251392 1160668    0    0 19840     0 5985 10000  0  9
75 16
 0  1      0 5804280 271360 1160720    0    0 19968     0 5988 10005  0  9
75 16
 0  1      0 5783820 291328 1160772    0    0 19968     0 5982  9993  0  9
75 16
 1  1      0 5763484 311168 1160692    0    0 19840     0 5982  9990  0  9
75 16
 0  1      0 5743148 331136 1161004    0    0 19968     0 5978  9986  0  9
75 16
 1  1      0 5722812 350976 1160924    0    0 19840     0 5984  9987  0  9
75 16
 0  1      0 5702352 370944 1160716    0    0 19968     0 5979  9994  0  9
75 16
 0  1      0 5682016 390784 1160896    0    0 19840     0 5980  9993  0  9
75 16
 0  1      0 5661556 410752 1160688    0    0 19968     0 5982  9999  0  9
75 16
 0  1      0 5641220 430592 1160868    0    0 19840     0 5981  9988  0  9
75 16
 1  1      0 5620760 450560 1160660    0    0 19968     0 5979  9990  0  9
75 16
 0  0      0 6037780  43168 1161152    0    0  6272     0 2637  3187  0  7
88  5
 0  0      0 6037780  43168 1161152    0    0     0     0 1032   138  0  0
100  0

Western Digital 2.6.12 kernel:
 0  1      0 6036532  44444 1161176    0    0  1276     0 1026    94  0  0
99  1
 1  0      0 5976516 103196 1161184    0    0 58752     0 1465   957  1  6
75 19
 0  1      0 5915756 162460 1161200    0    0 59264     0 1467   955  0  6
75 18
 1  0      0 5854996 221860 1161340    0    0 59436    32 1473   979  1  5
75 19
 0  1      0 5794484 280868 1161092    0    0 58964     0 1465   951  0  6
75 19
 0  1      0 5733476 340388 1161112    0    0 59648     0 1471   979  1  6
75 18
 0  1      0 5672592 399908 1161132    0    0 59392     0 1469   964  0  6
75 18
 0  1      0 5611584 459428 1161152    0    0 59520     0 1469   970  0  6
75 18
 0  1      0 5550576 518948 1161172    0    0 59520     0 1469   960  0  6
75 18
 0  1      0 5489692 578468 1161192    0    0 59520     0 1469   972  1  6
75 18
 1  0      0 5428808 637860 1161080    0    0 59392     0 1469   963  0  6
75 18
 1  0      0 5367676 697380 1161100    0    0 59520     0 1469   975  0  6
75 18
 0  1      0 5306544 757028 1160992    0    0 59648     0 1470   967  1  6
75 19
 0  1      0 5245784 816420 1161140    0    0 59392     0 1468   984  0  6
75 19
 

Here is output with the Seagate being removed from the blacklist 
in the 2.6.12 kernel:
 1  0      0  34560 7065132  20388    0    0 54912     0 1220   511  1  6 74
19
 0  1      0  36420 7063468  20232    0    0 54912     0 1219   517  0  7 74
19
 0  1      0  34064 7065792  20508    0    0 54784     0 1218   512  0  6 74
19
 0  1      0  35676 7064236  20244    0    0 55040     0 1222   512  1  7 74
19
 0  1      0  32948 7066796  20024    0    0 54784     0 1219   506  0  6 74
19
 1  0      0  34560 7065156  20364    0    0 54912     0 1219   511  1  6 74
19
 2  1      0  35304 7064316  20424    0    0 54912     0 1218   511  0  6 74
19
 0  1      0  33816 7066084  19956    0    0 54784     0 1221   506  0  7 74
19
 0  1      0  35304 7064552  20188    0    0 55040     0 1221   520  1  6 74
19
 1  0      0  33568 7066212  20348    0    0 54016     0 1215   499  0  6 74
19

I did not get any crashes in the limited testing the we did, this seems to
indicate the the theory Jeff had about the blacklist growing incorrectly
may be correct.

The high/screaming interrupt/context switch issue seems to be related to the
blacklist issue since removing the disk from the blacklist seemed to make
that go away.

                            Roger Heflin
				    Atipa Technologies

