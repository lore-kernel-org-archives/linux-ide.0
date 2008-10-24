From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [smartmontools-support] SMART to USB/sata dock in 2.6.27-rc5
 doesn't work
Date: Fri, 24 Oct 2008 20:54:47 +0200
Message-ID: <490219F7.7030908@free.fr>
References: <48EE7E0A.8040701@dgreaves.com> <48F40164.5000502@kernel.org> <48F641A3.5080609@free.fr> <4900A0A7.3090102@rtr.ca> <4900C949.6040604@free.fr> <4900DCE4.3020901@rtr.ca> <4900E051.9040608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp3-g19.free.fr ([212.27.42.29]:49207 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbYJXSyv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 24 Oct 2008 14:54:51 -0400
In-Reply-To: <4900E051.9040608@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, David Greaves <david@dgreaves.com>, linux-ide@vger.kernel.org, Smartmontools Mailing List <smartmontools-support@lists.sourceforge.net>, linux-kernel@vger.kernel.org

Mark Lord wrote:
> Mark Lord wrote:
> I guess it "works" by accident, since the 00 device status
> doesn't have the ATA error bit set.  But I suppose this also
> means that a failed ATA command would not be noticed either..
> At least not without the patch.
Yes that seem to case.
I wonder with the patch doesn't make smartctl work without permisive. 
May be your usb id wasn't in the patch.


Matthieu
