From: Richard Scobie <richard@sauce.co.nz>
Subject: Hot swapping drives
Date: Fri, 18 Apr 2008 09:31:45 +1200
Message-ID: <4807C1C1.4070808@sauce.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:40940 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbYDQVaG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Apr 2008 17:30:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Apologies if this is the wrong list for this.

I have a SAS backplane filled with 16 SATA drives.

Assuming a drive is unmounted or failed and removed from an md array, is 
it safe to directly pull the drive and insert a new one, or are there 
other commands required in order to remove power from it first?

Just concerned about electrical damage to drive/backplane here.

Regards,

Richard
