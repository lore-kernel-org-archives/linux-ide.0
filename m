From: gshan <gshan@alcatel-lucent.com>
Subject: Re: PIIX4: DMA timeout issue
Date: Fri, 24 Oct 2008 14:09:42 +0800
Message-ID: <490166A6.3070203@alcatel-lucent.com>
References: <488ED837.2060509@alcatel-lucent.com>	<488F1C6C.9000002@garzik.org>	<48902EB5.8070102@alcatel-lucent.com> <20080730114934.5a593cf4@lxorguk.ukuu.org.uk> <48913FFD.5070901@alcatel-lucent.com> <4892BEBA.2000602@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cnmailgate04.alcatel-sbell.com.cn ([211.144.215.47]:34440 "EHLO
	cnshjsmin03.cn.alcatel-lucent.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751679AbYJXGcT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 02:32:19 -0400
In-Reply-To: <4892BEBA.2000602@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>, Linux IDE mailing list <linux-ide@vger.kernel.org>

Hi Alan & Jeff,

I have being struggled for this issue for long time, but have no ideas 
finally. So
I have to write mail to you for suggestions again. Thanks in advance for 
your
reply since you're busy.

I'm using IDE driver instead of ATA driver for my PIIX4 IDE controller. 
The experiment
is: 1)mount local directory (/aaa on ramdisk) to remote server via NFS; 
2)copy a big
file (about 600MB) from remote server to local disk, finally DMA timeout 
happened.

When DMA timeout happened, I have dumped out PRD table as follows, it seems
the PRD table doesn't have any problem. Note that pls swap bytes for PRD 
entries
(from big endian to little endian).

SP(27-A) $ mount /dev/hda1 /disk_root/
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SP(27-A) $ cd /disk_root/
SP(27-A) $ cp /aaa/Gavin/sp3m/target_7xx_cge5.2008-07-10.tgz ./
hda: dma_timer_expiry: dma status == 0x21
========IDE Register DUmp========
DMA start sector: 0x00169657
DMA sectors     : 0x0100
Data Reg        : 0x06
Error Reg       : 0x00
Nsector Reg     : 0xd5
Sector Reg      : 0x82
LCYL Reg        : 0x96
HCYL Reg        : 0x16
Select Reg      : 0xe0
Status Reg      : 0x5a
Control Reg     : 0x58
IRQ Reg         : 0xff
======Physical Region Descriptor=======
Base_PRD: 0x0fec5000  Current_PRD: 0x0fec5018  Entries:7
index=0  base=0x00d0661c lengh=0x00300000
index=1  base=0x0000671c lengh=0x00200000
index=2  base=0x0000691c lengh=0x00800000
index=3  base=0x0080691c lengh=0x00800000
index=4  base=0x00006a1c lengh=0x00300000
index=5  base=0x0040e21d lengh=0x00100000
index=6  base=0x00306a1c lengh=0x00700080

If possible, could you tell me how IDE complete DMA transfer on PCI bus?

Thanks,
Gavin



