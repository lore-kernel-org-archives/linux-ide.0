From: Andy Warner <andyw@pobox.com>
Subject: Re: [t13] RE: comment on T10 ATA-passthru
Date: Mon, 1 Nov 2004 20:12:41 -0600
Message-ID: <20041101201240.A16317@florence.linkmargin.com>
References: <A9B8FF43A76C0D42A80DDD73CF99BEC80548967B@azsmsx407> <20041029142539.A29944@florence.linkmargin.com> <20041029194311.GA27218@havoc.gtf.org> <20041029153953.B29944@florence.linkmargin.com> <20041029205033.GA32007@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:20401 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S313062AbUKBCO3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Nov 2004 21:14:29 -0500
Content-Disposition: inline
In-Reply-To: <20041029205033.GA32007@havoc.gtf.org>; from jgarzik@pobox.com on Fri, Oct 29, 2004 at 04:50:33PM -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andy Warner <andyw@pobox.com>, linville@redhat.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> [I ask about NCQ ...]
> Most of the code is already written to assume that queueing is
> active.  Turning on NCQ in libata is trivial.  Handling errors and
> synchronization is less trivial :)

I guess I'm a little gun shy here :) Remember, my induction to
hotplug consisted of:

	"That's because libata doesn't call the proper hot-unplug hooks.
	 Call those hooks, and the problem goes away."

I really don't want to hugely underestimate the effort involved.

Things that I can't quite see being in there right now
are the low-level state machine support for queued events,
and data structures and functions required to queue the pending
requests.

The boundary conditions you allude to seem likely to be
a pandora's box. Not the least of which will be ensuring
that queued and non-queued commands never mingle. It is
my understanding that any non-queued command will abort
*all* pending queued commands with unpredictable results
for data in flight.

What (if any) chip/board level driver work can be expected ?
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
