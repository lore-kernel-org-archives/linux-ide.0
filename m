From: Pavel Roskin <proski@gnu.org>
Subject: Re: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Wed, 15 Nov 2006 00:43:10 -0500
Message-ID: <1163569390.4410.8.camel@dv>
References: <1163563453.3100.24.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:30370 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S966678AbWKOIIG
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 03:08:06 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GkDYZ-0007AW-1u
	for linux-ide@vger.kernel.org; Wed, 15 Nov 2006 00:43:31 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1GkDYE-0001Av-Cw
	for linux-ide@vger.kernel.org; Wed, 15 Nov 2006 00:43:10 -0500
In-Reply-To: <1163563453.3100.24.camel@dv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello again and sorry for post scriptum.

On Tue, 2006-11-14 at 23:04 -0500, Pavel Roskin wrote:

> ata2.01: qc timeout (cmd 0xa1)
> ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
... 
> Note that with CONFIG_IDE, the hard drive is /dev/hda and DVD
> is /dev/hdc, so it's not the secondary interface - it's something else.

Closer examination of the code shows that the problem is with the slave
on the secondary interface, i.e. /dev/hdd in the IDE driver.

Here's one thing I didn't mention.  The combo DVD-ROM/CD-RW drive I'm
using wasn't native to the laptop.  I took it from another Thinkpad -
from an older T23 model (and I'm dealing with T30) to replace a native
DVD-ROM.

That's how the drive is identified:

scsi 1:0:0:0: CD-ROM            MATSHITA UJDA720 DVD/CDRW 1.03 PQ: 0 ANSI: 5

I swapped the drives back and there is no delay anymore!

scsi0 : ata_piix                                                                                
ata1.00: ATA-5, max UDMA/100, 78140160 sectors: LBA                                             
ata1.00: ata1: dev 0 multi count 16                                                             
ata1.00: configured for UDMA/100                                                                
scsi1 : ata_piix                                                                                
ata2.00: ATAPI, max UDMA/33                                                                     
ata2.00: configured for UDMA/33                                                                 
scsi 0:0:0:0: Direct-Access     ATA      IC25N040ATCS05-0 CS4O PQ: 0 ANSI: 5                    
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)                                      
sda: Write Protect is off                                                                       
SCSI device sda: drive cache: write back                                                        
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)                                      
sda: Write Protect is off                                                                       
SCSI device sda: drive cache: write back                                                        
 sda: sda1 sda2 sda3 sda4                                                                       
sd 0:0:0:0: Attached scsi disk sda                                                              
sd 0:0:0:0: Attached scsi generic sg0 type 0                                                    
scsi 1:0:0:0: CD-ROM            MATSHITA DVD-ROM SR-8177  NB21 PQ: 0 ANSI: 5                    

Likewise, there is no delay if I remove the drive:

scsi0 : ata_piix                                                                                
ata1.00: ATA-5, max UDMA/100, 78140160 sectors: LBA                                             
ata1.00: ata1: dev 0 multi count 16                                                             
ata1.00: configured for UDMA/100                                                                
scsi1 : ata_piix                                                                                
scsi 0:0:0:0: Direct-Access     ATA      IC25N040ATCS05-0 CS4O PQ: 0 ANSI: 5                    
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)                                      

There are no jumpers on either drive.  I assume they are configured as
either master or "cable select".

I also tried booting the same kernel on the Thinkpad T23 with the combo
drive.  I got the same "qc timeout" errors.  Thinkpad T23 has the same
IDE controller 8086:248a, it's also at 00:1f.1.

So the problem has been reduced to Matsushita (Matshita Panasonic)
UJDA720 in an IBM Thinkpad blocking detection of empty slave on the same
port.  It's clearly a regression in libata compared to the IDE driver,
and it would be nice to have it fixed.

-- 
Regards,
Pavel Roskin


