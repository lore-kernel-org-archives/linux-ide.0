From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2] libata: disable forced PORTS_IMPL for >= AHCI 1.3
Date: Fri, 15 Jan 2016 14:49:10 -0800
Message-ID: <CALCETrX6yvmkPjVKNbi2sQV7KRSVtM_3-y=9n3ybsrp=vxfjWw@mail.gmail.com>
References: <CALCETrU7yMvXEDhjAUShoHEhDwifJGapdw--BKxsP0jmjKGmRw@mail.gmail.com>
 <20160114223732.GG3520@mtj.duckdns.org> <20160115201305.GN3520@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:35323 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbcAOWta (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jan 2016 17:49:30 -0500
Received: by mail-ob0-f180.google.com with SMTP id py5so154466991obc.2
        for <linux-ide@vger.kernel.org>; Fri, 15 Jan 2016 14:49:29 -0800 (PST)
In-Reply-To: <20160115201305.GN3520@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jan 15, 2016 at 12:13 PM, Tejun Heo <tj@kernel.org> wrote:
> Some early controllers incorrectly reported zero ports in PORTS_IMPL
> register and the ahci driver fabricates PORTS_IMPL from the number of
> ports in those cases.  This hasn't mattered but with the new nvme
> controllers there are cases where zero PORTS_IMPL is valid and should
> be honored.
>
> Disable the workaround for >= AHCI 1.3.

Tested-by: Andy Lutomirski <luto@kernel.org>

--Andy
