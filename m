From: Tejun Heo <tj@kernel.org>
Subject: Re: Drives which perform frequent head unloads under Linux
Date: Mon, 29 Sep 2008 16:24:24 +0900
Message-ID: <48E082A8.7040909@kernel.org>
References: <d212b62f0809062304p639731c9k2e0f36bfb3e619d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34828 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152AbYI2H0H (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 03:26:07 -0400
In-Reply-To: <d212b62f0809062304p639731c9k2e0f36bfb3e619d7@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Omar A <aliencoder@gmail.com>
Cc: linux-ide@vger.kernel.org

Omar A wrote:
> Please note that I changed the settings manually using hdparam -B 254
> and -S 0, but I was looking for a more permanent fix.  Will try to
> edit the config file as well
> Output below..

Under idle usage, how much does load_cycle_count increase per hour?

Thanks.

-- 
tejun
