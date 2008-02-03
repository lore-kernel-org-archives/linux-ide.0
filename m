From: Tuomas Jormola <tj@solitudo.net>
Subject: Re: PROBLEM: SATA hotplugging not working with nForce MCP61
Date: Sun, 3 Feb 2008 19:46:55 +0200
Message-ID: <20080203174655.GA19915@solitudo.net>
References: <20080128074336.GB2736@solitudo.net> <47A3FFB4.2010509@gmail.com> <20080202173723.GA26461@solitudo.net> <47A4F956.6030005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.solitudo.net ([213.157.84.60]:35642 "EHLO
	mail.solitudo.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbYBCRrA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 3 Feb 2008 12:47:00 -0500
Content-Disposition: inline
In-Reply-To: <47A4F956.6030005@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

On Sun, Feb 03, 2008 at 08:14:30AM +0900, Tejun Heo wrote:
> Tuomas Jormola wrote:
> > 00:08.0 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
> > 00:08.1 IDE interface [0101]: nVidia Corporation MCP61 SATA Controller [10de:03f6] (rev a2)
> 
> That's MCP61 which is GENERIC variant in sata_nv which does not support
> hotplugging.  Robert, is this hardware restriction or do we just need
> more info?
Ok, so I guess it's not a bug per se. By reading [1] I was under
impression that all the chips supported by sata_nv driver would also
support hotplugging.

[1] http://linux-ata.org/driver-status.html#nvidia

-- 
Tuomas Jormola <tj@solitudo.net>
