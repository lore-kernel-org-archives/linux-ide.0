From: Tejun Heo <tj@kernel.org>
Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Mon, 27 Oct 2008 16:35:08 +0900
Message-ID: <49056F2C.20101@kernel.org>
References: <20081011142735.GB5904@cleopatra.jogback.se> <48F4337A.50307@kernel.org> <20081014201917.GA5974@cleopatra.jogback.se> <48F595DB.4030301@kernel.org> <20081018165209.GA7754@cleopatra.jogback.se> <20081023181443.GA7323@cleopatra.jogback.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37457 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751591AbYJ0HfR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 27 Oct 2008 03:35:17 -0400
In-Reply-To: <20081023181443.GA7323@cleopatra.jogback.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lars Michael Jogback <lm@jogback.se>
Cc: linux-ide@vger.kernel.org

Lars Michael Jogback wrote:
> Hi,
> 
> I did installed an earlier kernel on the machine, and then hotplug
> worked.
> 
> This is the log when I did hotplug using v2.6.24 (the kernel from Debian
> Etch-n-half)

Hmmm... 2.6.24 works but 2.6.26 doesn't, strange.  I've been trying to
reproduce the problem here but it doesn't happen with any drive I
have.  I just ordered a similar drive, so I might have better luck
with it.  I'll write back when I know more.

Thanks.

-- 
tejun
