From: =?ISO-8859-1?Q?D=E2niel?= Fraga <fragabr@gmail.com>
Subject: Re: pata_via with software raid1: "attempt to access beyond end of
 device"
Date: Fri, 20 Jul 2007 18:11:39 -0300
Message-ID: <b1l7n4-7p4.ln1@tux.abusar.org>
References: <ohu2n4-lcf.ln1@tux.abusar.org>
	<20070720001714.7b6aaf95@the-village.bc.nu>
	<k0c5n4-dl4.ln1@tux.abusar.org>
	<20070720163709.04e5999c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:51965 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbXGTVO6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Jul 2007 17:14:58 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBzoG-0005tJ-Dj
	for linux-ide@vger.kernel.org; Fri, 20 Jul 2007 23:14:48 +0200
Received: from 200-207-206-233.dsl.telesp.net.br ([200.207.206.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 23:14:48 +0200
Received: from fragabr by 200-207-206-233.dsl.telesp.net.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Fri, 20 Jul 2007 23:14:48 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, 20 Jul 2007 16:37:09 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ok try booting with
> 
> 	libata.ignore_hpa=1

	I used that option:

fraga@abusar ~$ dmesg|grep hpa
Kernel command line: auto BOOT_IMAGE=linux rw root=902 panic=5 libata.ignore_hpa=1

	and tried to makereiserfs again, but got the same results:

Guessing about desired format.. Kernel 2.6.22 is running.
Format 3.6 with standard journal
Count of blocks on the device: 19410528
Number of blocks consumed by mkreiserfs formatting process: 8804
Blocksize: 4096
Hash function used to sort names: "r5"
Journal Size 8193 blocks (first block 18)
Journal Max transaction length 1024
inode generation number: 0

	19410528 x 4 = 77642112

	which is higher than 

Used Dev Size : 77642048 (74.05 GiB 79.51 GB)

	The "solution" was to reduce 64K from the reiser partition, as
suggested by Neil Brown. This way the raid stopped to complain.

	But I really don't know why mkreiserfs is creating a filesystem
with 64k more than allowed by the device... maybe a bug in mkreiserfs?

	The strange is that it didn't happen with the OLD IDE
drivers... could it be a pata_via bug?

	To determine if it is mkreiserfs' fault I used mke2fs just
to see if it will create the same number of blocks as reiserfs:

fraga@abusar ~$ sudo mke2fs /dev/sda2
mke2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
9715712 inodes, 19410536 blocks
970526 blocks (5.00%) reserved for the super user
First data block=0
593 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks: 
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
        4096000, 7962624, 11239424

Writing inode tables: done                            
Writing superblocks and filesystem accounting information: done

	***
	
	As you can see it created 19410536 blocks (19410536 x 4 =
77642144, exactly as mkreiserfs did).

	So I suppose it's a bug in some other place.

	Or mdadm is determining the incorrect size of the device,
64K less than the real size? Just for your convenience, mdadm returns:

     Array Size : 77642048 (74.05 GiB 79.51 GB)
  Used Dev Size : 77642048 (74.05 GiB 79.51 GB)

	and mkreiserfs, mke2fs etc return 77642144. In other words, 64K
more. Which one is correct? mkreiserfs/mke2fs or mdadm?

	According Neil Brown, mdadm is correct and we don't know why
mkreiserfs is creating a filesystem 64k larger than the device... so it
could be a pata_via bug... is there any other test I can do to
get rid of the possibility of a pata_via bug? If you need i can apply
patches in the kernel or activate some other option.

	And it seems that mdadm's method to determine the size of the
partition is different from mkreiserfs/mke2fs etc, right?

	Thank you!

-- 
Linux 2.6.22: Holy Dancing Manatees, Batman!
http://www.lastfm.pt/user/danielfraga
http://u-br.net
Marilyn Manson - "Cruci-Fiction in Space" (Holy Wood (In the Shadow of
the Valley of Death) - 2000)

