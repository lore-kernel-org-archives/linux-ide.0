From: Tejun Heo <htejun@gmail.com>
Subject: Re: AHCI driver preferring nr_ports over port map
Date: Mon, 04 Feb 2008 22:16:44 +0900
Message-ID: <47A7103C.1040804@gmail.com>
References: <47A70EA90200007800045D32@public.id2-vpn.continvity.gns.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:19217 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbYBDNQu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 08:16:50 -0500
Received: by an-out-0708.google.com with SMTP id d31so520102and.103
        for <linux-ide@vger.kernel.org>; Mon, 04 Feb 2008 05:16:49 -0800 (PST)
In-Reply-To: <47A70EA90200007800045D32@public.id2-vpn.continvity.gns.novell.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Jan Beulich wrote:
>> Do you have any real case where the above behavior causes problem?
> 
> It's not strictly a problem (i.e. nothing really mis-behaves), but it made
> me wonder why the box I saw this on gets 6 ahci device instances set
> up when spec as well as port map say there ought to be only 5. After
> looking at the ESB2 spec it seemed that behavior was clearly violating
> the spec: "For ports that are not available, software must not read or
> write to registers within that port.", which contradicts status being
> displayed for (and therefore status being read) from the 6th (not
> present) port.

Well, two values don't agree with each other and we know for a fact that
vendors sometimes get PI wrong, so we trust n_ports in such cases.  We
can reverse the behavior but that's likely to cause more problems than
it fixes.

-- 
tejun
