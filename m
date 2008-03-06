From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Unknown SATA PIIX PCI device ID 0x29b6
Date: Thu, 06 Mar 2008 13:05:38 -0500
Message-ID: <47D03272.9080209@garzik.org>
References: <Pine.LNX.4.64.0802282306190.10087@axis700.grange> <20080228225603.2764bfd1@core> <Pine.LNX.4.64.0802290010320.10498@axis700.grange> <47CFADDF.20200@gmail.com> <Pine.LNX.4.64.0803061248070.5670@axis700.grange> <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:34344 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753763AbYCFSFn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 6 Mar 2008 13:05:43 -0500
In-Reply-To: <39B20DF628532344BC7A2692CB6AEE0702679018@orsmsx420.amr.corp.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Gaston, Jason D wrote:
> If you disable the IDE Redirection in BIOS on that system, the 0x29b6
> controller should not appear.  If you are not using this, it would be
> interesting to see if this effects what you are seeing.


I think its fair to say that a certain amount of Linux users will 
inevitably have this option enabled in their BIOS.  We should have a 
plan to deal with this sanely...?

	Jeff


