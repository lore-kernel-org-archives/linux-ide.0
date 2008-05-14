From: =?ISO-8859-15?Q?Erik_Inge_Bols=F8?= <knan-ide@anduin.net>
Subject: Re: libata errors with smartctl on 2.6.24, WD3200AAKS and nVidia
 AHCI
Date: Wed, 14 May 2008 09:58:56 +0200 (CEST)
Message-ID: <alpine.BSF.1.00.0805140952250.34461@anduin.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anduin.net ([213.225.74.230]:55189 "EHLO anduin.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909AbYENIRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 May 2008 04:17:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tvrtko@ursulin.net, htejun@gmail.com, linux-ide@vger.kernel.org

The drive does say

        Enabled Supported:
                SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead

... so doesn't look like SMART is enabled on the drive.

Does the problem go away if you do a

smartctl -s on /dev/sda

first? :)

--
-erik	http://useofwords.blogspot.com/
