From: Andrew Morton <akpm@linux-foundation.org>
Subject: ata bustage with CONFIG_PM=n
Date: Wed, 18 Jul 2007 23:59:34 -0700
Message-ID: <20070718235934.a3545271.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59524 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753761AbXGSHAR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jul 2007 03:00:17 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

ahci_port_start() calls ahci_port_resume() which doesn't exist if !CONFIG_PM.
