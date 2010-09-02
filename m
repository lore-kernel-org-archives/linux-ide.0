From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] libata: skip EH autopsy and recovery during suspend
Date: Thu, 2 Sep 2010 22:16:45 +0200
Message-ID: <201009022216.45303.rjw@sisk.pl>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7F6931.4050707@gmail.com> <4C7F7649.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43718 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756549Ab0IBURk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Sep 2010 16:17:40 -0400
In-Reply-To: <4C7F7649.3010409@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>

On Thursday, September 02, 2010, Tejun Heo wrote:
> For some mysterious reason, certain hardware reacts badly to usual EH
> actions while the system is going for suspend.  As the devices won't
> be needed until the system is resumed, ask EH to skip usual autopsy
> and recovery and proceed directly to suspend.

Putting the issue at hand aside, I'm not really sure if using SCSI EH for
suspending the controller is a good idea.  It seems overly complicated and
it doesn't match the new PCI suspend model with separate ->suspend(),
->freeze() and ->poweroff() callbacks.  Moreover, the passing of pm_message_t
back and forth doesn't make things clear either.

Would it be possible to rework this thing entirely at one point?

Rafael
