From: "Christopher R. Thompson" <Christoffur050@Verizon.Net>
Subject: Any way to unfix a fixed (by e2fsck) 160GB partition?
Date: Mon, 21 Mar 2005 08:31:30 -0800
Message-ID: <423EF6E2.20805@Verizon.Net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------040709090307020908020204
Received: from vms044pub.verizon.net ([206.46.252.44]:23786 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S261184AbVCUQcb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Mar 2005 11:32:31 -0500
Received: from Verizon.Net ([4.27.6.137])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2 HotFix 0.04
 (built Dec 24 2004)) with ESMTPA id <0IDP00IRFN8IWT00@vms044.mailsrvcs.net> for
 linux-ide@vger.kernel.org; Mon, 21 Mar 2005 10:32:06 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040709090307020908020204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Red Hat 8.0, Kernel Version 2.4.29-pre2, ASUS P4P800SE MB, 3.2 GHz
Intel-P4 CPU, 1 GB RAM, ICH5R S-ATA only. SATA Disk = Maxtor 6Y160M0.

This is really busting my balls. Around August or September of last
year, a year and one month old (out of warranty) hard drive on my server
gave out and crashed the system. This was my newest at the time Maxtor
4R120L4 120GB disk which I installed as the server's root drive. It runs
really hot now after the crash, and it (I assume) has taken out 3
different brand new power supplies (230, 350 & 450 Watts). I bought a
new computer, this one, with two new sata disks and a 550 Watt power
supply, and copied the partitions of the bad disk (hdc) onto the second
sata disk (sdb) as giant 60GB files. I was able to run e2fsck on the
files and recovered most of my data by hand. Just about everything
turned up in the lost+found directories, and I was able to move a lot of
the stuff back to where it belonged. This took me most all of the
Christmas Holiday break. Since my grades at school suffered severely
during the quarter time period while I was trying to rebuild my server,
I promised my academic advisor I would not touch the computer again
until spring break. That is now, and my new sata drive (with all of my
recovered data and two weeks worth of Christmas Holiday work) seems to
have also fortuitously crashed just before I could transfer the data
back to my new server. ARRGGGHHHH!!!!

The setup is like this. I have a firewall with http and ftp software
that uses nfs to serve up files from this computer's brand new sdb1
partition. Not that it has anything to do with the problem, or was it
being used at the time, but one of those directories was writable as an
ftp "incoming" directory. All of the other directories were served as
read-only. The incoming directory was /linux2/ftp/incoming on this
system where sdb1 was mounted to the root directory as /linux2. The
recovered 60GB partitions were mounted as /linux2/hdcN.img to
/somerootdirectory using the loopback device. I haven't touched any part
of the loopback files since December and my recovery work. Except for
the /linux2/ftp/incoming directory having some occasional write accesses
to it from time to time, nothing has been going on with this drive until
I had time to transfer my recovered files this week.

This has been working very well, and without any problems since
December. A couple of weeks ago on March 6 I shut down the system to do
some school work on Win98, and when I rebooted linux, the system said
(incorrectly) that I had not unmounted my sdb1 partition cleanly and
needed to run fsck. I dutifully performed the fsck because most of the
time it never causes a serious problem. This time was an exception
because it found a bunch of errors, which I then elected to let it fix.

When I mounted the sdb1 partition afterwards, there were no files to be
found... not even the lost+found directory.

I have a feeling that Mator's SMARTs in this drive are not so smart
after all. Since this drive is still under warranty, it is no problem to
replace. I just need to know that I can still get the data back somehow.
E2fsed or whatever it was called.... isn't here anymore, and I guess
that doesn't really matter anyway because my 60GB files exceed the old
2GB e2fsed limit. "debugfs" says the following

[root@Sharlie bkup 20:05:27]# debugfs /dev/sdb1
debugfs 1.27 (8-Mar-2002)
/dev/sdb1: Attempt to read block from filesystem resulted in short read
while opening filesystem
debugfs: ls
ls: Filesystem not open
debugfs: open /dev/sdb1
/dev/sdb1: Attempt to read block from filesystem resulted in short read
while opening filesystem
debugfs: ls
...

