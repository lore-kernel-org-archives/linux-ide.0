From: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: PATA drivers in libata?
Date: Sun, 13 Feb 2005 16:12:46 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0502131611360.16537-100000@coffee.psychology.mcmaster.ca>
References: <420FA1B9.6030100@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:46735 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261314AbVBMVND (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 13 Feb 2005 16:13:03 -0500
In-Reply-To: <420FA1B9.6030100@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

> * With ATA passthru (in libata-dev currently), libata supports SMART and 
> the HDIO_CMD/HDIO_TASK generalized ioctls.  Should I care about 
> supporting other ioctls?

is there some other mechanism to en/disable write caching?

