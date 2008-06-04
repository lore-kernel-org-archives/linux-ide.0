From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC] expand link_power_management_policy definition
Date: Tue, 03 Jun 2008 20:52:49 -0400
Message-ID: <4845E761.2090604@garzik.org>
References: <20080603172307.1b963aac@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54918 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYFDAwv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Jun 2008 20:52:51 -0400
In-Reply-To: <20080603172307.1b963aac@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Kristen Carlson Accardi wrote:
> I think I mentioned on the list a couple weeks ago that I favor just 
> expanding the definition of link power management to include
> the notion of simply powering the entire port off rather
> than adding new knobs to sysfs.  I wrote this completely untested and
> very incomplete patch to give you a better idea of what I am proposing.
> This patch adds a new valid value of "power_off" for the existing
> link_power_management_policy sysfs entry:

Looks fine to me...  that would work nicely.

I think your patch is missing code to handle the transition from 
power_off to <something else>, though, right?

I'm quite happy with this approach.

	Jeff



