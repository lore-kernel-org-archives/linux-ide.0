From: Jeremy Jackson <jerj@coplanar.net>
Subject: SATA spec rev 2.6 feature NCQ priority support
Date: Fri, 02 May 2008 13:13:34 -0400
Message-ID: <1209748414.7296.51.camel@ragnarok>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from titan.coplanar.net ([70.47.139.2]:49159 "EHLO
	titan.coplanar.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935094AbYEBR1g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 13:27:36 -0400
Received: from [70.47.139.174] (ragnarok.coplanar.net [70.47.139.174] (may be forged))
	(authenticated bits=0)
	by titan.coplanar.net (8.14.1/8.14.1/Debian-8ubuntu1) with ESMTP id m42HDZjc017963
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 13:13:37 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

New feature allows high/low priority bit setting in SATA Read/Write
Queued w/ FPDMA commands.

Linux awareness, support plans?

Apparently Windows Vista can take advantage of this.

Would work great with io-scheduler.

-- 
Jeremy Jackson
Coplanar Networks
(519)489-4903
http://www.coplanar.net
jerj@coplanar.net

