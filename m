From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 4 Jul 2007 10:18:35 +0100
Message-ID: <20070704101835.064bae93@the-village.bc.nu>
References: <courier.4689EFD9.0000589A@blargh.com>
	<468A0E24.7020000@gmail.com>
	<courier.468B005A.0000127A@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58362 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756326AbXGDJNA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:13:00 -0400
In-Reply-To: <courier.468B005A.0000127A@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

> # Make a RAID5 array of 3 out of the 4 drives I'll eventually be using
> mdadm --create /dev/md6 --chunk=64 --level=raid5 --raid-devices=4 /dev/sda1 
> /dev/sdb1 /dev/sdc1 missing
> # Make the FS
> mkfs.ext3 /dev/md6
> # Test
> cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso kn1.iso
> cp kn1.iso kn2.iso
> cp kn2.iso kn3.iso
> cp kn3.iso kn4.iso
> # Check
> md5sum *.iso
> eea5ecb53f1c6a397bcfeedc2fd42c64  kn1.iso
> 0360941210aa2d7159999e37c636f8cb  kn2.iso
> md5sum: kn3.iso: Input/output error
> 86b008915fe02569a513b6c5ec45a523  kn4.iso 

Not suprised to be honest. We have a large number of reports that are all
of the following form

	"Nvidia chipset, Silicon Image SATA, corruption"

and several reports that BIOS updates fixed it. Unfortunately we don't
know what the BIOS updates do (or indeed if what they do is board
specific) or how to work around it otherwise.

Alan
