From: viresh kumar <viresh.kumar@st.com>
Subject: Re: ata: hotplug not working with arasan CF controller driver
Date: Wed, 24 Nov 2010 11:14:35 +0530
Message-ID: <4CECA643.2010005@st.com>
References: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:47857 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750906Ab0KXFow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Nov 2010 00:44:52 -0500
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8209FF3
	for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2010 05:44:37 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 345DDE4B
	for <linux-ide@vger.kernel.org>; Wed, 24 Nov 2010 05:44:37 +0000 (GMT)
In-Reply-To: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Cc: Viresh KUMAR <viresh.kumar@st.com>

On 11/22/2010 04:24 PM, Viresh KUMAR wrote:
> I am writing arasan CF controller driver (pio mode). Hotplug is not working
> with my driver and i can't find the reason for this. What i am expecting is,
> inserting CF card on already booted machine should add /dev/sd* node for CF
> card and removing card should remove /dev/sd* node. If i insert card before
> booting my board and then start my board, things work fine. I am able to mount,
> read, write, unmount. But hotplug is not working.
> 
> I am working on linux-2.6.32.
> 
> Can somebody please help me on this??

Guys,

Any help on this??

-- 
viresh
