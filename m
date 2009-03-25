From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: turn selectproc() method into dev_select() method
 (take 4)
Date: Wed, 25 Mar 2009 14:25:45 +0300
Message-ID: <49CA14B9.9030402@ru.mvista.com>
References: <200903242106.59175.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13815 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750838AbZCYLY6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Mar 2009 07:24:58 -0400
In-Reply-To: <200903242106.59175.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

Hello, I wrote:

> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Changes since the 3rd take:
> - added dev_select() method reference to 'superio_tp_ops' in ns87415.c...

    Now if I only declared ide_dev_select()... sigh. :-<

WBR, Sergei
