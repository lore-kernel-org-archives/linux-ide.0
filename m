From: Brian Norris <computersforpeace@gmail.com>
Subject: [upstream-next] ahci start engine
Date: Fri, 21 Oct 2011 15:27:40 -0700
Message-ID: <CAN8TOE8mTWrHOZd08RhZttARGsa74fGmB7f044GHScA87PJcyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45693 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab1JUW1l (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2011 18:27:41 -0400
Received: by wyg36 with SMTP id 36so4456083wyg.19
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2011 15:27:40 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

Hi Jeff,

If you recall, there was an AHCI hardware bug I was working on a while
back that Tejun helped me solve (or at least mitigate). In the end, a
patch was pushed to your libata-dev/upstream-next branch at
kernel.org. Since then, kernel.org went down (along with your tree). I
only recently located your new github repository, and I can't find the
patch anywhere. Has it been dropped? This is the patch header leftover
in my tree:

commit 936f82ad2254a6712175a36daee9517d6b7a4982
Author: Tejun Heo <tj@kernel.org>
Date:   Fri Jul 22 11:41:26 2011 +0200

    ahci: start engine only during soft/hard resets


I can resubmit the entire patch to you if you'd like. I'd appreciate
it if this could make it upstream soon.

Thanks,
Brian
