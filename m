From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET libata-dev#upstream] ata_piix: implement SIDPR SCR access, take #2
Date: Fri, 18 Jan 2008 18:36:27 +0900
Message-ID: <12006489901911-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:36643 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755126AbYARJgj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Jan 2008 04:36:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so835843rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 18 Jan 2008 01:36:37 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

This patchset implements SIDPR SCR access which is available for ICH8
and above.  With SIDPR SCR access enabled, ata_piix ports can access
PHY events and errors and can also be hardreset which is important as
in rare cases hardreset is necessary to recover from error conditions.

Changes from the last take [L] are...

* Dropped first two accepted patches.

* Re-generated against the current upstream.

This patchset is against the current libat-dev#upstream (2de8d964).

Thanks.

--
tejun

[L] http://thread.gmane.org/gmane.linux.ide/26780
