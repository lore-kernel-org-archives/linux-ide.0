From: =?ISO-8859-15?Q?Dieter_St=FCken?= <stueken@conterra.de>
Subject: register/unregister SATA drive
Date: Wed, 05 Apr 2006 17:20:24 +0200
Message-ID: <4433E038.3040607@conterra.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vvv.conterra.de ([212.124.44.162]:18394 "EHLO conterra.de")
	by vger.kernel.org with ESMTP id S1750835AbWDEPUd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Apr 2006 11:20:33 -0400
Received: from localhost (unknown [127.0.0.1])
	by conterra.de (-) with ESMTP id AE77B1F400F
	for <linux-ide@vger.kernel.org>; Wed,  5 Apr 2006 17:20:31 +0200 (CEST)
Received: from conterra.de ([127.0.0.1])
 by localhost (vvv.conterra.de [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23743-07 for <linux-ide@vger.kernel.org>;
 Wed,  5 Apr 2006 17:20:26 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

is it possible to unregister a single SATA port and to detach the disk?
how do I inform the kernel to rescan for a newly attached drive on that
port?

Dieter.
