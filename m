From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ide: turn selectproc() method into dev_select() method
 (take 2)
Date: Tue, 24 Mar 2009 17:17:59 +0300
Message-ID: <49C8EB97.5020707@ru.mvista.com>
References: <200903231518.07703.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:53390 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1761358AbZCXORN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 10:17:13 -0400
In-Reply-To: <200903231518.07703.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

Hello, I wrote:

> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> This patch is atop of the latest pata-2.6 series...
> Changes since the first take:
> - fixed compilation error in ns87415.c;
> - added 'ide_dev_select' reference to 'default_tp_ops', fixing kernel oops;

    My bad. :-< There are still 'struct ide_tp_ops' instances missing this 
reference, so there's going to be another take...

MBR, Sergei
