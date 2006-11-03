From: Nathaniel Case <ncase@xes-inc.com>
Subject: Buffer-cache corruption with SMP + PIO IDE
Date: Thu, 02 Nov 2006 18:01:28 -0600
Message-ID: <1162512088.5339.84.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.214]:52367 "EHLO xes-mad.com")
	by vger.kernel.org with ESMTP id S1752756AbWKCABa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Nov 2006 19:01:30 -0500
Received: from [10.52.0.27] ([10.52.0.27])
	by xes-mad.com (8.11.6/8.11.6) with ESMTP id kA301ch04808
	for <linux-ide@vger.kernel.org>; Thu, 2 Nov 2006 18:01:38 -0600
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello,

I'm looking for some guidance in tracking down this strange drive
corruption that occurs under the following conditions:

	- IDE (PIO mode)
	- SMP system
	- Buffer-cache is filled as much as it can be filled
	- No swap file used

My test showing the corruption is a stupid script that extracts a
large .tar.bz2 file to the drive's filesystem, then verifies MD5
checksums of each extracted file against a list of known checksum
values.  It then deletes the extracted files, and repeats the whole
process forever.

When the corruption happens, the MD5 sums for maybe 5-20 of the 1000+
files will be wrong.  In the corrupted files, I see that it's missing 2
bytes somewhere in the middle in a few places, and then after a chunk of
valid data I see two bogus "0xd0" bytes.  In all files, it always seems
to be "0xd0 0xd0".  It looks like it actually wrote the data fine to
disk, but is wrong in the buffer cache.

Platform: An embedded single-board computer with dual MPC7448 processors

The problem exists both while using a PMC hard drive (controller
accessed over PCI bus) and an IDE controller on the board's FPGA wired
to a CompactFlash slot.  I verified that the corruption happened with
both ext3 and ReiserFS.

The problem does NOT occur if I use DMA mode with the PMC hard drive, or
on a Uniprocessor kernel.  Maybe nobody has stumbled upon this since the
combination of a multiprocessor system with PIO IDE seems unlikely?

Also, and I think this is key: The test will run fine until it appears
that the buffer-cache occupies as much memory as it can.  That is, if I
run a simple program that mallocs 300 MB in the background while the
test runs, it will fail quite soon.   I initially chalked it up to
expected behavior for a low-memory situation, but the same test setup
runs fine in a uniprocessor kernel though.

Using kernel 2.6.16, but I'm fairly sure this problem also happened in
2.6.11 as well.

Any ideas?  I've tried things like disabling the L2 cache on both CPUs,
enforcing HW cache-coherency, adding additional spin-locks in places,
but to no avail.

Thanks,

- Nate Case <ncase@xes-inc.com>

