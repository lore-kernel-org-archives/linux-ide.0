Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7B2141D6;
	Wed,  2 Oct 2024 21:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727904053; cv=none; b=hzTicpu3SBwQh1B83sCYGw+kx8ZzWS+i+Og2nJ0Fb6S3zql8yHe+jC6D11Pub9rB1qvyQPxpoP60fqVO9gawbc9nN3Nfe68GvrVsQMqTH2TRaQiNmq4PrXwfwbY9xsdRh9tJ415TRvxqdJ/MGwhaI1urZFa8omTgNANTusL8VVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727904053; c=relaxed/simple;
	bh=gdad1ArQs7dcU2GwlY0QGuq1t8qdJOUwHzuOZR5LOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2PbNX6jMrLx6SNl9bXFSceZV2lnGoayjkhQjkmeV4Uc2MsABcCCxK8nPveK87ROFilGX/UBXe+Z78xXz2AEP4w6vbq5Q5ExcG2vBeMfNFBF+A+FadNLzJobMT4nGwytoFUSTa0dtxNDRFrwDBfrU4GX9h1XYX82K1TZ8npJudE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUdocXKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUdocXKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419DCC4CEC5;
	Wed,  2 Oct 2024 21:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727904053;
	bh=gdad1ArQs7dcU2GwlY0QGuq1t8qdJOUwHzuOZR5LOUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUdocXKe+hspz5NR87folnpHVz2Qlk9a6H5BrzEI0pkTRHvYbq5yXc3U4qxA7hbtJ
	 V/raFaJhDHA6RwI+JrD+QvSczrtj9g5IIao+B6joszeMIoEoO7EjEIVgGY4HkM0g56
	 ms6mxKzG8bkXh+f4kwCqzNA0KnfKWjUgfKLxVhBMRC7wbL1Tq1r+O0/uUSVF9iY3ZI
	 8OBdce9FTXu6pqDqHjUIwgCJlNFcNxRQgDO0qy2L8rhAF7dt4e9fsf1yI8Cj3La4QZ
	 Z3t0pMeS35ZA0Vkao0r6HNvbxv7KMVtGtz9gc2KuK7JTTGxrJadU6gdnsjQ3EEtC+x
	 +GsantFdAbKTA==
Date: Wed, 2 Oct 2024 23:20:49 +0200
From: Niklas Cassel <cassel@kernel.org>
To: W <linuxcdeveloper@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-ide@vger.kernel.org
Subject: Re: libahci driver and power switching HDD on newer kernels
Message-ID: <Zv25MQWh-1yYAcVC@ryzen.lan>
References: <7882faa8-d5ec-4868-b158-0b942b669cc0@gmail.com>
 <c4f1c690-6e97-44de-985f-dc9eadd18d23@leemhuis.info>
 <c7880a6f-04d4-4572-9255-1575f6668b4e@kernel.org>
 <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c34406-3bb3-4880-9513-0876aacd4de6@gmail.com>

On Tue, Sep 24, 2024 at 12:42:10PM +0200, W wrote:
> > 
> > Given that you had 6.4.12 working OK, it is likely some commit that introduced a
> > regression. If you can git bisect it, we will have a better idea how to remove
> > the regression.
> 
> Please take a look at bugzilla report:
> https://bugzilla.kernel.org/show_bug.cgi?id=219296 - there are the details.
> 
> I'm wondering what is the better way for communication - here on mailing
> list or put the comments in bugzilla ticket?
> Probably here will be better idea...
> 
> W
> 

Hello W,

Could you please try the following patch,
and see if it helps:


From dba01b7d68fffc26f3abf3252296082311a767a0 Mon Sep 17 00:00:00 2001
From: Niklas Cassel <cassel@kernel.org>
Date: Wed, 2 Oct 2024 21:40:41 +0200
Subject: [PATCH] ata: libata: do not spin down disk on PM event freeze

Currently, ata_eh_handle_port_suspend() will return early if
ATA_PFLAG_PM_PENDING is not set, or if the PM event has flag
PM_EVENT_RESUME set.

This means that the following PM callbacks:
.suspend = ata_port_pm_suspend,
.freeze = ata_port_pm_freeze,
.poweroff = ata_port_pm_poweroff,
.runtime_suspend = ata_port_runtime_suspend,
will actually make ata_eh_handle_port_suspend() perform some work.

ata_eh_handle_port_suspend() will spin down the disks (by calling
ata_dev_power_set_standby()), regardless of the PM event.

Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
explicitly mentions that .freeze() does not have to be put the device in
a low-power state, and actually recommends not doing so. Thus, let's not
spin down the disk for the .freeze() callback. (The disk will instead be
spun down during the succeeding .poweroff() callback.)

Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/libata-eh.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 3f0144e7dc80..45a0d9af2d54 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4099,10 +4099,20 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 
        WARN_ON(ap->pflags & ATA_PFLAG_SUSPENDED);
 
-       /* Set all devices attached to the port in standby mode */
-       ata_for_each_link(link, ap, HOST_FIRST) {
-               ata_for_each_dev(dev, link, ENABLED)
-                       ata_dev_power_set_standby(dev);
+       /*
+        * We will reach this point for all of the PM events:
+        * PM_EVENT_SUSPEND (if runtime pm, PM_EVENT_AUTO will also be set)
+        * PM_EVENT_FREEZE, and PM_EVENT_HIBERNATE.
+        *
+        * We do not want to perform disk spin down for PM_EVENT_FREEZE.
+        * (Spin down will be performed by the succeeding PM_EVENT_HIBERNATE.)
+        */
+       if (!(ap->pm_mesg.event & PM_EVENT_FREEZE)) {
+               /* Set all devices attached to the port in standby mode */
+               ata_for_each_link(link, ap, HOST_FIRST) {
+                       ata_for_each_dev(dev, link, ENABLED)
+                               ata_dev_power_set_standby(dev);
+               }
        }
 
        /*
-- 
2.46.2
