From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] ata_piix: Add MODULE_PARM_DESC to prefer_ms_hyperv
Date: Fri, 22 Feb 2013 18:43:39 +0400
Message-ID: <5127841B.2060207@cogentembedded.com>
References: <774443881.7195405.1361473310424.JavaMail.root@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:44399 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756685Ab3BVOo0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Feb 2013 09:44:26 -0500
Received: by mail-la0-f54.google.com with SMTP id gw10so675628lab.41
        for <linux-ide@vger.kernel.org>; Fri, 22 Feb 2013 06:44:24 -0800 (PST)
In-Reply-To: <774443881.7195405.1361473310424.JavaMail.root@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rado Vrbovsky <rvrbovsk@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff <jgarzik@redhat.com>

Hello.

On 21-02-2013 23:01, Rado Vrbovsky wrote:

> From: Andrew Brownfield <abrownfi@redhat.com>

> In reference to the commit cd006086fa5d91414d8ff9ff2b78fbb593878e3c
> "ata_piix: defer disks to the Hyper-V drivers by default",
> this trivial patch adds a description to prefer_ms_hyperv.

> [rvrbovsk@redhat.com: MODULE_PARM_DESC() string formatting modified]

> Signed-off-by: Andrew Brownfield <abrownfi@redhat.com>

    Note that you can't jus mechanically add Andrew's signoff to the patch, 
you have to ask him to sign it off... I hope you did.

> Signed-off-by: Radomir Vrbovsky <rvrbovsk@redhat.com>

MBR, Sergei

