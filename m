From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] ata_piix: implement SIDPR SCR access
Date: Fri,  4 Jan 2008 18:42:19 +0900
Message-ID: <1199439744356-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:58729 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496AbYADJmc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 Jan 2008 04:42:32 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6064375rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 04 Jan 2008 01:42:31 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org


This patchset implements SIDPR SCR access which is available for ICH8
and above.  With SIDPR SCR access enabled, ata_piix ports can access
PHY events and errors and can also be hardreset which is important as
in rare cases hardreset is necessary to recover from error conditions.

This patchset contains five patches.  The first two are misc clean up
patches.  3rd and 4th reorganize ata_piix initialization routine.  5th
implements SIDPR SCR access.

This patchset is against the current libat-dev#upstream (32a03e13).

Thanks.

--
tejun
