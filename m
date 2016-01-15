From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: disable forced PORTS_IMPL for >= v3.0 controllers
Date: Fri, 15 Jan 2016 14:48:54 -0500
Message-ID: <20160115194854.GM3520@mtj.duckdns.org>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
 <CALCETrVCfQjMQgnjpJh6YPsRF18X=XYRTb3Aoqbhe3f3ucam4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35960 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcAOTs4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2016 14:48:56 -0500
Content-Disposition: inline
In-Reply-To: <CALCETrVCfQjMQgnjpJh6YPsRF18X=XYRTb3Aoqbhe3f3ucam4w@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

On Thu, Jan 14, 2016 at 05:00:57PM -0800, Andy Lutomirski wrote:
> [  +0.001350] ahci 0000:00:17.0: version 3.0
> [  +0.000034] ahci 0000:00:17.0: forcing PORTS_IMPL to 0xff
> 
> My "vers" is 0x10301.

Ah, right, of course.  I was looking at the driver version, which I'm
not even sure why we have.  Will update the patch.

Thanks.

-- 
tejun
