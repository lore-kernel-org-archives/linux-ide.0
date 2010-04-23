From: Jeff Garzik <jgarzik@redhat.com>
Subject: Re: [PATCH] drivers/ata/libata-eh.c: fix unused variable warning
Date: Fri, 23 Apr 2010 02:43:32 -0400
Message-ID: <20100423064332.GA22988@shell.devel.redhat.com>
References: <1271858846-1706-1-git-send-email-antonf@turbolinux.com.cn> <20100421152404.62699040@lxorguk.ukuu.org.uk> <4BCF1247.8080508@gmail.com> <4BCFA50E.80800@gmail.com> <4BD13E84.2040204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:5743 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab0DWGoT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Apr 2010 02:44:19 -0400
Content-Disposition: inline
In-Reply-To: <4BD13E84.2040204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Fang Wenqi <anton.fang@gmail.com>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, antonf@turbolinux.com.cn

On Fri, Apr 23, 2010 at 08:30:28AM +0200, Tejun Heo wrote:
> On 04/22/2010 03:23 AM, Fang Wenqi wrote:
> > Sorry that the title should be:
> >  "fix uninitialized variable warning"
> > 
> > not
> > "fix unused variable warning"
> > 
> > Need I re-send the patch mail ?
> 
> Yes, please do so.  gcc 4.4.1 generates a spurious warning on it too.
> 
> Acked-by: Tejun Heo <tj@kernel.org>

It's not a spurious warning.  The code failed to fully initialize all
fields of the ata_taskfile structure, prior to copying the ata_taskfile
structure into qc->result_tf.

	Jeff



