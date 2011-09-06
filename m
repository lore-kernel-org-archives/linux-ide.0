From: Bruce Stenning <b.stenning@indigovision.com>
Subject: RE: sata_mv port lockup on hotplug (kernel 2.6.38.2)
Date: Tue, 6 Sep 2011 16:22:23 +0100
Message-ID: <C1438B59050E1B4C9482FF3266AD6BA32D8DA54B96@gretna.indigovision.com>
References: <20110525094127.GF10146@htj.dyndns.org>
 <4DF20E03.9030502@teksavvy.com> <20110610140155.GJ15235@htj.dyndns.org>
 <4DF25526.9010800@teksavvy.com> <20110611121957.GA7980@mtj.dyndns.org>
 <4DF4F30B.70702@teksavvy.com> <20110613104856.GC16021@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32D8D984D03@gretna.indigovision.com>
 <20110902011305.GE2752@htj.dyndns.org>
 <C1438B59050E1B4C9482FF3266AD6BA32D8D9854F7@gretna.indigovision.com>
 <20110906034544.GB18425@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gretna.indigovision.com ([62.7.85.227]:49871 "EHLO
	gretna.indigovision.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1IFPW0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 11:22:26 -0400
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>

> Is there some mechanism that I've missed to prevent this from happening?

Okay, no, I guess the thread will naturally be rescheduled at some point,
at which point the shost->host_eh_scheduled will be re-inspected.


Latest News at: http://www.indigovision.com/index.php/en/news.html
