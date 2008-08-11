From: Arjan van de Ven <arjan@infradead.org>
Subject: [patch 0/2] fastboot: allow skipping probing of known-unused ports
 in libata
Date: Mon, 11 Aug 2008 15:35:42 -0700
Message-ID: <20080811153542.61095e5c@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35791 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYHKWfe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Aug 2008 18:35:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org

Hi,

if you KNOW a certain ata port is not connected (for example in a
netbook where there's just nothing there possible), we still probe
the port currently and waste time. This time is a significant part of
the total boot time.

This patch series introduces a module parameter that can be used
to tell the kernel which ports to skip, and the second patch
adds a DMI list for known setups so that for known cases
users don't have to add any parameters at all.

