From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [patch 2/2] libata: power off unused ports
Date: 28 Mar 2008 08:43:40 +0100
Message-ID: <87fxubl2dv.fsf@basil.nowhere.org>
References: <20080325221646.567639335@intel.com>
	<20080325152813.0b34761f@appleyard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out02.alice-dsl.net ([88.44.60.12]:18465 "EHLO
	smtp-out02.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYC1Hnp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 28 Mar 2008 03:43:45 -0400
In-Reply-To: <20080325152813.0b34761f@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, arjan@linux.intel.com

Kristen Carlson Accardi <kristen.c.accardi@intel.com> writes:

> If a port doesn't support hot plug, there's no reason to keep the phy powered
> on unoccupied ports.  

Would it be possible to add some writable sysfs attribute for this too?

A lot of ports support hot plug, but the users knows they will never actually
hot plug anything there. Exposing it to sysfs would make sense so 
someone could make a conscious decision to save these watts by sacrifying
hotplug-support.

-Andi
