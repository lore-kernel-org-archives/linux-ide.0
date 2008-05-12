From: Peter Klotz <peter.klotz@aon.at>
Subject: 2.6.24.*/2.6.25.*: attempt to access beyond end of device
Date: Mon, 12 May 2008 07:31:18 +0200
Message-ID: <4827D626.50903@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:32732 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750868AbYELFiJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 01:38:09 -0400
Received: from unknown (HELO email.aon.at) ([172.18.5.231])
          (envelope-sender <peter.klotz@aon.at>)
          by fallback01.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 12 May 2008 05:31:26 -0000
Received: from 212-183-96-220.adsl.highway.telekom.at (HELO [192.168.0.100]) ([212.183.96.220])
          (envelope-sender <peter.klotz@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 12 May 2008 05:31:19 -0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I compiled several kernel.org kernels (2.6.24.3, 2.6.24.7, 2.6.25.1, 
2.6.25.3) but when booting them up the following messages appear:

  attempt to access beyond end of device
  sda: rw=0, want=273956253, limit=268435455
  Buffer I/O error on device sda3, logical block 39085952
  attempt to access beyond end of device
  sda: rw=0, want=273956254, limit=268435455
  Buffer I/O error on device sda3, logical block 39085953
  attempt to access beyond end of device
...
  attempt to access beyond end of device
  sda: rw=0, want=273956255, limit=268435455
  attempt to access beyond end of device
  sda: rw=0, want=273956256, limit=268435455
  attempt to access beyond end of device


There is no problem when using the supplied kernel of Ubuntu 8.04 
(2.6.24-16.30).

I tracked the problem down to this difference in the dmesg output of the 
bootup sequences:

2.6.24-16.30 (Ubuntu 8.04):

  ata1.00: HPA unlocked: 268435455 -> 312581808, native 312581808
  ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
  ata1.00: 312581808 sectors, multi 16: LBA48

2.6.24.7:

  ata1.00: HPA detected: current 268435455, native 312581808
  ata1.00: ATA-8: SAMSUNG HM160HC, LQ100-10, max UDMA/100
  ata1.00: 268435455 sectors, multi 16: LBA48


The HDD is 160GB in size, so 312581808 sectors seem much more logical 
than 268435455 sectors. It seems that kernel.org kernels limit the HDD 
to 128GiB.

Here the "fdisk -l" output:

  user@centrino:~$ sudo fdisk -l /dev/sda

  Disk /dev/sda: 160.0 GB, 160041885696 bytes
  255 heads, 63 sectors/track, 19457 cylinders
  Units = cylinders of 16065 * 512 = 8225280 bytes
  Disk identifier: 0x0008e799

     Device Boot      Start         End      Blocks   Id  System
  /dev/sda1   *           1          31      248976   83  Linux
  /dev/sda2              32       14620   117186142+  83  Linux
  /dev/sda3           14621       17053    19543072+   7  HPFS/NTFS

I may have been lucky up to now because I only use partitions sda1 and 
sda2 on this drive.

Any help regarding this issue is appreciated.

Please CC me since I am no list member.

Best regards, Peter.
