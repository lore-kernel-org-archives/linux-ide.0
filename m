From: Zhang Rui <rui.zhang@intel.com>
Subject: sata driver fails to work after resume from S3
Date: Fri, 26 Jan 2007 15:46:42 +0800
Message-ID: <1169797602.25758.85.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: jgarzik@pobox.com, forrest.zhao@gmail.com, kristen.c.accardi@intel.com
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hi,
I met a problem that sata driver fails to work after resume from S3.
The kernel version is 2.6.16.33.

After resume from S3,
I got the following messages:
First, "ATA: abnormal status 0x80 on port 0x1F7" for 3 times.
Then, "sd 0:0:0(sometimes is 1):0: SCSI error: return code=0x40000
end_request: I/O error, dev sdb, sector ....
Buffer I/O error on device dm-0, logical block...
lost page write due to I/O error on device dm-0"
keeps on popping up.
Finally I got a message saying that "Remounting filesystem read-only"
and can't access the disk any more.

The problem is exactly like bug6262 in bugzilla, except for
this happens when I set SATA mode to "compatibility"(not "AHCI").
I can confirm that it is fixed in the 2.6.18.

But how to make SATA drive S3 work properly in 2.6.16.33?
I found several similar bugs, but the final conclusion I got is
"This is fixed in linux-2.6.18..." and I can not find the original patches
against this problem.
I think the patch set "ACPI support for SATA/PATA" from Forrest and
updated by Kristen may be helpful. But I can't apply them to 2.6.16.33
due to too much changes in sata driver.

Do I need to open a bug report in bugzilla?
Does the patch set really make sense to my problem?
If so, any patch I should apply first?
If not, which patches I should test?

Is there anyone who could show me what I should do please?
Any comment is appreciated. Thanks in advance.


Thanks,
Rui
