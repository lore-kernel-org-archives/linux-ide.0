From: Matt Sealey <matt@genesi-usa.com>
Subject: Read Prefetch, Post Write on IDE chipsets
Date: Sun, 02 Sep 2007 13:51:43 +0100
Message-ID: <46DAB1DF.5050109@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mithrandir.softwarenexus.net ([66.98.186.96]:4942 "EHLO
	mail.genesi-usa.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965677AbXIBMuK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 08:50:10 -0400
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk ([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>)
	id 1IRocQ-0007ka-8O
	for linux-ide@vger.kernel.org; Sun, 02 Sep 2007 12:31:58 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi guys,

Does anyone have any decent information on the purpose, performance potential
or perhaps quirks of the "read prefetch" and "post write" buffer features on
some IDE chipsets?

It doesn't look like any standard but at least is included in quite a few
of the libata drivers, and a lot of x86 BIOS control has toggles to try and
turn it on or off.

But, what is it? I've never seen any documentation but which register to use
to toggle it.. no vendor recommendations to turn it on, it seems like a rather
secret feature..?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
