From: Jim Paris <jim@jtan.com>
Subject: Re: sata_nv + ADMA + Samsung disk problem
Date: Thu, 16 Aug 2007 14:45:06 -0400
Message-ID: <20070816184505.GA4453@jim.sh>
References: <20070808120804.GB5257@boogie.lpds.sztaki.hu> <46C17634.2040504@gmail.com> <20070816160629.GL8108@boogie.lpds.sztaki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from NEUROSIS.MIT.EDU ([18.95.3.133]:49953 "EHLO neurosis.jim.sh"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932727AbXHPSui (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 16 Aug 2007 14:50:38 -0400
Content-Disposition: inline
In-Reply-To: <20070816160629.GL8108@boogie.lpds.sztaki.hu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Gabor Gombas wrote:
> On Tue, Aug 14, 2007 at 06:30:28PM +0900, Tejun Heo wrote:
> > Hmmm... That's timeout on cache flush, indicative of failing disk.
> > Please post the result of 'smartctl -a /dev/sdc'.
> 
> Ok, so something is fishy in 2.6.22 wrt. SMART.

See http://lkml.org/lkml/2007/7/8/198

-jim
