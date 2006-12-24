From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: hda on Via Epia-ML motherboard seen on 2.6.18, but not 2.6.19
Date: Mon, 25 Dec 2006 05:36:56 +0800
Message-ID: <200612242136.kBOLau9p010748@freya.yggdrasil.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [61.49.148.102] ([61.49.148.102]:45360 "EHLO
	freya.yggdrasil.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752902AbWLXVqI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Dec 2006 16:46:08 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Fri, 22 Dec 2006, i wrote:

>	I have a 666MHz Via Epia-ML motherboard (using a Via Eden, I
>think).  I am booting it from a CompactFlash card attached by an
>IDE-CF adapter.  Everything works fine under 2.6.18.  Under 2.6.19,
>2.6.19.1 and 2.6.20-rc1, the master device on ide0 is not seen.
[...]

	Not to nag, as there is more I can do to better diagnose the
problem, but just to pass along a new data point, the problem is still
present in 2.6.20-rc2.

Adam Richter
