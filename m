From: Tejun Heo <tj@kernel.org>
Subject: Re: ata: hotplug not working with arasan CF controller driver
Date: Fri, 26 Nov 2010 18:25:38 +0100
Message-ID: <4CEFED92.7050701@kernel.org>
References: <ede5127fb76113dd7560fa8919c0e125b38985a2.1290422728.git.viresh.kumar@st.com> <4CECA643.2010005@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43400 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab0KZRZn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Nov 2010 12:25:43 -0500
In-Reply-To: <4CECA643.2010005@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: viresh kumar <viresh.kumar@st.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 11/24/2010 06:44 AM, viresh kumar wrote:
> On 11/22/2010 04:24 PM, Viresh KUMAR wrote:
>> I am writing arasan CF controller driver (pio mode). Hotplug is not working
>> with my driver and i can't find the reason for this. What i am expecting is,
>> inserting CF card on already booted machine should add /dev/sd* node for CF
>> card and removing card should remove /dev/sd* node. If i insert card before
>> booting my board and then start my board, things work fine. I am able to mount,
>> read, write, unmount. But hotplug is not working.
>>
>> I am working on linux-2.6.32.
>>
>> Can somebody please help me on this??
> 
> Guys,
> 
> Any help on this??

You gotta tell EH that the device needs rescanning.  When you detect a
hotplug event, call ata_ehi_hotplugged() followed by
ata_port_freeze().

-- 
tejun


