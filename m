From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI problem with hotplug
Date: Wed, 14 Jan 2009 15:33:25 +0900
Message-ID: <496D8735.4030005@kernel.org>
References: <494178E3.6030305@cybernetics.com> <49588784.4020808@kernel.org> <4958E3DC.7080009@cybernetics.com> <49591710.7040102@shaw.ca> <49596D9E.3040904@kernel.org> <495D8606.5070807@kernel.org> <4964CCBF.5030408@cybernetics.com> <49655FBA.3060005@kernel.org> <49660B9F.4010408@cybernetics.com> <496696B2.7010006@shaw.ca> <49677B8D.7060807@cybernetics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35791 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182AbZANGdi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Jan 2009 01:33:38 -0500
In-Reply-To: <49677B8D.7060807@cybernetics.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hello,

Tony Battersby wrote:
> I am not really familiar with setpci,

Apparently neither am I.  :-)

> but apparently 93b and 93.b mean different things, and I suspect you
> probably meant 93.b.  Also, if the goal is to set the indicated PCS
> register to the same value it has when hotplugging does work, then
> the command that does that is "setpci -s 1f.2 92.b=01" or "setpci -s
> 1f.2 92.b=11".  However, this command still does not help.  Below
> are some more details of what I tried.

Can you please give a shot at "setpci -s 1f.2 92.b=7f"?

Thanks.

-- 
tejun
