From: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: regarding your patch "AHCI: Support multiple MSIs"
Date: Wed, 10 Apr 2013 18:32:51 +0200
Message-ID: <20130410163250.GB2137@dhcp-26-207.brq.redhat.com>
References: <51659BDA02000078000CC288@nat28.tlf.novell.com>
 <20130410154202.GA2137@dhcp-26-207.brq.redhat.com>
 <5165A67802000078000CC2DD@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21215 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765342Ab3DJQ17 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Apr 2013 12:27:59 -0400
Content-Disposition: inline
In-Reply-To: <5165A67802000078000CC2DD@nat28.tlf.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-ide@vger.kernel.org

On Wed, Apr 10, 2013 at 04:50:48PM +0100, Jan Beulich wrote:
> They have separate lines, but all say just "ahci" at the end (as
> opposed to e.g. all the USB consumed ones, which are nicely
> distinguishable).

That is seems possible. Will have to check side effects though.

If *-ahci in case of single interrupt and *-ahciN where N is port #
works for you?

> Jan
> 

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
