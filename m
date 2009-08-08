From: Jim Duda <jim@duda.tzo.com>
Subject: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sat, 08 Aug 2009 16:30:35 -0400
Message-ID: <h5kn9c$51r$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:52964 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305AbZHHUuD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 8 Aug 2009 16:50:03 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MZsra-0000uA-7y
	for linux-ide@vger.kernel.org; Sat, 08 Aug 2009 20:50:02 +0000
Received: from pool-96-252-13-163.bstnma.fios.verizon.net ([96.252.13.163])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 20:50:02 +0000
Received: from jim by pool-96-252-13-163.bstnma.fios.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 08 Aug 2009 20:50:02 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm having trouble using my STT2000A ATAPE TAPE drive after upgrading to 
at least kernel 2.6.30.  I use the tape drive solely for tape backup 
using simple tar commands.

In previous kernels, I was able to access the tape drive using the 
ide-scsi adaptation layer with /dev/st0

I realize that in transitioning through 2.6.30 the kernel has abandoned 
the use of ide-scsi.  As I understand it, ide-tape interacts directly 
with the tape drive and I am supposed to now use /dev/ht0.

My dmesg message with respect to ide-tape are below.

linux> uname -a
Linux linux 2.6.31-rc1 #3 SMP PREEMPT Tue Aug 4 20:35:30 EDT 2009 i686 
i686 i386 GNU/Linux

linue> dmesg | grep tape
hdd: Seagate STT20000A, ATAPI TAPE drive
ide-tape: hdd <-> ht0: Seagate STT20000A rev 8A51
ide-tape: hdd <-> ht0: 232KBps, 6*54kB buffer, 400ms tDSC
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2
ide-tape: Couldn't write a filemark
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2
ide-tape: Couldn't write a filemark
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2
ide-tape: ht0: I/O error, pc = 10, key =  0, asc =  0, ascq =  2

With kernel 2.6.30, I found that I couldn't use my tape drive at all. 
Any attempt to use the tape drive resulted in an error message which 
indicated the "drive was busy and unavailable" (I forget the exact error 
string).

I upgraded to kernel 2.6.31-rc1.  With this kernel, I can at least 
access the tape drive using /dev/ht0.

I have found the following behavior.

1) I'm using large 20G byte Travan tapes.  I backup using tar -czf 
/dev/ht0.  With previous kernels, I used /dev/st0.  With the st driver, 
I was able to backup 15G+ bytes of compressed tar information in just a 
couple of hours.  With 2.6.31-rc1, I have the same approximate backup 
amount, however, the backup fails because my tape device runs out of 
space.  If I untar the compressed image from tape back to disk, the 
uncompressed filesize is ~16GB of information.  I don't understand with 
with ht0 instead of st0, I cannot take full advantage of the 20G Travan 
tapes.  I can only assume that the compressed data size is less than 16G 
bytes.

2) I have found that mt -f /dev/ht0 status doesn't give me the same 
amount of information with /dev/st0 used to.  Here is an example.

linux> sudo mt -f /dev/ht0 status
SCSI 2 tape drive:
File number=0, block number=0, partition=0.
Tape block size 512 bytes. Density code 0x0 (default).
Soft error count since last status=0
General status bits on (0):

I forget all the details of how mt reported with st0, however, I do 
recall that I received a message indicating if a TAPE was in the drive 
with a DR_OPEN (DR_CLOSED) message string.

3) I have found that using tar with /dev/ht0 is so much slower than when 
I used tar with /dev/st0.  What used to take a couple of hours now takes 
twice as long, and the tape drive fills up.

I hope I don't sound as though I'm complaining.  I realize that "rc1" 
indeed means "release candidate".  I haven't upgraded beyond "rc1" yet 
since I haven't seen any release notes which apply.

I'm using 2.6.31-rc1 because I need at least 2.6.30 for some other 
application, and only 2.6.31-rc1 appears to allow me to use my tape drive.

I'd love to help out debugging or testing in any way I can.

Regards,

Jim



