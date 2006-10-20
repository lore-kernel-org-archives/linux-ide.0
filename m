From: Tejun Heo <htejun@gmail.com>
Subject: regarding sata_sis kernel freeze when BIOS is not updated to support
 LBA48
Date: Fri, 20 Oct 2006 17:36:23 +0900
Message-ID: <45388A87.1010304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:53559 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992585AbWJTIgd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Oct 2006 04:36:33 -0400
Received: by nf-out-0910.google.com with SMTP id c2so1349415nfe
        for <linux-ide@vger.kernel.org>; Fri, 20 Oct 2006 01:36:31 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: uwe.koziolek@gmx.net, Jeff Garzik <jgarzik@pobox.com>
Cc: Alexey Fisher <bug-track@fisher-privat.net>, Andrew Morton <akpm@osdl.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello, Uwe Koziolek, Jeff.

Alexey Fisher has filed bug #7314 and resolved it by himself.  :-)

http://bugzilla.kernel.org/show_bug.cgi?id=7314

The problem seems that the BIOS isn't updated to support LBA48 but 
libata doesn't know about it and issue LBA48 commands anyway.  I suppose 
there's a way to detect this mechanism.  We can either force LBA28 mode 
or at least print warning message urging the user to upgrade BIOS if 
such condition is detected.

Any ideas on how to detect this?

Thanks.

-- 
tejun
