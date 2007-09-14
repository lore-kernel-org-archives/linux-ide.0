From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Subject: Re: HSM violation on bootup, ICH7 + ata_piix 2.6.22
Date: Fri, 14 Sep 2007 16:09:25 +0100
Message-ID: <1189782565.4978.17.camel@ukabzc383.uk.saic.com>
References: <46E254D7.5020902@gmail.com>
	 <1189414783.13360.16.camel@ukabzc383.uk.saic.com>
	 <46E998F2.8070301@gmail.com>
	 <Pine.LNX.4.63.0709140853350.24438@trinity.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpmx2.mail.saic.com ([139.121.17.172]:57865 "EHLO
	cpmx2.mail.saic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXINPJy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Sep 2007 11:09:54 -0400
In-Reply-To: <Pine.LNX.4.63.0709140853350.24438@trinity.phys.uwm.edu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Tejun Heo <htejun@gmail.com>, Bruce Allen <bruce.allen@aei.mpg.de>, Douglas Gilbert <dougg@torque.net>, Smartmontools Developers List <smartmontools-devel@lists.sourceforge.net>, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-ide@vger.kernel.org

OK,


On Fri, 2007-09-14 at 08:56 -0500, Bruce Allen wrote:
...
> Eamonn: could you please build the latest version of smartmontools from 
> CVS HEAD source and see if the problem exists in that version?  Then write 
> back.  I don't think this will help but want to eliminate obvious things.
> 


I built the latest version which reports itself as 5.38 from cvs.

The results, as you suspected, were no different. 

The setup :

The system is setup with sda and sdb being partitioned as follows :
/dev/sda1   *           1         243     1951866   fd  Linux raid
autodetect
/dev/sda2             244        1459     9767520   fd  Linux raid
autodetect
/dev/sda3            1460        1824     2931862+  fd  Linux raid
autodetect
/dev/sda4            1825       19452   141596910    5  Extended
/dev/sda5            1825        7295    43945776   fd  Linux raid
autodetect
/dev/sda6            7296       19452    97651071   fd  Linux raid
autodetect


raid1 mirrors are then setup between the corresponding partitions on the
two disks.

The results :

using either 5.37 or 5.38, issuing a smartctl -t long on either one of
the disk devices allows filesystem access at full speed, and issuing a
smartctl -X on the disk returns inside a second. All is well:

time dd if=/dev/zero of=file bs=1k count=1024
1024+0 records in
1024+0 records out
1048576 bytes (1.0 MB) copied, 0.00488519 seconds, 215 MB/s


Starting an extended self-test on *both* disks, however, and filesystem
access is *extremely* slow, which may be why the violations are
happening, although I didn't leave it running long enough to impact the
box:
 time dd if=/dev/zero of=file bs=1k count=1024
1024+0 records in
1024+0 records out
1048576 bytes (1.0 MB) copied, 0.00505913 seconds, 207 MB/s

real    0m9.107s
user    0m0.000s
sys     0m0.004s

Now, I'm asking the guy who runs the system as to when I can test the
smartd, but I'm guessing from this that the results will be exactly the
same.

Comments?

Cheers,
Eamonn



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

