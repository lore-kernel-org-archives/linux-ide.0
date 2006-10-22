From: Robert Wruck <wruck@tweerlei.de>
Subject: Re: [2.6.19-rc2] SATA boot problems
Date: Sun, 22 Oct 2006 17:55:32 +0200
Message-ID: <453B9474.5010909@tweerlei.de>
References: <4537697C.7080500@tweerlei.de> <4537DEFC.5050404@rtr.ca> <45388F24.6000407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tweerlei.de ([85.183.132.91]:65285 "EHLO mail.tweerlei.de")
	by vger.kernel.org with ESMTP id S1751075AbWJVPzl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Oct 2006 11:55:41 -0400
In-Reply-To: <45388F24.6000407@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, IDE/ATA development list <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org

> Can you give a shot at the latest -mm (2.6.19-rc2-mm2)?  It contains
> device-detection-via-polling which is supposed to fix problems similar
> to yours.

I tried 2.6.19-rc2-mm2 and was not able to reproduce the bug so far.
Seems to be fixed :-)

Thanks,
Robert
