From: Joseph Harvell <jharvell@dogpad.net>
Subject: Re: corruption problem with 2.6.10 patch for Promise SATAII TX4
Date: Fri, 11 Mar 2005 08:04:27 -0600
Message-ID: <4231A56B.6040100@dogpad.net>
References: <422DBD7F.9030500@dogpad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from dingo.dogpad.net ([65.70.180.33]:42112 "EHLO dingo.dogpad.net")
	by vger.kernel.org with ESMTP id S263312AbVCKOEn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Mar 2005 09:04:43 -0500
In-Reply-To: <422DBD7F.9030500@dogpad.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joseph Harvell <jharvell@dogpad.net>
Cc: linux-ide@vger.kernel.org

Jeff:

Is your contribution to 2.6.11 based on Georg's patch?  If so, I think 
there needs to be a warning in the promise_sata kernel config help at 
the very least.

Have you considered porting the Promise driver to 2.6?  I have been 
using that driver with 2.4.28 with no problems.  Plus, it looks like 
they have support for native command queueing in the driver.  However, I 
noticed what appears to be a significant amount of work being done in 
the interrupt handler.

---
Joe Harvell
