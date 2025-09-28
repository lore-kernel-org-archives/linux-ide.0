Received: from nick.sneptech.io (nick.sneptech.io [178.62.38.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE3192B90
	for <linux-ide@vger.kernel.org>; Sun, 28 Sep 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.38.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759048132; cv=none; b=sUMjgiQ7eVXtdz+fMBRHDzi2vpe6pE1z2aTOJ3B7lLypWff6stOag7zd1iLIP8piffSZr4JTRC5K9JkfE2oxs8Av5l4XgAWVme7Lqzd+wntON2lFWpX8y7OZteubR72jQdvguRy83KNU1UK5qQ4b+0BDC+UO09uvSotRluNkUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759048132; c=relaxed/simple;
	bh=dO+lyfuDoJJhAUtCu6ZyLFaFoPTmi7zSZcZBL2z/1Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q4sccK8BPAJosBzCUtwoyRSgMTqmivZKkLbUOPR1OcPBvsBRrDttU0cWZXlT687YAPk8GokxW4knHRKBeajus+5dcKjKepWSvE3TV6hyTj9/BXTyljiUglb7iHfYXGfSQnhDLwO8NIo3hpS9BuJEaMPa6uAYsSUHeuOQZvMZZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk; spf=pass smtp.mailfrom=philpem.me.uk; dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b=TI5L8nRo; arc=none smtp.client-ip=178.62.38.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpem.me.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=philpem.me.uk header.i=@philpem.me.uk header.b="TI5L8nRo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=philpem.me.uk;
	s=mail; t=1759046943;
	bh=dO+lyfuDoJJhAUtCu6ZyLFaFoPTmi7zSZcZBL2z/1Zg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TI5L8nRoNs/9ub8xq2Cf0jbSRfW/McRidJ4p/A0Xh6Dm/T+dicTQHYxdRjFqSlYDp
	 O+06mcYReHTreZSgZYp2rYYH7DpL/yXtwcjdrBlpFrFQSCdj0bdWXkfjssur4grlrK
	 IaTYXeN+fXgizK9eFhTludjVBlhMirGt9t3FWRT8=
Received: from wolf.philpem.me.uk (148.163.187.81.in-addr.arpa [81.187.163.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mailrelay_wolf@philpem.me.uk)
	by nick.sneptech.io (Postfix) with ESMTPSA id 781A1BD680;
	Sun, 28 Sep 2025 08:09:03 +0000 (UTC)
Received: from [10.0.0.32] (cheetah.homenet.philpem.me.uk [10.0.0.32])
	by wolf.philpem.me.uk (Postfix) with ESMTPSA id D1B485FCE8;
	Sun, 28 Sep 2025 09:09:02 +0100 (BST)
Message-ID: <bbaa3a8e-3461-4e5c-bab4-e8fba1b73eec@philpem.me.uk>
Date: Sun, 28 Sep 2025 09:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Multi-LUN ATAPI devices (Panasonic PD)
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 Niklas Cassel <cassel@kernel.org>
References: <398bda0b-6eaf-4a4f-8f46-0b0befd3aa89@philpem.me.uk>
 <66e16c3d-d7b1-4d53-a1b2-c1568e1ad585@kernel.org>
Content-Language: en-US
From: Phil Pemberton <philpem@philpem.me.uk>
In-Reply-To: <66e16c3d-d7b1-4d53-a1b2-c1568e1ad585@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Damien,

Apologies for the delay in replying, I've been busy with other things.

On 08/05/2025 05:33, Damien Le Moal wrote:
> Is this a new issue with 6.12.9 or was it working before ?

I can't say when it was new by, but it certainly worked in the 3.0 
kernel tree, see:
   https://lkml.indiana.edu/hypermail/linux/kernel/9903.2/0109.html

  
https://grumpyoldme.de/2023/08/19/ide-device-with-lun-1-in-linux-easy-in-2000-howto-in-2023-followerpower/

  
https://www.abclinuxu.cz/hardware/ukladani-dat/ide/opticke-mechaniky/pd-cd-rom/teac-pd-518e 
(translate from Czech to English)

It seems like the kernel configuration option they mention (


> There is no concept of Logical unit/LUN in ATA/ATAPI. That simply does not
> exist at all.

I think you might be mistaken -- pure ATA has only a master and slave 
for each channel, sure. But ATAPI wraps SCSI commands to pass over the 
ATA bus -- in fact, you can see here that it supports LUNs:

   https://wiki.osdev.org/ATAPI

See "Detecting a medium's capacity"


 > Likely, Windows has a special driver for that second PD drive and> 
exposes both drives as 2 LUNs of the same device.

I've reverse-engineered the driver. All it does is detect the SCSI 
device, enumerate as two drives to Windows, then

The DOS driver works by sitting an ASPI SCSI driver on top of ATAPI, 
then putting a SCSI Mass Storage and a SCSI CD-ROM driver on top of the 
ASPI driver.

> Unless that PD drive thinggy uses a standard ATA/ATAPI interface, I do not see
> how to make this work.

It's ATAPI - see above.

The drive is a combination of a CD-ROM drive and a phase-change 
rewritable optical disc drive.
If you access LUN 0, you get a CD subdevice which only works if a CD is 
in the drive.
If you access LUN 1, you see a mass storage device which only works with 
a PD disk in the drive.

It acts like some of Panasonic's later DVD-RAM drives.

> But just in case, please share an output of dmesg for this system probe of the
> AHCI adapter and ATA/ATAPI devices so that we can see what's going on.

I'll get an AHCI adapter and a PD drive set up later today and report 
back. This would be on Kernel 6.14.0.

In the meantime the Czech link above has some of the device identity data:

ide: i82371 PIIX (Triton) on PCI bus 0 function 33
ide0: BM-DMA at 0xd800-0xd807
ide1: BM-DMA at 0xd808-0xd80f
hda: WDC AC26400B, 6149MB w/512kB Cache, CHS=784/255/63, UDMA
hdb: TEAC PD-1 PD-518E, ATAPI CDROM drive - enabling SCSI emulation
ATAPI overlap supported: No
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.36.3 MAX_MD_DEV=4, MAX_REAL=8
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 1 host.
Vendor: TEAC Model: PD-1 PD-518E Rev: 1.0E
Type: CD-ROM ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
Vendor: TEAC Model: PD-1 PD-518E Rev: 1.0E
Type: Optical Device ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 0, lun 1
scsi : detected 1 SCSI cdrom 1 SCSI disk total.
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 28
sda : extended sense code = 2
sda : block size assumed to be 512 bytes, disk size 1GB.

/proc/scsi:
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
Vendor: TEAC Model: PD-1 PD-518E Rev: 1.0E
Type: CD-ROM ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 00 Lun: 01
Vendor: TEAC Model: PD-1 PD-518E Rev: 1.0E
Type: Optical Device ANSI SCSI revision: 02


The kernel patch on indiana.edu forces BLIST_FORCELUN and 
BLIST_SINGLELUN which would force all 8 LUNs to be probed, and only 
allow I/O to one LUN at a time.

Thanks.
-- 
Phil.
philpem@philpem.me.uk
https://www.philpem.me.uk/
