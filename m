From: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: [PATCH #upstream-fixes] pata_mpc52xx: inherit from ata_bmdma_port_ops
Date: Mon, 10 Jan 2011 08:26:34 +0100
Message-ID: <201101100826.34728.roman.fietze@telemotive.de>
References: <201101031445.47922.roman.fietze@telemotive.de> <4D21FA4D.3030506@mvista.com> <20110109224820.GB26607@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from coyote.quickmin.net ([217.14.112.24]:52268 "EHLO
	coyote.quickmin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066Ab1AJH0k (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Jan 2011 02:26:40 -0500
In-Reply-To: <20110109224820.GB26607@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

Hello Tejun,

On Sunday, 09.January.2011 23:48:20 Tejun Heo wrote:

> Fix it.

I can confirm that, it's fixed.

Thank's a lot. Should have looked into it, that was really a simple
fix.


Roman

-- 
Roman Fietze              Telemotive AG Buero Muehlhausen
Breitwiesen                             73347 Muehlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