I noticed that the last good bootup was around March 3, and after that
I started getting ata2 error messages. F-me! I left the G-dxxxxx "less
/var/log/messages.17" on the screen last night while the syslog rotated,
and now it's gone too. Anyway I have included as attachments in this
message the fsck error messages recorded. The system log error messages
can be found here at this web site
http://Christoffur.HopTo.Org/Photos/Uploads/

The main points of interest would probably be these files

http://Christoffur.HopTo.Org/Photos/Uploads/LastGoodBoot.txt 28530 Bytes
http://Christoffur.HopTo.Org/Photos/Uploads/FirstErrorMessages.txt
144961 Bytes
http://Christoffur.HopTo.Org/Photos/Uploads/Prtl-ErrorMessagesB4+AfterFsck.txt

48158 Bytes

Funny, there were no ata2 error messages on the 5th of March even though 
I performed two bootups. Unfortunately when the system booted at 15:57 
and I performed the two fscks, system logging does not seem to have been
enabled. There are no system log messages between 15:57 when I shut down
the computer to reboot and run fsck, and 17:01 when the system came back
up with the sdb1 entry removed from /etc/fstab. The above files have
been significantly trimmed to reduce the download size. If you want
access to the full and complete message logs, you can find them in the
Upload directory given above.

The problem with the message logs is that the messages from the new
sata ata2 drive look exactly the same as the messages from the old bad
hdc drive.

You can find those errors in the messages logs 99, 100 and 101 in the
same directory as above. It took three days to copy the data off of my
bad hdc drive onto the new drive.

I don't suspect an OS, or SATA driver problem at this time at all. It
would appear that the drive itself, while being only 3 or 4 months old
has developed some kind of hardware problem. I am not quite sure what
exactly the problem is, but it won't be until April before I can afford
another replacement disk.

I am going to power down and kick the cables on the bad drives and take
as many of the good drives out of this computer that I can, and put the
good ones back in the new 300MHz Pentium-3 server machine, which is
basically a September copy of this machine. That will probably take all
day, if I am lucky.

Hopefully 550 Watts should be enough power to drive the two bad disks,
and the one good sata root disk. Then I can hopefully copy the data off
of the bad drives onto the server were they belong. I have one week to
get this done and then my next quarter starts at school again, and I
really need to focus and concentrate on that. I am especially worried
about the root drive on this computer and the server because they are
exactly the same as the one that just crapped out. Except that the one
on the server is a regular ata drive and not a S-ata. The rest of the
drive is supposed to be exactly the same. If either one of those drives
blows up, I am really going to be sunk.

I am taking recommendations as to what type of drives to use to replace
my Maxtors. I thought that Maxtor was one of the most reliable drives
around and I have been using them exclusively for 10 years or more. It
would now appear that I may have been wrong about the Maxtor reliability
factor, or that something may have changed in their manufacturing
processes. I've got drives that have been running 24 hours a day 365
days a year for over 6 years without as much a hiccup. Now all of a
sudden in two years I've got two new drives giving me conniption fits
and driving me crazy.

I don't have the time nor can I afford the anger management classes
that would alleviate my serious ant-social behaviors that have developed
over the last few months related to these incidents. My poor defenseless
little 486 server, victim of the first hard drive crash, sitting
harmlessly on the floor awaiting a simple drive transplant, just
happened to get in the way of my big foot immediately following the last
crash on my new machine and suffered a fatal swift kick that caused a
compound processor neck bone fracture. Obviously this situation cannot
continue. If simple inanimate objects like my beloved little Shelby are
not safe from my personal and infuriating bouts of computer rage, I hate
to think of what the future will bing to the latest and greatest
pentium-4's that happen to lay near in proximity to my next coming
affliction.

If someone could please decrypt some of the error messages and let me
know if the 6Y16M0 data is salvageable and how that might be
accomplished, it might save me a couple of weeks worth of re-work to
re-recover my hdc data, and save future unsuspecting computer systems
from further days of unearned relentless hammering torment, retribution
and the rubbish heap.

Any other suggestions, observations or criticisms, as always, are
always welcomed.

Prayers should also be helpful, if anyone is so disposed, as this can
certainly not be an act of random chance, but instead due to the
critical nature of the timing of these events, this must be an act of
the hand of God. And I know not why? All I am trying to do is save the
world and the entire human race!

Regards from,
--
Christopher R. Thompson
Student of Mechanical Engineering
California State Polytechnic University, Pomona
home: http://www.csupomona.edu/~cthompson1/

