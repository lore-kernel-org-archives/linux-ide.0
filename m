From: "Slawek" <slawek@computer-design.co.uk>
Subject: LEDs on Silicon Image SATA
Date: Wed, 17 Nov 2004 18:31:03 -0000
Message-ID: <01e601c4ccd3$991e92e0$4500a8c0@MarkK>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server6.tcw.telecomplete.net ([213.160.116.7]:57361 "EHLO
	server6.tcw.telecomplete.net") by vger.kernel.org with ESMTP
	id S262477AbUKQSdD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2004 13:33:03 -0500
Received: from host13.cdg.adsl.telecomplete.net ([213.160.101.94] helo=Chris.Domain)
	by server6.tcw.telecomplete.net with esmtp (Exim 4.34)
	id 1CUUc1-0000vL-2y
	for linux-ide@vger.kernel.org; Wed, 17 Nov 2004 18:33:01 +0000
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi.

Does anybody have the activity LEDs working via SI3122A's?

I am aware that SATA does not have a pin defined for activity, however
this is dealt with on the SI chips (and I presume other SATA chips)..
the driver I think configures the SI to use a port as activity and the
system board has a connector.

The SI driver for windows works fine and the activity blinks all day
long. but on linux I can not get the leds to function.


Is this being looked at by anybody?


Thank you



Slawek


