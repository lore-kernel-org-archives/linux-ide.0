From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Wed, 02 Dec 2009 10:55:28 +0900
Message-ID: <4B15C910.3030700@kernel.org>
References: <20091202003630.29919100851@ozlabs.org>	 <4B15BDCF.5020000@kernel.org> <1259718678.2076.1057.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:32897 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbZLBBzP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 20:55:15 -0500
In-Reply-To: <1259718678.2076.1057.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org

Hello,

On 12/02/2009 10:51 AM, Benjamin Herrenschmidt wrote:
> I'm not sure what media bay locking problem you mentioned tho...
> 
> The way the driver does the locking now is that I block the media-bay
> thread (lock/unlock_media_bay calls) around initial registration and
> driver removal which blocks the callback event. At any other time, the
> callback event will just schedule EH so things should be fine.
> 
> I've left the debouncing in the mediabay code as well for both insertion
> and removal so there should be no issue here with glitches.

Ah... okay, I was misunderstanding where the race was.  If there's no
race condition against hotplug/unplug events with non-probing EH, no
problem.

-- 
tejun
