From: Tejun Heo <tj@kernel.org>
Subject: Re: Sparse warning in sata_nv.c
Date: Wed, 20 Jan 2010 12:15:35 +0900
Message-ID: <4B567557.1070607@kernel.org>
References: <20100106105416.4bdc225a@nehalam>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57687 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab0ATDJ3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Jan 2010 22:09:29 -0500
In-Reply-To: <20100106105416.4bdc225a@nehalam>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: linux-ide@vger.kernel.org

On 01/07/2010 03:54 AM, Stephen Hemminger wrote:
> Sparse complains about the following, not sure best way to fix it.
> Either change ATA_NCQ_SHT() or do manual expansion.

Hmm... that's an intended abuse of duplicate initializers.  The macro
provides stock values and each driver overrides fields as necessary
with duplicate initializers which come below the macro.  It would be
great if there's a way to tell sparse that an initializer may be
overridden.

Thanks.

-- 
tejun
