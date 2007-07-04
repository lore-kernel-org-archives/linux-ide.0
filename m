From: Tejun Heo <htejun@gmail.com>
Subject: Re: sata_sil, writing bug with multiple cards?
Date: Wed, 04 Jul 2007 12:53:30 +0900
Message-ID: <468B19BA.6030202@gmail.com>
References: <courier.4689EFD9.0000589A@blargh.com>            <468A0E24.7020000@gmail.com>            <courier.468B005A.0000127A@blargh.com>            <courier.468B1258.000018F4@blargh.com> <courier.468B17B1.00001A78@blargh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:46474 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbXGDDxf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 23:53:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3101241wah
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 20:53:35 -0700 (PDT)
In-Reply-To: <courier.468B17B1.00001A78@blargh.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7091@blargh.com
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com, ak@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

7091@blargh.com wrote:
> Apologies for the chain-replying to myself, just replying as I think of
> things to try.
> 7091@blargh.com writes:
>> Here's an odd data point. 
>> I just broke that array, formatted all three of those partitions
>> seperately, mounted and did my ISO copy test. 
>> All three drives, run one at a time, function fine.  No corruption.
> 
> Here's another odd one.  I did the following:
> # Mount all 3 drives as individuals...
> mount /dev/sda1 /mnt/a
> mount /dev/sdb1 /mnt/b
> mount /dev/sdc1 /mnt/c
> # Copy the same file to all three drives at the same time
> cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso a/kn10.iso &
> cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso b/kn10.iso &
> cp KNOPPIX_V5.1.0CD-2006-12-30-EN.iso c/kn10.iso &
> Got massive corruption.

Hmmm... I don't think this is sata_sil driver bug.  cc'ing Andi Kleen
and lkml.  Andi, the original thread can be read from

http://thread.gmane.org/gmane.linux.ide/20213

Any ideas?

-- 
tejun
