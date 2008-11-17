From: Tejun Heo <tj@kernel.org>
Subject: Re: FYI: BUG in SATA Promise 300 TX4 (2.6.24 - 2.6.27-3) w/Linux
Date: Mon, 17 Nov 2008 11:01:55 +0900
Message-ID: <4920D093.2030508@kernel.org>
References: <491C9A4F.1020801@tlinx.org>	<491FB7E2.2030105@kernel.org> <18719.65298.689618.835202@harpo.it.uu.se> <492059B1.4030708@how.dk> <49205AD7.3080009@how.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48091 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbYKQCCH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 21:02:07 -0500
In-Reply-To: <49205AD7.3080009@how.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Favrholdt <linux-ide@how.dk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-ide@vger.kernel.org

Peter Favrholdt wrote:
> Replying to my own post:
> 
> It was 2.6.27.6 not 2.6.27.5!
> 
> Peter Favrholdt wrote:
>> Having read about the hardreset fix I have just tried 2.6.27.5 on my
>> setup (which works ok at 1.5Gbps but fails at 3.0Gbps).

Does unloading and reloading sata_promise fix the problem?

-- 
tejun
