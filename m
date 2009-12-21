From: Tejun Heo <tj@kernel.org>
Subject: Re: Rapidly increasing Load_Cycle_Count on Acer 2930z
Date: Mon, 21 Dec 2009 17:22:12 +0900
Message-ID: <4B2F3034.1030208@kernel.org>
References: <200912151956.02364.kailed@kailed.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47139 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZLUITH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Dec 2009 03:19:07 -0500
In-Reply-To: <200912151956.02364.kailed@kailed.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kailed@kailed.net
Cc: linux-ide@vger.kernel.org

On 12/16/2009 03:56 AM, Daniele wrote:
> Hi folks,
> on my acer2930z Load_Cycle_Count increase every 5 seconds when idle.
> 
> Setting APM_LEVEL to 200 (default 128) fix the issue, LCC doesn't not 
> increase anymore.

Can you please *attach* the outputs and also include the output of
dmidecode for later reference?

Thanks.

-- 
tejun
