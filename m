From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ide: turn selectproc() method into dev_select() method
 (take 3)
Date: Tue, 24 Mar 2009 20:50:22 +0300
Message-ID: <49C91D5E.5070905@ru.mvista.com>
References: <200903241736.38828.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:57535 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754505AbZCXRtf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Mar 2009 13:49:35 -0400
In-Reply-To: <200903241736.38828.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

Hello, I wrote:

> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> Changes since the 2nd take:
> - added reference to ide_dev_select() to (hopefully) all instances of 'struct
>   ide_tp_ops' where it was missing...

    The hope was vain -- one instance remained in ns87415.c... :-/

MBR, Sergei
