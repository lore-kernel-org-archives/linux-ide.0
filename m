From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: libata timeouts when stressing a Samsung HDD
Date: Wed, 11 Feb 2009 15:29:08 -0500
Message-ID: <20090211152908.383744cd@dhcp-100-2-144.bos.redhat.com>
References: <20090202164053.4ecca9dd@dhcp-100-2-144.bos.redhat.com>
	<49922A2D.508@kernel.org>
	<49924F48.4000009@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:53297 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbZBKUbm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 11 Feb 2009 15:31:42 -0500
In-Reply-To: <49924F48.4000009@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

On Tue, 10 Feb 2009 23:08:40 -0500
Mark Lord <liml@rtr.ca> wrote:

> 
> If I let hddtemp or smartctl run periodically during heavy writes,
> one (or both?) of the drives would eventually have issues and require
> a reset.  Problem was never resolved (I simply got rid of the periodic
> hddtemp and smartctl invocations instead).
> 

smartd is disabled and I don't even have hddtemp installed, so I don't
think they could be causing this.
