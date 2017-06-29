From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: spin_unlock_wait() in ata_scsi_cmd_error_handler()?
Date: Thu, 29 Jun 2017 11:10:57 -0700
Message-ID: <20170629181057.GA5228@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752609AbdF2SLA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Jun 2017 14:11:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v5TI9O7o016681
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2017 14:10:59 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2bcyr8mdff-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-ide@vger.kernel.org>; Thu, 29 Jun 2017 14:10:59 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ide@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 29 Jun 2017 14:10:58 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello, Tejun!

We are having some discussion about the semantics of spin_unlock_wait(),
and your code has one of them.
(https://marc.info/?l=linux-kernel&m=149730349001044)

We seem to agree that spin_unlock_wait() should provide acquire semantics.
Consider the following admittedly bizarre code fragment:

	CPU 0			CPU 1
	-----			-----
	spin_unlock_wait(&ml);	/* Lock held initially. */
	WRITE_ONCE(x, 1);	r2 = READ_ONCE(x);
	r1 = READ_ONCE(y);	WRITE_ONCE(y, 1);
				spin_unlock(&ml);

	r1 == 0 || r2 == 1 /* again, evaluated "at the end of time" */

CPU 0's spin_unlock_wait() must wait for CPU 1 to release the lock,
which means that CPU 0's memory references must see the result of
CPU 1's memory references and not vice versa.  In other words, the
expression beneath the code fragment cannot hold.

The current sense is that spin_unlock_wait() will -not- provide
release semantics.  This calls for an even more bizarre code fragment:

	CPU 0			CPU 1
	-----			-----
	WRITE_ONCE(x, 1);	spin_lock(&ml);
	r1 = READ_ONCE(y);	r2 = READ_ONCE(x);
	spin_unlock_wait(&ml);	WRITE_ONCE(y, 1);
	WRITE_ONCE(z, 1);	/* Intentionally not releasing lock! */

	z == 1 && (r1 == 1 || r2 == 0) /* evaluated "at the end of time" */

If this code fragment doesn't deadlock, then CPU 0's spin_unlock_wait()
must have executed before CPU 1's spin_lock().  However, even on x86,
CPU 0's prior writes can be reordered with its subsequent reads, which
means that r1 == 0 is possible, which means that the above condition
could hold, even on x86.

One of the uses of spin_unlock_wait() is in ata_scsi_cmd_error_handler()
in the file drivers/ata/libata-eh.c.  Your commit ad9e27624479b
("libata-eh-fw: update ata_scsi_error() for new EH") last touched it,
though it predates that commit.

My question to you is whether the code in ata_scsi_cmd_error_handler()
needs release semantics.  If it does, my recommendation is to replace
the spin_unlock_wait(ap->lock) with this (adding the needed curly braces,
of course):

	spin_lock(ap->lock);
	spin_unlock(ap->lock);

If the code only needs acquire semantics, no change required.

If your code requires release semantics, and there is some reason why
my suggested replacement above is a bad idea, please let me know!

							Thanx, Paul

