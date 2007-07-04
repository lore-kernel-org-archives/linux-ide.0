From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Tue, 03 Jul 2007 19:05:14 -0700
Message-ID: <courier.468B005A.0000127A@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <468A0E24.7020000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:49566 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753173AbXGDCFP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 22:05:15 -0400
In-Reply-To: <468A0E24.7020000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: 7091@blargh.com, linux-ide@vger.kernel.org, jgarzik@pobox.com

Tejun Heo writes: 

> Sounds awfully similar to the recent nvidia data corruption issue.  It
> was involving the IOMMU and one of the workarounds was not using IOMMU,
> IIRC.  Please turn off IOMMU and see what happens.  You can turn IOMMU
> off by passing "iommu=off" as kernel parameter. 
> 
> -- 
> tejun

Blast.  I stand corrected - it didn't fix it. 

I now have 3 300G drives hanging off the add-in card, sda sdb sdc.  I did 
the following: 

# Make a RAID5 array of 3 out of the 4 drives I'll eventually be using
mdadm --create /dev/md6 --chunk=64 --level=raid5 --raid-devices=4 /dev/sda1 
/dev/sdb1 /dev/sdc1 missing
# Make the FS
mkfs.ext3 /dev/md6
# Test
cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso kn1.iso
cp kn1.iso kn2.iso
cp kn2.iso kn3.iso
cp kn3.iso kn4.iso
# Check
md5sum *.iso
eea5ecb53f1c6a397bcfeedc2fd42c64  kn1.iso
0360941210aa2d7159999e37c636f8cb  kn2.iso
md5sum: kn3.iso: Input/output error
86b008915fe02569a513b6c5ec45a523  kn4.iso 

In the dmesg:
[ 2619.483783] attempt to access beyond end of device
[ 2619.483956] md6: rw=0, want=25890291976, limit=1758201216
[ 2619.484121] attempt to access beyond end of device
[ 2619.484284] md6: rw=0, want=30654872552, limit=1758201216
[ 2619.484452] attempt to access beyond end of device
[ 2619.484614] md6: rw=0, want=33748316016, limit=1758201216
[ 2619.484780] attempt to access beyond end of device
[ 2619.484943] md6: rw=0, want=7818926368, limit=1758201216
[ 2619.485122] attempt to access beyond end of device
[ 2619.485285] md6: rw=0, want=32912340352, limit=1758201216
[ 2619.485451] attempt to access beyond end of device
[ 2619.496228] md6: rw=0, want=2277136440, limit=1758201216
[ 2619.496394] attempt to access beyond end of device
[ 2619.496557] md6: rw=0, want=2128357688, limit=1758201216
[ 2619.529625] attempt to access beyond end of device
[ 2619.530392] md6: rw=0, want=25890291976, limit=1758201216
