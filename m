From: Stuart_Hayes@Dell.com
Subject: IDE "logical" geometry & partition tables (problem with 2.4
 kerne l, also seems to apply to 2.6)
Date: Tue, 21 Oct 2003 17:00:54 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <CE41BFEF2481C246A8DE0D2B4DBACF4F128A38@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ausadmmsps307.aus.amer.dell.com ([143.166.224.102]:48388 "HELO
	AUSADMMSPS307.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S263411AbTJUWBh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2003 18:01:37 -0400
List-Id: linux-ide@vger.kernel.org
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Bart --

I have discovered a problem with how Linux determines IDE disk "logical"
(BIOS) geometry.  It only happens under certain unlikely conditions, but I
think it is worthy of attention.  Please let me know if you see a problem
with my analysis!

If an IDE hard drive has no partition table when Linux is booted, *and* if
the hard drive is on a PCI IDE controller (a controller that isn't at I/O
address 1f0h), *and* if the drive doesn't support 48-bit addressing, Linux
will just use the geometry that is reported by the drive in with the
"identify device" command, rather than getting the geometry used by the IDE
BIOS by doing an int13 function 8 call.  If a partition table is then
created on the drive using this geometry, the CHS values in the partition
table will not be correct.

This will cause the drive not to boot if an MBR is used that does CHS
addressing (rather than LBA addressing)--or if the IDE BIOS doesn't support
the int13 extentions that allow LBA addressing.

If the drive is on an IDE controller that's at 1F0h (like the primary
channel on CSB5/ICH5 south bridge controllers), Linux seems to get the
correct geometry from the BIOS tables (I believe the 2.6 kernel doesn't even
do this).  Also, if the drive supports 48-bit addressing, Linux assumes 255
heads/63 sectors, which is probably correct for all PCI IDE controllers.
Or, if the drive has an existing partition table, Linux is typically able to
figure out the correct geometry to use by looking at that table.

I would think that the best solution might be either to use an int13
function 8 call, or assuming 255 heads 63 sectors, if the drive geometry
can't be read from the BIOS table or figured out from an existing partition
table.  The geometry reported by the drive itself is almost certain to be
different from the BIOS geometry.

Thanks,
Stuart
stuart_hayes@dell.com

