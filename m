From: "Andrew Lyon" <andrew.lyon@gmail.com>
Subject: Testing with 2.6.19-rc5
Date: Wed, 15 Nov 2006 14:45:27 +0000
Message-ID: <f4527be0611150645h7cc2791cub7a2ca753156564f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:23955 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030502AbWKOOp3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 09:45:29 -0500
Received: by ug-out-1314.google.com with SMTP id m3so150604ugc
        for <linux-ide@vger.kernel.org>; Wed, 15 Nov 2006 06:45:27 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Andrew,

You asked me to test if the issues I reported (Re: JMicron 20360/20363
AHCI Controller much slower with 2.6.18 / Re: SATA CD/DVDRW Support in
2.6.18? / Re: Problems with Samsung SH-W163A SATA CD/DVDRW JMicron
20360/20363 2.6.18.1) were still present with 2.6.19-rc5, I tried it
today and ran into a very strange problem, the 4 400gb Samsung SATA
HDs connected to ata_piix were detected as normal but the raid that
they belong to failed to start, the raid system couldnt find any
superblock at all.

Is it possible that the addressing of the sectors has changed such
that the device data structure does not map to the on disk data in the
same way as it did with 2.6.18.x ? unfortunately they drives are not
partitioned, just added straight to the raid, otherwise checking the
partition table would be a good test.

I had a idea about taking a copy of a few kbs of data from each drive
using both kernel versions and comparing them, but if the raid is
started under 2.6.18 its possible the data would change anyway.. so I
dont think that would work.

Any suggestions? I really want to complete testing of the two issues I
reported..

Thanks
Andy
