From: Mark Langsdorf <mark.langsdorf@calxeda.com>
Subject: [PATCH 0/2] ahci: custom reset for Calxeda ahci
Date: Fri, 17 Aug 2012 09:51:49 -0500
Message-ID: <1345215111-11051-1-git-send-email-mark.langsdorf@calxeda.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp161.dfw.emailsrvr.com ([67.192.241.161]:56619 "EHLO
	smtp161.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab2HQPBe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 11:01:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, probinson@gmail.com, jonathon@jonmasters.org, dmarlin@redhat.com

The phy interface on Calxeda's EnergyCore SoC does not always connect to
SATA drives correctly, especially when spread spectrum drives are used.
These patches provide a software work-around to the problem.

--Mark Langsdorf
Calxeda, Inc.

