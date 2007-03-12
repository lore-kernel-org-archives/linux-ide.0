From: Phil Kaslo <phil@cs.arizona.edu>
Subject: Re: Asus P5B-VM motherboard:  cd drive malfunctions if internal nic in use.
Date: Mon, 12 Mar 2007 16:48:47 -0700
Message-ID: <200703122348.l2CNmlAg001085@osprey.cs.arizona.edu>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cheltenham.cs.arizona.edu ([192.12.69.60]:3878 "EHLO
	cheltenham.cs.arizona.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbXCLXsu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 19:48:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml@rtr.ca
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

It is a pata cd drive, attached to the JMicron controller.

I'll look into whether the usb ports power off on shutdown.

Thanks,

Phil
