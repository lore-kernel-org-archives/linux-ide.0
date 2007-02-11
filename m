From: Philip Langdale <philipl@overt.org>
Subject: Status of Hotplug polling patches?
Date: Sat, 10 Feb 2007 18:29:33 -0800
Message-ID: <45CE7F8D.60507@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from usul.saidi.cx ([204.11.33.34]:35917 "EHLO usul.overt.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752627AbXBKCfQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 21:35:16 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Hi TeJun,

I have a machine that I've been using 2.6.19 and your hotplug
polling patches on with great success and I just upgraded it
to 2.6.20 and it appears that getting those patches working
again will be non-trivial. As far as I can see, these patches
are not in Jeff's tree or even yours. Have they been discarded,
or am I looking in the wrong place? I certainly don't see
equivalent functionality in the current kernel.

The warmplug sysfs-foo isn't particularly inconvenient as I
need to explicitly unmount filesystems anyway, but it would
be nice to see hotplug working again.

(The machine is using an nvidia mcp55)

Thanks,

--phil
