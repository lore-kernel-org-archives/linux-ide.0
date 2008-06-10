From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC] expand link_power_management_policy definition
Date: Tue, 10 Jun 2008 11:51:24 +0900
Message-ID: <484DEC2C.2090207@gmail.com>
References: <20080603172307.1b963aac@appleyard> <4845E761.2090604@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:26604 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbYFJCvc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 9 Jun 2008 22:51:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2383690wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 09 Jun 2008 19:51:32 -0700 (PDT)
In-Reply-To: <4845E761.2090604@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Kristen Carlson Accardi wrote:
>> I think I mentioned on the list a couple weeks ago that I favor just
>> expanding the definition of link power management to include
>> the notion of simply powering the entire port off rather
>> than adding new knobs to sysfs.  I wrote this completely untested and
>> very incomplete patch to give you a better idea of what I am proposing.
>> This patch adds a new valid value of "power_off" for the existing
>> link_power_management_policy sysfs entry:
> 
> Looks fine to me...  that would work nicely.
> 
> I think your patch is missing code to handle the transition from
> power_off to <something else>, though, right?
> 
> I'm quite happy with this approach.

I agree this is the right place to implement the control.

Thanks.

-- 
tejun
