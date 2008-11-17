From: Tejun Heo <tj@kernel.org>
Subject: Re: Frequent head unloading
Date: Mon, 17 Nov 2008 14:16:53 +0900
Message-ID: <4920FE45.1040504@kernel.org>
References: <4920292B.5060804@gc-web.de> <4920E909.2030400@kernel.org> <4920FA98.5050108@gc-web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44695 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbYKQFRD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 17 Nov 2008 00:17:03 -0500
In-Reply-To: <4920FA98.5050108@gc-web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Clausen <alex@gc-web.de>
Cc: linux-ide@vger.kernel.org

Alexander Clausen wrote:
> Tejun Heo wrote:
>> How often does the clunking noises happen?
>>
> 
> Hmm, maybe 5-10 times per minute?
> Often 3-4 times in a row..
> Note the high Load_Cycle_Count in the smart_sda attachment in my first mail.

Yeap, I saw that.  Impressive.  :-)

Anyways, what kind of machine is this?  Is it a laptop?  The dmi
information seems awfully generic.

-- 
tejun
