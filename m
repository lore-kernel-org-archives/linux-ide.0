From: Gary Poppitz <poppitzg@iomega.com>
Subject: Secondary port on SiS 965
Date: Wed, 23 Feb 2005 09:03:59 -0700
Message-ID: <1fb03f81cef68f29c170efe64abc9d93@iomega.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Received: from email-mx2.iomega.com ([147.178.1.73]:6074 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261443AbVBWQBl
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Feb 2005 11:01:41 -0500
Received: from emailmx0.iomega.com (hubble [147.178.1.70])
	by email.iomega.com (Postfix) with ESMTP id 5533015F1
	for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2005 09:01:41 -0700 (MST)
Received: from royntex01.iomegacorp.com (unknown [147.178.90.120])
	by emailmx0.iomega.com (Postfix) with ESMTP id 4C6AF6D4
	for <linux-ide@vger.kernel.org>; Wed, 23 Feb 2005 16:01:41 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Has anyone also seen the problem of having a SATAPI device being 
detected on the secondary port of the SiS 965 chipset?

I am able to run correctly on the primary port but the secondary port 
says there is no physical device present. Both ports will run our 
device in Windows XP so this isnt a hardware problem.

Any clues/solutions for this one?

