From: Chris Dunlop <chris@onthe.net.au>
Subject: Libata_error_messages
Date: Tue, 25 Oct 2011 16:59:59 +1100
Message-ID: <20111025055959.GA15707@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:46794 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1JYGAD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Oct 2011 02:00:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 38165613D0
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2011 17:00:01 +1100 (EST)
Received: from smtp1.onthe.net.au ([127.0.0.1])
	by localhost (smtp1.onthe.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWDeRYlbHQlZ for <linux-ide@vger.kernel.org>;
	Tue, 25 Oct 2011 17:00:00 +1100 (EST)
Received: from o1.office.otn.net.au (unknown [180.148.179.26])
	by smtp1.onthe.net.au (Postfix) with ESMTP id 281A8613AE
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2011 16:59:59 +1100 (EST)
Received: from achates.office.onthe.net.au (achates.office.onthe.net.au [10.1.32.53])
	by o1.office.otn.net.au (Postfix) with ESMTP id CC8837A647
	for <linux-ide@vger.kernel.org>; Tue, 25 Oct 2011 16:59:58 +1100 (EST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

Whilst kernel.org is in recovery, does anyone have a copy of
this page?

http://ata.wiki.kernel.org/index.php/Libata_error_messages

Background: linux-3.0. We have a SiI3124 SATA controller
connected to 4 SiI3826 PMPs, with 5 disks each on each of the
1st 3 PMPs. We've been performing a moderate write load to the
1st and 3rd PMPs (loading up data over the network). The 2nd PMP
has been unused (disks not mounted). However we had a number
of errors reported on the last disk of the unused 2nd PMP:

$ grep -A1 'exception Emask' /var/log/kern.log
Oct 23 17:03:54 b2 kernel: [174268.531357] ata2.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Oct 23 17:03:54 b2 kernel: [174268.533946] ata2.04: SError: { PHYRdyChg DevExch }
--
Oct 23 17:19:17 b2 kernel: [175192.489591] ata2.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Oct 23 17:19:17 b2 kernel: [175192.492189] ata2.04: SError: { PHYRdyChg DevExch }
--
Oct 23 17:39:35 b2 kernel: [176410.375953] ata2.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Oct 23 17:39:35 b2 kernel: [176410.378545] ata2.04: SError: { PHYRdyChg DevExch }
--
Oct 23 17:54:40 b2 kernel: [177315.299991] ata2.04: exception Emask 0x10 SAct 0x0 SErr 0x4010000 action 0xf
Oct 23 17:54:40 b2 kernel: [177315.302595] ata2.04: SError: { PHYRdyChg DevExch }

After the last one that port dropped out altogether:

Oct 23 17:54:58 b2 kernel: [177332.952204] ata2.04: PHY status changed but maxed out on retries, giving up
Oct 23 17:54:58 b2 kernel: [177332.954696] ata2.04: Manully issue scan to resume this link


Cheers,

Chris
