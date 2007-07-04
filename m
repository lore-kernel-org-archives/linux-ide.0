From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 12:41:13 +0900
Message-ID: <468B16D9.9000004@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com>            <468A0E24.7020000@gmail.com> <courier.468B005A.0000127A@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:24168 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925AbXGDDlT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 23:41:19 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3098653wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 20:41:19 -0700 (PDT)
In-Reply-To: <courier.468B005A.0000127A@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

7091@blargh.com wrote:
> Tejun Heo writes:
>> Sounds awfully similar to the recent nvidia data corruption issue.  It
>> was involving the IOMMU and one of the workarounds was not using IOMMU,
>> IIRC.  Please turn off IOMMU and see what happens.  You can turn IOMMU
>> off by passing "iommu=off" as kernel parameter.
>> -- 
>> tejun
> 
> Blast.  I stand corrected - it didn't fix it.
> I now have 3 300G drives hanging off the add-in card, sda sdb sdc.  I
> did the following:
> # Make a RAID5 array of 3 out of the 4 drives I'll eventually be using
> mdadm --create /dev/md6 --chunk=64 --level=raid5 --raid-devices=4
> /dev/sda1 /dev/sdb1 /dev/sdc1 missing
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
> In the dmesg:
> [ 2619.483783] attempt to access beyond end of device
> [ 2619.483956] md6: rw=0, want=25890291976, limit=1758201216

Something went very wrong here and it probably doesn't have much to do
with IOMMU corruption.  Care to post full dmesg?

-- 
tejun