SNAFU and .... Who was that guy who said.."If it can go wrong... it will
go wrong!"?



--------------040709090307020908020204
Content-Type: text/plain;
 name="fsck.out1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsck.out1"

e2fsck 1.27 (8-Mar-2002)
/dev/sdb1 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Error reading block 173192 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 206517 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 239842 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 373142 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 1272919 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 1973269 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 2006594 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 2073244 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 3006345 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 3506746 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 3673371 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 5006372 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 5172997 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 9573476 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 11806779 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12073379 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12206679 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12573254 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12706554 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12839855 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 12973155 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13106455 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13173630 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13340255 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13606855 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13740155 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 13906781 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14040081 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14173381 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14306681 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14439981 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14606606 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14739906 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Error reading block 14873206 (Attempt to read block from filesystem resulted in short read) while reading indirect blocks of inode 13.  Ignore error? yes

Inode 13, i_blocks is 119190200, should be 118911672.  Fix? yes

Error reading block 19628330 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628331 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628332 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628333 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628334 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628335 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628336 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628337 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628338 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628339 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628340 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628341 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628342 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628343 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628344 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628345 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628346 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628347 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628348 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628349 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628350 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628351 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628352 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628353 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 19628354 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507021 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507022 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507023 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507024 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507025 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507026 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507027 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507028 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507029 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30507030 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539789 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539790 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539791 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539792 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539793 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539794 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539795 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539796 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539797 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30539798 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572557 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572558 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572559 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572560 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572561 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572562 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572563 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572564 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572565 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30572566 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605325 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605326 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605327 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605328 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605329 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605330 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605331 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605332 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605333 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 30605334 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621133 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621134 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621135 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621136 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621137 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621138 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621139 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621140 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621141 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31621142 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653901 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653902 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653903 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653904 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653905 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653906 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653907 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653908 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653909 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31653910 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686669 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686670 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686671 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686672 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686673 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686674 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686675 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686676 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686677 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31686678 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719437 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719438 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719439 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719440 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719441 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719442 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719443 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719444 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719445 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31719446 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752205 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752206 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752207 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752208 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752209 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752210 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752211 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752212 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752213 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31752214 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784973 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784974 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784975 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784976 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784977 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784978 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784979 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784980 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784981 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31784982 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817741 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817742 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817743 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817744 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817745 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817746 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817747 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817748 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817749 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31817750 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850509 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850510 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850511 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850512 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850513 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850514 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850515 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850516 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850517 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31850518 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883277 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883278 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883279 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883280 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883281 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883282 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883283 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883284 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883285 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31883286 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916045 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916046 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916047 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916048 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916049 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916050 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916051 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916052 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916053 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 31916054 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604173 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604174 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604175 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604176 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604177 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604178 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604179 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604180 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604181 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32604182 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636941 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636942 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636943 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636944 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636945 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636946 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636947 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636948 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636949 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32636950 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669709 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669710 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669711 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669712 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669713 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669714 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669715 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669716 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669717 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32669718 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702477 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702478 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702479 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702480 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702481 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702482 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702483 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702484 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702485 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32702486 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735245 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735246 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735247 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735248 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735249 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735250 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735251 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735252 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735253 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32735254 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768013 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768014 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768015 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768016 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768017 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768018 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768019 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768020 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768021 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32768022 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800781 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800782 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800783 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800784 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800785 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800786 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800787 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800788 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800789 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32800790 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833549 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833550 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833551 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833552 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833553 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833554 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833555 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833556 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833557 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32833558 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866317 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866318 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866319 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866320 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866321 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866322 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866323 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866324 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866325 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32866326 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899085 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899086 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899087 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899088 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899089 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899090 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899091 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899092 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899093 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 32899094 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030157 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030158 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030159 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030160 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030161 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030162 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030163 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030164 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030165 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33030166 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259533 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259534 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259535 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259536 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259537 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259538 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259539 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259540 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259541 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33259542 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390605 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390606 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390607 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390608 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390609 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390610 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390611 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390612 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390613 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33390614 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521677 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521678 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521679 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521680 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521681 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521682 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521683 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521684 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521685 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33521686 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652749 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652750 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652751 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652752 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652753 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652754 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652755 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652756 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652757 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 33652758 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536426 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536427 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536428 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536429 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536430 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536431 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536432 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536433 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536434 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536435 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536436 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536437 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536438 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536439 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536440 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536441 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536442 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536443 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536444 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536445 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536446 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536447 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536448 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536449 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Error reading block 36536450 (Attempt to read block from filesystem resulted in short read) while doing inode scan.  Ignore error? yes

