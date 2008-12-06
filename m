From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: MCP55 disk activity LEDs don't flash
Date: Sat, 06 Dec 2008 14:28:11 -0600
Message-ID: <493AE05B.2010707@shaw.ca>
References: <493A8767.5030200@seiner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43070 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752696AbYLFU2Z (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 6 Dec 2008 15:28:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L93lG-0006FV-1E
	for linux-ide@vger.kernel.org; Sat, 06 Dec 2008 20:28:22 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 20:28:22 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sat, 06 Dec 2008 20:28:22 +0000
In-Reply-To: <493A8767.5030200@seiner.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Yan Seiner wrote:
> I have a 6 slot server case with a backplane.  AFAICT the backplane is 
> passive and there are SATA cables that lead from the backplane to the mobo.
> 
> The problem is that the disk activity LEDs for the slots don't flash at 
> all.  The mobo is an ASUS M2N SLI Deluxe, which has the MCP55 controller.
> 
> The drive activity LED which plugs into the mobo works just fine; the 
> individual LEDs for each of the drives don't flash - they just stay on.  
> Is there something I can enable to make them work?  Or is the backplane 
> broken?

The backplane may be expecting the host to control the LEDs. You'd have 
to check with the manufacturer to be sure. As for how it would do this, 
there's such a thing as enclosure management support in SATA, but the 
sata_nv driver doesn't support it. If there is a way to use it on that 
controller, only NVidia would know, since they've provided no 
documentation for their pre-AHCI controllers. Some AHCI controllers do 
have support for this..

