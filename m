From: Marguerite Su <i@marguerite.su>
Subject: Can I add SAMSUNG HN-M101MBB to wiki for heavy head unloads?
Date: Sat, 10 Aug 2013 09:56:29 +0800
Message-ID: <CAK0PdAm=Sy6QhhWgu4FDTQG6nALBgdsmp-zbc+SkC++-fZxCYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:52250 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031691Ab3HJB4v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Aug 2013 21:56:51 -0400
Received: by mail-we0-f182.google.com with SMTP id u55so4116107wes.13
        for <linux-ide@vger.kernel.org>; Fri, 09 Aug 2013 18:56:49 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, list,

Recently an openSUSE user post on our local forum claiming load cycle
count issues. So I show him mine and our ATA wiki to prove the idea
that if your harddisk lifespan is still longer than 2 years then
you're away from this kinda issue.

But after some days, I have a look at my LCC again, I think I may have
the issue instead of him:

My LCC was 674085 at July.24, now it is 686664 (Aug.10).

It increased about 12000 in half a month (more than 1 per minute)

My APM value was "off" which might be 255 I think. And I didn't touch
anything unless openSUSE did something (like: detect I'm using
Thinkpad then set it 255 according to our ATA wiki, but I've replaced
my harddisk to SAMSUNG HN-M101MBB, so turns into an awkward situation)

So I change it to 254 and monitor it using this script:

#!/bin/sh
while true;
        do smartctl -a /dev/sda | grep Load ;
        sleep 60;
done

for 2 hours. LCC didn't bump up. Problem is fixed.

So I thought SAMSUNG HN-M101MBB is a protential target for our wiki,
how can I confirm this?

BTW: Can I just post demicode/smartctl/hdparm outputs in plaintext in
mail? Or post it somewhere?

Greetings

Marguerite
