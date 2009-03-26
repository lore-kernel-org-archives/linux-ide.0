From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: turn selectproc() method into dev_select() method (take 5)
Date: Thu, 26 Mar 2009 21:18:14 +0100
Message-ID: <200903262118.14931.bzolnier@gmail.com>
References: <200903251439.54468.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:64377 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbZCZVTR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2009 17:19:17 -0400
Received: by bwz17 with SMTP id 17so746159bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2009 14:19:14 -0700 (PDT)
In-Reply-To: <200903251439.54468.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, benh@kernel.crashing.org, petkovbb@gmail.com

On Wednesday 25 March 2009, Sergei Shtylyov wrote:
> Turn selectproc() method into dev_select() method by teaching it to write to the
> device register and moving it from 'struct ide_port_ops' to 'struct ide_tp_ops'.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> ---
> Changes since the 4th take:
> - added ide_dev_select() declaration to <linux/ide.h> at last... :-/

Seems like putting a bit more time into re-auditing the whole patch after
first issues are discovered/fixed wouldn't hurt... and yes, the same can be
said about re-reviewing it in this case...

applied (in place of 'take 2')
