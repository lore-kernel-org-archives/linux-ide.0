From: Mourad De Clerck <mourad@aquazul.com>
Subject: Re: Marvell 6121 AHCI: hotplug not reliable?
Date: Fri, 14 Aug 2009 23:01:22 +0200
Message-ID: <4A85D0A2.5050400@aquazul.com>
References: <4A8406EE.1040203@aquazul.com> <4A8412D1.2070506@garzik.org> <4A8417E0.2010802@aquazul.com> <4A852EBC.7070309@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretel.risen.be ([78.46.99.137]:51633 "EHLO gretel.risen.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbZHNVBe (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Aug 2009 17:01:34 -0400
In-Reply-To: <4A852EBC.7070309@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On 14/08/09 11:30, Tejun Heo wrote:
> Link status doesn't have much to do with drive spin up.  It looks like
> the PHY on the host side just went out for lunch and only controller
> wide reset brings it back.  Can you please try the followings after
> the failure occurred?

I'll try this, but it might take me a while before I report back: I get
this problem only once every two weeks or so (It's hotplugged daily)

> 1. echo - - - > /sys/class/scsi_host/hostN/scan

OK

> 2. unplug and replug the signal while leaving the drive powered up

I'm assuming you mean leave the power plugged in, but yank and replug
the SATA cable? Might be a bit tricky considering I'd need to open it up
(the tray combines power and SATA), and it's in a remote location.

Thank you for your suggestions, I'll report back on the next failure.

-- Mourad
