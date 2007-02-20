From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH 0/5] sata_nv: various cleanups and fixes
Date: Mon, 19 Feb 2007 19:00:56 -0600
Message-ID: <45DA4848.7090407@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25902 "EHLO
	pd3mo2so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932750AbXBTBEw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Feb 2007 20:04:52 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>

This patch series contains several fixes for issues I noticed while
debugging some command timeout problems. None of these proved to be
related to that issue, but they fall into the category of things
we should be doing anyway.

Split into separate patches to ease bisecting in case of issues.



