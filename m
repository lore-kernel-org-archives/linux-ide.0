From: Rado Vrbovsky <rvrbovsk@redhat.com>
Subject: Re: [PATCH] ata_piix: Add MODULE_PARM_DESC to prefer_ms_hyperv
Date: Fri, 22 Feb 2013 10:41:49 -0500 (EST)
Message-ID: <1914029230.7688830.1361547709132.JavaMail.root@redhat.com>
References: <5127841B.2060207@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:32820 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab3BVPlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2013 10:41:50 -0500
In-Reply-To: <5127841B.2060207@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff <jgarzik@redhat.com>

> Hello.

Hi Sergei,
 
> On 21-02-2013 23:01, Rado Vrbovsky wrote:
> 
> > From: Andrew Brownfield <abrownfi@redhat.com>
> 
> > In reference to the commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c
> > "ata_piix: defer disks to the Hyper-V drivers by default",
> > this trivial patch adds a description to prefer_ms_hyperv.
> 
> > [rvrbovsk@redhat.com: MODULE_PARM_DESC() string formatting
> > modified]
> 
> > Signed-off-by: Andrew Brownfield <abrownfi@redhat.com>
> 
>     Note that you can't jus mechanically add Andrew's signoff to the
>     patch,
> you have to ask him to sign it off... I hope you did.

It was in the original patch and I erased by mistake.

> > Signed-off-by: Radomir Vrbovsky <rvrbovsk@redhat.com>
> 
> MBR, Sergei
> 

Brg,

Rado
