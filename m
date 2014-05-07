From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] libata-sff: remove dead code
Date: Wed, 07 May 2014 10:49:56 +0100
Message-ID: <1399456196.2458.53.camel@acox1-desk.ger.corp.intel.com>
References: <1399204229.8729.15.camel@x220>
	 <1399411616.2458.45.camel@acox1-desk.ger.corp.intel.com>
	 <1399454604.6659.13.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6093 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755204AbaEGJuc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 May 2014 05:50:32 -0400
In-Reply-To: <1399454604.6659.13.camel@x220>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> > It was needed for some of the FRV devices I belive. Please check with
> > David Howells if it's still relevant
> 
> This code has been behind (effectively) an "#if 0" check for seven
> years. So either there was no problem to begin with, the problem is
> fixed somewhere else, or no one is actually using the affected devices.
> So I doubt this is still relevant. But maybe David thinks otherwise...
> 
> > (even if its not used in the default configs)
> 
> It's not used (and has never been used) regardless which config one
> tries.

Unless you are editing the config with out of tree changes. Which is
possible which is why I said ask Dave. It's probably fine but best to be
safe.

Alan


