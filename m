From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bug 4275] New: filesystems no longer modifiable after stress
 tests
Date: Wed, 2 Mar 2005 12:46:04 -0800
Message-ID: <20050302124604.5295a9a1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from fire.osdl.org ([65.172.181.4]:62873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262486AbVCBUql (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Mar 2005 15:46:41 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: dgardnr@us.ibm.com


Your IDE disk shat itself.

hdc: dma_timer_expiry: dma status == 0x20

Begin forwarded message:

Date: Wed, 2 Mar 2005 12:08:04 -0800
From: bugme-daemon@osdl.org
To: akpm@digeo.com
Subject: [Bug 4275] New: filesystems no longer modifiable after stress tests


http://bugme.osdl.org/show_bug.cgi?id=4275

           Summary: filesystems no longer modifiable after stress tests
    Kernel Version: 2.6.11-rc4-mm1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: dgardnr@us.ibm.com
                CC: mridge@us.ibm.com


Distribution:SuSE SLES 9 sp1
Hardware Environment:xseries - x305
Software Environment:Linux version 2.6.11-rc4-mm1

Problem Description:
After running LTP filesystem stress tests, I am no longer able to modify either
of the filesystems that I was testing. In /testfs2(ext3) I am unable to delete
any existing  files, but ls is able to complete. I cannot get even that in
/testfs3(jfs). This problem occurs within just a few hours. I tried to reproduce
with SUSE's 2.6.5-7.139 kernel but had no problems even after a couple of days.

Steps to reproduce:
LTP fsstress: fsstress -d /testfs2 -n 500 -p 500 -r
postmark: postmark /testfs3

------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
