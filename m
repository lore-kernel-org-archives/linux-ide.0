From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] libata: disable forced PORTS_IMPL for >= v3.0 controllers
Date: Thu, 14 Jan 2016 17:00:57 -0800
Message-ID: <CALCETrVCfQjMQgnjpJh6YPsRF18X=XYRTb3Aoqbhe3f3ucam4w@mail.gmail.com>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34717 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbcAOBBR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jan 2016 20:01:17 -0500
Received: by mail-oi0-f41.google.com with SMTP id k206so127328870oia.1
        for <linux-ide@vger.kernel.org>; Thu, 14 Jan 2016 17:01:17 -0800 (PST)
In-Reply-To: <20160114223732.GG3520@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jan 14, 2016 at 2:37 PM, Tejun Heo <tj@kernel.org> wrote:
> Some early controllers incorrectly reported zero ports in PORTS_IMPL
> register and the ahci driver fabricates PORTS_IMPL from the number of
> ports in those cases.  This hasn't mattered but with the new nvme
> controllers there are cases where zero PORTS_IMPL is valid and should
> be honored.
>
> Disable the workaround for controllers >= v3.0.

I still see:

[  +0.001350] ahci 0000:00:17.0: version 3.0
[  +0.000034] ahci 0000:00:17.0: forcing PORTS_IMPL to 0xff

My "vers" is 0x10301.

--Andy
