From: Mark Lord <liml@rtr.ca>
Subject: hdparm-9.3 now available:  --idle-immediate & --idle-unload flags
Date: Tue, 04 Nov 2008 13:05:45 -0500
Message-ID: <49108EF9.1030902@rtr.ca>
References: <490F4030.5030709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:40323 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbYKDSFG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 13:05:06 -0500
Received: from [10.0.0.6] (corey.localnet [10.0.0.6])
	by mail.rtr.ca (Postfix) with ESMTP id 5F7BAE3E05A
	for <linux-ide@vger.kernel.org>; Tue,  4 Nov 2008 13:05:46 -0500 (EST)
In-Reply-To: <490F4030.5030709@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>

hdparm v9.3 is now available from sourceforge. 

    http://sourceforge.net/projects/hdparm/ 

New since v9.2 are:

   --idle-immediate flag, to issue ATA IDLE_IMMEDIATE power-saving command
   --idle-unload flag, to issue ATA IDLE_IMMEDIATE with head unload/park.

Cheers
