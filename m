From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: HD filesystem integrity issues
Date: Thu, 02 Jan 2014 21:04:39 -0600
Message-ID: <52C628C7.6040407@gmail.com>
References: <52C49A1C.1000104@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:39968 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbaACDKF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Jan 2014 22:10:05 -0500
Received: by mail-ig0-f171.google.com with SMTP id c10so144649igq.4
        for <linux-ide@vger.kernel.org>; Thu, 02 Jan 2014 19:10:04 -0800 (PST)
In-Reply-To: <52C49A1C.1000104@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@earthlink.net>
Cc: linux-ide@vger.kernel.org

On 01/01/2014 04:43 PM, Felix Miata wrote:
> http://fm.no-ip.com/Tmp/Linux/dmsgAZBHD201401.txt is dmesg from a STB
> running 2.6.15-sigma MIPS. In it I noticed the run e2fsck recommendation
> for (SATA "1.2TB") hdb1, so attempted to umount it and do just that, as
> the last time done would have been in excess of 3 months ago. Before
> doing so, I decided to e2fsck another HD available via USB 2.0 as "2TB"
> sda1, which began thus via telnet while the STB was "asleep":
>
> $ e2fsck /dev/sda1
> e2fsck 1.41.9 (22-Aug-2009)
> e2fsck: Group descriptors look bad... trying backup blocks...
> <volumelabel> was not cleanly unmounted, check forced.
> Reading 1 blocks starting at 1027
> Reading 1 blocks starting at 1288...
> and ended thus:
> ...
> Reading 1 blocks starting at 343
> Pass 1: Checking inodes, blocks, and sizes
> Killed
> $

Have you checked the dmesg output? There would likely be some indication 
of what happened. Given that this thing only has 100MB or so of memory, 
it seems quite likely that the out-of-memory killer kicked in.

This isn't really related to linux-ide, the main Linux kernel mailing 
list would likely be more suitable.

>
> I was able to discover nothing to indicate what precipitated the kill. I
> proceeded to umount hdb1, and then:
>
> $ e2fsck /dev/hdb1
> e2fsck 1.41.9 (22-Aug-2009)
> Killed
> $
>
> Again I found nothing to indicate what precipitated the kill.
>
> I speculate this may have something to do with hardware and/or
> configuration limitation(s). The sketchy manual written in English by an
> obviously non-native English writer/speaker claims an internal HD size
> limitation of 1TB. 1TB is the apparent maximum size the device is able
> to self-prepare for use on physical HT installation (1:partition; and
> 2:install ext2 filesystem).
>
> I tested the STB briefly when new with a 1TB before installing a 2TB HD
> prepared on a Linux PC with a "full" (starting @S2048) device ext2
> partition. I used it probably some months before deciding the 1TB limit
> might have some real justification, removed it, and installed a 1TB. I
> used the 1TB for quite some time before freespace began to drop under
> 5%, upon which I decided to try a size in between 1TB and 2TB. 10 months
> ago on a 1.5TB Samsung HD155UI (aka Seagate Green ST1500DL004; not sure
> whether 512e but I think yes) I created 2 partitions, one 1.2TB ext2,
> and the remainder type ext2, but without installing any filesystem on
> it. This is the 1.2TB hdb1 for which the second Killed appeared.
>
> I removed the 1.5TB "hdb" from the STB and attached it via eSATA to a
> Linux PC to try again e2fsck, with the following result:
> # e2fsck -v /dev/sdb1
> e2fsck 1.42.6 (21-Sept-2012)
> <volumelabel> was not cleanly unmounted, check forced.
> Pass 1: Checking inodes, blocks and sizes
> Error reading block 12419091 (Attempt to read block from filesystem
> resulted in short read) while getting next inode from scan.
>   Ignore error<y>? yes
> Force rewrite<y>? yes
> Pass 2: Checking directory structure
> Pass 3: Checking directory connectivity
> Pass 3A: Optimizing directories
> Pass 4: Checking reference counts
> Pass 5: Checking group summary information
>
> <volumelabel>: ***** FILE SYSTEM WAS MODIFIED *****
>
> 339 inodes used (0.00%, out of 80535552)
> 2 non-contiguous files(0.6%)
> 0 non-contiguous directories (0.0%)
> # of inodes with ind/dind/tind blocks: 288/285/121
> 300564929 blocks used (93.31%, out of 322122496)
>          0 bad blocks
>        276 large files
>        314 regular files
>         15 directories
>          0 character device files
>          0 block device files
>          0 fifos
>          0 links
>          1 symbolic link (1 fast symbolic link)
>          0 sockets
> ----------
>        330 files
> #
>
> I've now restored the 1.5TB HD to the STB.
> $ uname -a
> Linux AZBox 2.6.15-sigma #138 PREEMPT Thu Jan 22 21:35:07 KST 2009 mips
> unknown
> $ free
>                total         used         free       shared      buffers
>    Mem:       100484        96360         4124            0         1520
>   Swap:            0            0            0
>
> Googling "Attempt to read block from filesystem resulted in short read"
> produced a lot of hits, of which little seemed to be of any use. The
> e2fsck man page seems rather unhelpful as well. The STB has a rather
> rudimentary toolset in the form of busybox v1.00, producing a lot of
> command not founds trying to perform shell tasks common on a Linux PC
> (e.g. smart, shutdown, tune2fs), and its command history does not
> survive reboots. Neither /boot nor /proc/config* exist.
>
> 1-Is my 1.2TB partition now most likely OK?
>
> 2-Is the meager 100484 of total RAM available to the 2.6.15 kernel
> likely the reason or heavily related to the manual's 1TB size "limit"?
>
> 3-Is the meager 100484 of total RAM likely the reason for the e2fsck kills?
>
> 4-Any suggestions?
>
> 5-Is this the wrong place to have asked all this? If so, where better?

