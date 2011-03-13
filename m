From: Tejun Heo <tj@kernel.org>
Subject: Re: sata problem...
Date: Sun, 13 Mar 2011 09:42:36 +0100
Message-ID: <20110313084236.GH2005@htj.dyndns.org>
References: <04BB68BD-352B-45B0-A7FC-42B6005A80B3@freemail.hu>
 <20110227153338.GA23527@mtj.dyndns.org>
 <E0ABD6B5-3B05-48D8-AFDC-9FD559AF2583@freemail.hu>
 <4D7C27AB.1010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60639 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1CMIml (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 13 Mar 2011 04:42:41 -0400
Received: by fxm17 with SMTP id 17so2104361fxm.19
        for <linux-ide@vger.kernel.org>; Sun, 13 Mar 2011 00:42:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D7C27AB.1010908@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Peter <elekesp@freemail.hu>, linux-ide@vger.kernel.org

On Sat, Mar 12, 2011 at 08:10:51PM -0600, Robert Hancock wrote:
> >I dont know why there is "[    2.098493] ata4.00: failed command: READ FPDMA QUEUED" in dmesg.
> >
> >I have 3 WD Green 1TB HDD, and I samsung 160GB HDD.
> >1 SAMSUNG and 1 WD on the intel SATA,
> >2 WD on the GIGABYTE Sata.
> >I think the problem is only with the gigabye sata port.
> 
> That's an uncorrectable read error the drive is reporting. Most
> likely that hard drive is failing.

Or maybe just a bad sector, in which case just writing it over would
cause the drive to reallocate the failed region.  I think this
partial/transient failure mode is much more common than the whole
drive going south.

Thanks.

-- 
tejun
