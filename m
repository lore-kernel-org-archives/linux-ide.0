From: Ocean HY1 He <hehy1@lenovo.com>
Subject: Re: [RFC] AHCI: Remove conflicting Intel Lewisburg 3rd-party SATA
 RAID device IDs
Date: Mon, 29 Feb 2016 09:28:19 +0000
Message-ID: <1456737781-13494-1-git-send-email-hehy1@lenovo.com>
References: <20160227112033.GX3965 () htj ! duckdns ! org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:8338 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752011AbcB2Jm1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Feb 2016 04:42:27 -0500
In-Reply-To: <20160227112033.GX3965 () htj ! duckdns ! org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ocean HY1 He <hehy1@lenovo.com>

Hi Tejun,

According to Intel Lewisburg PCH EDS, SATA RAID controller has two types
of DIDs: RSTe RAID and 3rd Party RAID. RSTe RAID shoud be drived by AHCI
driver and used to construct MDRAID. These 3rd Party RAID IDs are reserved
for other 3rd Party RAID drivers for variety.

So, I think it's a bug to let AHCI driver supporting 3rd Party RAID IDs.
And it should be ok to remove these existed device IDs.

Thanks,
Ocean.