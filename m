From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] libata: Remove excess delay in the tf_load path
Date: Wed, 5 May 2010 12:07:21 +0100
Message-ID: <20100505120721.7ea1186b@lxorguk.ukuu.org.uk>
References: <20100505092350.586.46344.stgit@localhost.localdomain>
	<20100505092448.586.25299.stgit@localhost.localdomain>
	<4BE1474E.6080400@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49966 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755558Ab0EELBc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 07:01:32 -0400
In-Reply-To: <4BE1474E.6080400@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Alan Cox <alan@linux.intel.com>, jeff@garzik.org, linux-ide@vger.kernel.org

On Wed, 05 May 2010 14:24:14 +0400
Sergei Shtylyov <sshtylyov@mvista.com> wrote:

> Hello.
> 
> Alan Cox wrote:
> 
> > We don't need to stall and wait after loading the task file and before
> >   
> 
>    You mean *before* loading the taskfile?

It removes the stall between loading the task file and issuing the
command. I'll make the comment clearer about the ctl one.

>    The same wait is in sff_irq_on() method, I doubt that it's really 
> necessary as well, given that its result is always ignored...

Will have a look at that as a possible follow up patch.

