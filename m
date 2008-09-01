From: "xerces8" <xerces8@butn.net>
Subject: Re: Intel AHCI ICH9R not detecting devices
Date: Mon, 01 Sep 2008 12:40:58 +0200
Message-ID: <WorldClient-F200809011240.AA40580113@butn.net>
References: <WorldClient-F200808221729.AA29360172@butn.net> <48B92399.6010808@kernel.org> <WorldClient-F200808302142.AA42270030@butn.net> <48BBB248.7090904@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ikar.perftech.si ([195.246.0.20]:11685 "EHLO ikar.perftech.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbYIAKlG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Sep 2008 06:41:06 -0400
Received: from dedal.perftech.si (unknown [10.12.0.44])
	by ikar.perftech.si (Spam Firewall) with ESMTP id DB77D327A3D
	for <linux-ide@vger.kernel.org>; Mon,  1 Sep 2008 12:41:02 +0200 (CEST)
Received: from dedal.perftech.si ([10.12.0.44]) by ikar.perftech.si with ESMTP id jOd31zPsiV3QtGQL for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 12:41:02 +0200 (CEST)
Received: from WorldClient by butn.net (MDaemon PRO v9.6.4)
	with ESMTP id 51-md50000233524.msg
	for <linux-ide@vger.kernel.org>; Mon, 01 Sep 2008 12:41:00 +0200
In-Reply-To: <48BBB248.7090904@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Tejun Heo <tj@kernel.org> wrote:

> xerces8 wrote:
> >> This looks like resource conflict to me, which could have resulted
> >> from ahci trying to grab all resources.  Can you please post the
> >> result of "cat /proc/ioports" and "cat /proc/iomem"?
> > 
> > I noticed that in IDE mode the same happens (32bit kernel has problems,
> > 64bit kernel has not), so here is dmesg, iomem and ioports for all 4
> > combinations.
> 
> Can you please try the attached debug patch and report boot log.  All
> resources look fine.

(removing stein@hermes.si from CC, that is my other email address)

Hi!

I am away from home and will try the patch probably on Friday.

Until then thanks for your support!

David


