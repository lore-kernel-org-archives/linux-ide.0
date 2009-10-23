From: Jan Ceuleers <jan.ceuleers@computer.org>
Subject: pata sc1200 fix crash boot, bug #14227
Date: Fri, 23 Oct 2009 20:14:51 +0200
Message-ID: <4AE1F29B.1090009@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailrelay002.isp.belgacom.be ([195.238.6.175]:58997 "EHLO
	mailrelay002.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559AbZJWSPK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Oct 2009 14:15:10 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg KH <greg@kroah.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

A little while ago [1], a fix was posted here for a boot-time crash in the sc1200 module.

[1]: http://marc.info/?l=linux-kernel&m=125484259025909&w=2

Submission to stable was also briefly discussed, but has apparently not happened, despite the fact that this bug appears to have existed since 2.6.29.

I would therefore like to request that this fix now be submitted to stable.

Thank you.

Jan
