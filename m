From: viresh kumar <viresh.kumar@st.com>
Subject: Re: ata: hotplug not working with arasan CF controller driver
Date: Mon, 29 Nov 2010 09:18:05 +0530
Message-ID: <4CF32275.6070901@st.com>
References: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com> <4CECA643.2010005@st.com> <4CEFED92.7050701@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:51154 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754524Ab0K2Dsg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Nov 2010 22:48:36 -0500
In-Reply-To: <4CEFED92.7050701@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11/26/2010 10:55 PM, Tejun Heo wrote:
> You gotta tell EH that the device needs rescanning.  When you detect a
> hotplug event, call ata_ehi_hotplugged() followed by
> ata_port_freeze().
> 

Thanks Tejun.

I will try this today.

-- 
viresh
