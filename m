From: "Kou, Haofeng" <Haofeng.Kou@idt.com>
Subject: SI3112
Date: Wed, 6 Aug 2003 13:22:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <C8AEE7623CD92344B097388DA0ABD05C0544E7AA@corpbridge.corp.idt.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Anyone has make the SI3112 SATA card fully work on the embedded board?
I have tried the 2.4.21 from kernel.org, the RedHat9.0 and the MIPS
kernel-2.4.21 from linux-mips.org. But all of them shows:

hda: lost interrupt
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hda: drive not ready for command

Any suggestion or information are welcome!

Thanks!



-----Original Message-----
From: Michael Buesch [mailto:fsdeveloper@yahoo.de]
Sent: Wednesday, August 06, 2003 12:32 PM
To: Frank Van Damme
Cc: linux kernel mailing list; linux-ide@vger.kernel.org
Subject: Re: [2.6] system is very slow during disk access


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 21:29, Frank Van Damme wrote:
> Maybe you just didn't enable DMA on them. Use hdparm -v /dev/foo to find
> out.

DMA is on.

root@lfs:/home/mb> hdparm -v /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 14244/16/63, sectors = 80418240, start = 0


root@lfs:/home/mb> hdparm -v /dev/hdc

/dev/hdc:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 14244/16/63, sectors = 80418240, start = 0


- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MVeeoxoigfggmSgRAkVfAJ4/SIBNLy7v4+E5OgA/z4FjMcKFfgCfTF94
orXbTJpyryLpKXwjzkZoyqU=
=4jnz
-----END PGP SIGNATURE-----

