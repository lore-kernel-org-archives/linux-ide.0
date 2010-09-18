From: Tejun Heo <tj@kernel.org>
Subject: Re: Either PMP issues, or SB700/800 Issues ??
Date: Sat, 18 Sep 2010 09:33:05 +0200
Message-ID: <4C946B31.3060804@kernel.org>
References: <AANLkTikMLg2Uweeszw7pU9ZKWA0wTdLS5Y3NovOsb0fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58742 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab0IRHbt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 18 Sep 2010 03:31:49 -0400
In-Reply-To: <AANLkTikMLg2Uweeszw7pU9ZKWA0wTdLS5Y3NovOsb0fa@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg Oliver <oliver.greg@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 09/17/2010 07:05 PM, Greg Oliver wrote:
> Does anyone know how far back I can take this working libahci/ahci
> code?  I would really like to get it running in centos - 2.6.19, but I
> assume that's a no go..  2.6.32 would be ideal, but I guess I could
> live with 2.6.35 since there are patches floating around to make all
> of my aforementioned stuff work.

I don't recall any PMP or ahci related fix which could have cuased
such behavior difference between 2.6.35 and 36 branch.  Are you sure
there aren't other factors which could be affecting the test result?
Does going back to 2.6.35 reliably reproduce the problem?  If so, can
you please attach full kernel log including boot and the failure
preferably with timestamps turned on?  Also, please post the output of
"lspci -nn".

Thanks.

-- 
tejun
