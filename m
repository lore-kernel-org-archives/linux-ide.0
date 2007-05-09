From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pci-quirks: disable MSI on RS400-200 and RS480, take
 #2
Date: Wed, 09 May 2007 15:23:54 -0400
Message-ID: <46421FCA.7010807@garzik.org>
References: <4641BD26.1020501@gmail.com> <4641EAA5.4030409@redhat.com> <4641EDDC.1020102@gmail.com> <4641EF46.2090506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:46573 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbXEITYA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 9 May 2007 15:24:00 -0400
In-Reply-To: <4641EF46.2090506@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Tejun Heo <htejun@gmail.com>, Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>

Chuck Ebbert wrote:
> Tejun Heo wrote:
>>> FWIW several distros have turned off MSI by default and added
>>> a "pci=msi" option to enable it.
>> Yeah, it seem to cause a lot of problems on certain chips but I think
>> the correct path is to add PCI quirks for those.  Most MSI problems I've
>> seen are on these ATI chips.  Do you happen to know any other?
> 
> We had devices that didn't do MSI right, e.g. forcedeth and others I
> can't recall now.

AFAIK that's a broken diagnosis.   It's the system, not the device, that 
is problematic.

	Jeff



