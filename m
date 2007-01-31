From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH RFC] sd: spin down disks on removal or power-down
Date: Wed, 31 Jan 2007 21:21:15 +0100
Message-ID: <45C0FA3B.5030508@s5r6.in-berlin.de>
References: <45BD522F.3070706@shaw.ca> <20070129154706.dfb3edab.akpm@osdl.org> <1170116201.3378.29.camel@mulgrave.il.steeleye.com> <45BE9252.3040108@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:51998 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161025AbXAaUVn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Jan 2007 15:21:43 -0500
In-Reply-To: <45BE9252.3040108@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, htejun@gmail.com

Robert Hancock wrote:
>> http://marc.theaimsgroup.com/?t=116922621200002
> 
> It looks like Tejun's patch essentially does the same thing as mine with
> the addition of the control from userspace. There is one exception
> though, my patch also does the stop on removal of the SCSI disk (i.e.
> writing 1 to its "delete" file in sysfs, what scsiadd -r does).

Isn't sd_shutdown called at this occasion?
-- 
Stefan Richter
-=====-=-=== ---= =====
http://arcgraph.de/sr/
