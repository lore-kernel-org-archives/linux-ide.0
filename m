From: Andrew Schepler <aschepler@gmail.com>
Subject: Re: 2.6.28.7 boot problems
Date: Sat, 28 Feb 2009 20:57:57 -0500
Message-ID: <40f01080902281757y1fc9be7dq710caea916652b53@mail.gmail.com>
References: <40f01080902251346v5f73ed43nacc07bf65c98a727@mail.gmail.com>
	 <49A8AB75.9020006@gmail.com>
	 <40f01080902280827taf007cq613609fb42b9b24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:31535 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248AbZCAB6A (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 28 Feb 2009 20:58:00 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1224511ywh.1
        for <linux-ide@vger.kernel.org>; Sat, 28 Feb 2009 17:57:58 -0800 (PST)
In-Reply-To: <40f01080902280827taf007cq613609fb42b9b24@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

> Now I'm going to go try some e2fsck -cc /dev/hda3 and/or badblocks -n
> /dev/hda[12] to see if any disk problems turn up that way.

No bad blocks found.

On closer inspection of the dmesg, it looks like those CRC errors only
come up when the kernel is (attempting to?) set DMA modes, and never
again.  So I don't know if I'm actually using DMA or not, but I now
have a working, probably relatively safe, kernel.

-- Andrew
