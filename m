From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 18:14:42 +0900
Message-ID: <468B6502.6020904@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com>	<468A0E24.7020000@gmail.com>	<courier.468B005A.0000127A@blargh.com> <20070704101835.064bae93@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:49713 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980AbXGDJOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 05:14:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1507648nze
        for <linux-ide@vger.kernel.org>; Wed, 04 Jul 2007 02:14:47 -0700 (PDT)
In-Reply-To: <20070704101835.064bae93@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com, Andi Kleen <ak@suse.de>

Alan Cox wrote:
>> # Make a RAID5 array of 3 out of the 4 drives I'll eventually be using
>> mdadm --create /dev/md6 --chunk=64 --level=raid5 --raid-devices=4 /dev/sda1 
>> /dev/sdb1 /dev/sdc1 missing
>> # Make the FS
>> mkfs.ext3 /dev/md6
>> # Test
>> cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso kn1.iso
>> cp kn1.iso kn2.iso
>> cp kn2.iso kn3.iso
>> cp kn3.iso kn4.iso
>> # Check
>> md5sum *.iso
>> eea5ecb53f1c6a397bcfeedc2fd42c64  kn1.iso
>> 0360941210aa2d7159999e37c636f8cb  kn2.iso
>> md5sum: kn3.iso: Input/output error
>> 86b008915fe02569a513b6c5ec45a523  kn4.iso 
> 
> Not suprised to be honest. We have a large number of reports that are all
> of the following form
> 
> 	"Nvidia chipset, Silicon Image SATA, corruption"
> 
> and several reports that BIOS updates fixed it. Unfortunately we don't
> know what the BIOS updates do (or indeed if what they do is board
> specific) or how to work around it otherwise.

I thought good number of those were the IOMMU bug but I could be
mistaken.  Considering the large number of sata_sil's in the field, it's
a bit surprising to see we still have this kind of problem.  :-(

-- 
tejun
