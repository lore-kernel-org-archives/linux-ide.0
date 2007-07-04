From: 7091@blargh.com
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Tue, 03 Jul 2007 20:44:49 -0700
Message-ID: <courier.468B17B1.00001A78@blargh.com>
References: <courier.4689EFD9.0000589A@blargh.com>
            <468A0E24.7020000@gmail.com>
            <courier.468B005A.0000127A@blargh.com>
            <courier.468B1258.000018F4@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from blargh.com ([24.234.115.147]:41528 "EHLO blargh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbXGDDou (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jul 2007 23:44:50 -0400
In-Reply-To: <courier.468B1258.000018F4@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Apologies for the chain-replying to myself, just replying as I think of 
things to try. 

7091@blargh.com writes: 

> Here's an odd data point.  
> 
> I just broke that array, formatted all three of those partitions 
> seperately, mounted and did my ISO copy test.  
> 
> All three drives, run one at a time, function fine.  No corruption.

Here's another odd one.  I did the following:
# Mount all 3 drives as individuals...
mount /dev/sda1 /mnt/a
mount /dev/sdb1 /mnt/b
mount /dev/sdc1 /mnt/c
# Copy the same file to all three drives at the same time
cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso a/kn10.iso &
cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso b/kn10.iso &
cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso c/kn10.iso & 

Got massive corruption.
