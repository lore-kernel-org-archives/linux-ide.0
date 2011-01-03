From: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: PowerPC MPC5200B ATA MWDMA regression
Date: Mon, 3 Jan 2011 15:34:13 +0100
Message-ID: <201101031534.13533.roman.fietze@telemotive.de>
References: <201101031445.47922.roman.fietze@telemotive.de> <20110103135929.GO18831@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coyote.quickmin.net ([217.14.112.24]:50105 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754911Ab1ACOeR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Jan 2011 09:34:17 -0500
In-Reply-To: <20110103135929.GO18831@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hallo Tejun,

On Monday, 03.January.2011 14:59:29 Tejun Heo wrote:

> Which driver is it?

drivers/ata/pata_mpc52xx.c from the standard tree, 100% unchanged. As
I said, for the bisect I was using the original, unchanged
torvalds/master tree from git.kernel.org.

> You probably now want to use ata_bmdma_qc_issue() ...

I'm sorry, but if I would know about the details, and would know more
about ATA I would have tried to patch pata_mpc52xx.c by myself.

>  Even better, just send the driver upstream.

It has been there for a long while. You even patched it last summer.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
