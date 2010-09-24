From: Mark Lord <kernel@teksavvy.com>
Subject: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 01:34:48 -0400
Message-ID: <4C9C3878.9010206@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:57756 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751503Ab0IXFet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 01:34:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

I've been trying to understand numerous bug reports I've seen for hdparm
over the past couple of months.  I think they probably all boil down to
the new libahci code not returning a correct result_tf in response
to successful ATA_16/ATA_12 passthru commands.

It seems to return a stale result_tf much of the time.
perfectly reproduceable here on my Jmicron JMB360 PCIe SATA interface.

I am totally lost when looking at libahci code though.
Anyone got any ideas where the bug might be there??

Thanks
