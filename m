From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: {linux-ide] ide errors redhat 9.0 install
Date: 07 Jun 2004 07:59:37 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1086616777.3649.10.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:37036 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S264646AbUFGN7r
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 7 Jun 2004 09:59:47 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id 330261ADF
	for <linux-ide@vger.kernel.org>; Mon,  7 Jun 2004 07:59:46 -0600 (MDT)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> List:       linux-ide
> Subject:    {linux-ide]  ide errors redhat 9.0 install
> From:       "Paul Gimpelj" <pgi...()sym...>
> Date:       2004-06-04 3:59:37
> ...
> open source documentation on ... bus mastering ...

When I last googled in 2004-03, I found:

/* Design references include these Three sets:
 *
 * 1) ATAPI CDB's:
 *
 *      bleeding edge: (mmc 5 not yet available)
 *      last stable: http://www.t10.org/ftp/t10/drafts/mmc4/mmc4r02g.pdf
 *      oldest original: http://www.bswd.com/sff8020i.pdf
 *
 * 2) ATAPI I/O:
 *
 *      last stable: http://www.t13.org/docs2002/d1410r3b.pdf (ATA/PI 6.3b)
 *      oldest original: (again sff 8020i, see above)
 *
 * 3) PC I/O:
 *
 *      http://developer.intel.com/design/chipsets/datashts/
 *      http://www.ctyme.com/intr/int.htm
 *      http://lxr.linux.no/source/include/linux/pci_ids.h
 *      http://www.google.com/search?q=intel+corporation+pci.exe+version+2.2
 *
 *      Intel ICH5 25251601.pdf
 *
 *      "Undocumented PC"
 *      http://www.amazon.com/exec/obidos/ASIN/0201622777
 *
 *              "Chapter 7" "Interrupt Vector Table"
 *                      esp. IRQ 2 9 14 15
 *
 *              "Chapter 17" "Interrupt Control and NMI"
 *
 *      "PCI System Architecture", Third Edition, 1995 MindShare
 *      http://www.amazon.com/exec/obidos/ASIN/0201409933
 *      http://www.amazon.com/exec/obidos/ASIN/0201309742
 *
 *      !!FIXME: Find doc to say PIC IRR falls when INTRQ falls.
 */

Pat LaVarre


