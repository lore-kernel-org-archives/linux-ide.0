From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend regression?] AHCI: Fix threaded interrupt setup
Date: Thu, 13 Nov 2014 10:44:41 +0100
Message-ID: <1415871882-634-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932136AbaKMJot (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Nov 2014 04:44:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

Since this patch mentioned sunxi it gained my attention, but as it touches
ahci core code I was expecting you to pick it up, which seems to not have
happened, so hence this resend.

FWIW I've tried to reproduce the problem, but it does not reproduce for me,
that does not mean it is not a real problem though. I'm afraid I'm to
unfamiliar with the ahci interrupt handling to say anything more sensible
about this.

It looks like this is a 3.18 regression, so if this is a real issue, we
should probably get this patch in for 3.18 .

Regards,

Hans
