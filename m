From: Michael Buesch <fsdeveloper@yahoo.de>
Subject: Re: [2.6] system is very slow during disk access
Date: Wed, 6 Aug 2003 21:31:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200308062131.46017.fsdeveloper@yahoo.de>
References: <200308062052.10752.fsdeveloper@yahoo.de> <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200308062129.26371.frank.vandamme@student.kuleuven.ac.be>
Content-Description: clearsigned data
Content-Disposition: inline
To: Frank Van Damme <frank.vandamme@student.kuleuven.ac.be>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

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
