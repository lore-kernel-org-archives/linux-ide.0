From: Tejun Heo <tj@kernel.org>
Subject: Re: Some hints needed how to handle SATA ALPM failures
Date: Fri, 18 Feb 2011 15:50:57 +0100
Message-ID: <20110218145057.GM21209@htj.dyndns.org>
References: <4D5E6CE1.9020908@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36180 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab1BROvC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 18 Feb 2011 09:51:02 -0500
Content-Disposition: inline
In-Reply-To: <4D5E6CE1.9020908@canonical.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Andy Whitcroft <apw@canonical.com>

Hello,

On Fri, Feb 18, 2011 at 01:58:09PM +0100, Stefan Bader wrote:
> We are hoping that those working more closely with the SATA code might
> be aware of this issue.  As the symptoms are so severe (data corruption)
> we have ALPM disabled globally, but this does make it hard to get more
> targeted information on affected platforms.

What do you mean by data corruption?  File system ro remount or actual
fs corruption?  If actual fs corruption is happening, it's highly
likely that there's an underlying issue with the hardware.  If data
corruption can be reproduced, can you please run smartctl -a before
and after such failure and post the outputs?

As for ro remounts, I recall applying fixes for that months ago.  I
don't remember the details but some configurations raised extra PHY
event afterwards and command was failed without retry.  Anyways, it
got fixed.  Please dig through the log for details.

Also, the whole LPM thing got revamped several releases ago.  Can you
please test how the recent kernels behave?  There will be failures as
not all hardware can handle LPM well but those failures shouldn't lead
to any catastrophic failures like ro remounting of filesystem.

Thanks.

-- 
tejun