Pass 2: Checking directory structure
Entry 'd03' in Error reading block 13 (Attempt to read block from filesystem resulted in short read).  Ignore error? yes

??? (15171585) has deleted/unused inode 15253505.  Clear? yes

Entry 'd04' in ??? (15171585) has deleted/unused inode 15269889.  Clear? yes

Entry 'd05' in ??? (15171585) has deleted/unused inode 15286273.  Clear? yes

Entry 'd06' in ??? (15171585) has deleted/unused inode 15302657.  Clear? yes

Entry 'd37' in ??? (15171585) has deleted/unused inode 15810561.  Clear? yes

Entry 'd38' in ??? (15171585) has deleted/unused inode 15826945.  Clear? yes

Entry 'd39' in ??? (15171585) has deleted/unused inode 15843329.  Clear? yes

Entry 'd40' in ??? (15171585) has deleted/unused inode 15859713.  Clear? yes

Entry 'd41' in ??? (15171585) has deleted/unused inode 15876097.  Clear? yes

Entry 'd42' in ??? (15171585) has deleted/unused inode 15892481.  Clear? yes

Entry 'd43' in ??? (15171585) has deleted/unused inode 15908865.  Clear? yes

Entry 'd44' in ??? (15171585) has deleted/unused inode 15925249.  Clear? yes

Entry 'd45' in ??? (15171585) has deleted/unused inode 15941633.  Clear? yes

Entry 'd46' in ??? (15171585) has deleted/unused inode 15958017.  Clear? yes

Entry 'd67' in ??? (15171585) has deleted/unused inode 16302081.  Clear? yes

Entry 'd68' in ??? (15171585) has deleted/unused inode 16318465.  Clear? yes

Entry 'd69' in ??? (15171585) has deleted/unused inode 16334849.  Clear? yes

Entry 'd70' in ??? (15171585) has deleted/unused inode 16351233.  Clear? yes

Entry 'd71' in ??? (15171585) has deleted/unused inode 16367617.  Clear? yes

Entry 'd72' in ??? (15171585) has deleted/unused inode 16384001.  Clear? yes

Entry 'd73' in ??? (15171585) has deleted/unused inode 16400385.  Clear? yes

Entry 'd74' in ??? (15171585) has deleted/unused inode 16416769.  Clear? yes

Entry 'd75' in ??? (15171585) has deleted/unused inode 16433153.  Clear? yes

Entry 'd76' in ??? (15171585) has deleted/unused inode 16449537.  Clear? yes

Entry 'd80' in ??? (15171585) has deleted/unused inode 16515073.  Clear? yes

Entry 'd87' in ??? (15171585) has deleted/unused inode 16629761.  Clear? yes

Entry 'd91' in ??? (15171585) has deleted/unused inode 16695297.  Clear? yes

Entry 'd95' in ??? (15171585) has deleted/unused inode 16760833.  Clear? yes

Entry 'd99' in ??? (15171585) has deleted/unused inode 16826369.  Clear? yes

Pass 3: Checking directory connectivity
Error while trying to find /lost+found: Ext2 inode is not a directory
/lost+found not found.  Create? yes

Error creating /lost+found directory (ext2fs_link): Ext2 inode is not a directory

/dev/sdb1: ***** FILE SYSTEM WAS MODIFIED *****

     284 inodes used (0%)
       4 non-contiguous inodes (1.4%)
         # of inodes with ind/dind/tind blocks: 86/9/2
30450637 blocks used (-32%)
       0 bad blocks
       2 large files

     170 regular files
      76 directories
       0 character device files
       0 block device files
       0 fifos
       0 links
       0 symbolic links (0 fast symbolic links)
       0 sockets
--------
     246 files
fsck 1.27 (8-Mar-2002)



--------------040709090307020908020204
Content-Type: text/plain;
 name="fsck.out2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fsck.out2"

e2fsck 1.27 (8-Mar-2002)
e2fsck: Attempt to read block from filesystem resulted in short read while trying to open /dev/sdb1
Could this be a zero-length partition?



--------------040709090307020908020204--

