From: Pat LaVarre <p.lavarre@ieee.org>
Subject: Re: SATAPI status
Date: 23 Jul 2004 11:14:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1090602844.4873.0.camel@patibmrh9>
References: <2429743E-DBFD-11D8-A213-00039398BB5E@ieee.org><1090601924.4850.
	6.camel@patibmrh9>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from email-out1.iomega.com ([147.178.1.82]:42458 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S267846AbUGWROR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jul 2004 13:14:17 -0400
Received: from royntex01.iomegacorp.com (edison [10.1.1.82])
	by email.iomega.com (Postfix) with ESMTP id 528CB22B4
	for <linux-ide@vger.kernel.org>; Fri, 23 Jul 2004 11:14:17 -0600 (MDT)
In-Reply-To: <1090601924.4850.6.camel@patibmrh9>
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Ahhh, trouble was,

Linux to SATAPI/ PATAPI bridge to PATAPI DVD choked over DVD ID jumper
set to 1. Change jumper to ID 0, and life is good again.

> Til I have an interesting
> question or patch to share,

Pat LaVarre
http://linux-pel.blog-city.com/read/742498.htm


