From: Feng Kan <fkan@amcc.com>
Subject: [PATCH 0/2] Added support for Designware SATA controller driver
Date: Fri,  1 May 2009 14:06:24 -0700
Message-ID: <1241211984-321-1-git-send-email-fkan@amcc.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sdcmail01.amcc.com ([198.137.200.72]:34755 "EHLO
	sdcmail01.amcc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756042AbZEAVGr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 May 2009 17:06:47 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
Cc: sr@denx.de, Feng Kan <fkan@amcc.com>

Fixed comment issue. Change goto statements to lower case. Also
fixed the Kconfig problem.

I don't know if I need to add Stefan Roese for the signoff, since he
did the of platform part.
Stefan, if you see this please let me know.

Feng Kan
