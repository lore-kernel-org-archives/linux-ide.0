From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: Problems with ide-cs.c
Date: Mon, 13 Dec 2004 20:57:20 -0000
Message-ID: <046201c4e156$5862e610$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tim.rpsys.net ([194.106.48.114]:27309 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261195AbULMU5P convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Dec 2004 15:57:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iBDKvEYN029970
	for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2004 20:57:14 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 29926-01 for <linux-ide@vger.kernel.org>;
 Mon, 13 Dec 2004 20:57:14 +0000 (GMT)
Received: from max (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iBDKv9F1029959
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-ide@vger.kernel.org>; Mon, 13 Dec 2004 20:57:09 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've run into an issue when working on pcmcia support for a device with a CF socket. 

With CF you can remove the card without ejecting it first. Removal results in a call to ide_release() in ide-cs.c which in turn calls ide_unregister. This all looks quite sensible.

If the usage count for the device is non-zero ide_unregister will fail which is likely if you just pull the card out. This silent failure leads to all kinds of problems which break the device until it's rebooted - quite a serious bug. There is a fixme in ide-cs.c relating to this.

There are several issues on different levels here.  If ide_unregister can fail, it should really return a value. Two solutions: Either make it so ide_unregister can't fail or return a failure value.

That latter seems quite simple but if a failure value is returned, there is not a lot ide-cs.c can do other than retry the ide_unregister call periodically until it succeeds. As the hardware has gone, it should really be possible to point this out the ide system and have it act accordingly. The user shouldn't really have to see any timeouts/kernel whinging etc. as it is know the device is gone.

If ide_unregister marked the hwif "gone" and fails any and all new requests passed to IDE drives associated with the hwif immediately, that would solve some of the problems.

Unfortunately, I don't know a lot about the ide system. I'm open to suggestions as to how this bug can be resolved though.

Thanks,

Richard

