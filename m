From: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Subject: Re: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when
 system suspend
Date: Mon, 11 Mar 2013 21:01:11 +0100
Message-ID: <1363032071.4669.9.camel@donpedro.P-2601HN-F1>
References: <513D52BE.7040307@intel.com>
Reply-To: donpedro@tdcadsl.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cicero-fbr1.cybercity.dk ([212.242.40.5]:15156 "EHLO
	cicero4.cybercity.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab3CKUir (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Mar 2013 16:38:47 -0400
Received: from smtp2.cybercity.dk (smtp2.cybercity.dk [212.242.43.252])
	by cicero4.cybercity.dk (Postfix) with ESMTP id 7C95E11C6F8
	for <linux-ide@vger.kernel.org>; Mon, 11 Mar 2013 21:02:20 +0100 (CET)
In-Reply-To: <513D52BE.7040307@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: bladud@gmail.com, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hello, 

Sorry that i have not had time to investigate further.

However, it would seem that the logs provided by bladud shows (as i see
it) the problem (the logs Aaron requested).

https://bugzilla.kernel.org/show_bug.cgi?id=48951

1) When running without async suspend, the disks are suspended *after*
the sata_nv module. That makes sense, as we cannot expect the controller
to handle commands after it has been suspended.

2) when running with async suspended, the disks are suspended *before*
the sata_nv module. This does not make much sense. This would also
explain certain strangeness (different outcome) in the bug, as
effectively the disks are racing against their own controller!

Hmmmm how is this supposed to work? Even though async suspend is
enabled, the kernel must still have some dependencies that describe in
which order things can be suspended. What is the correct way of telling
the kernel (PM) that sata_nv cannot be suspended before all child disks
are suspended? How do other drivers handle this?

Any comments?

/pedro


On Mon, 2013-03-11 at 11:42 +0800, Aaron Lu wrote:
> Hi all,
> 
> I've seen some reports on STANDBY IMMEDIATE failed on NVIDIA MCP5x
> controllers when system goes to suspend(this command is sent by scsi sd
> driver on system suspend as a SCSI STOP command, which is translated to
> STANDBY IMMEDIATE ATA command). I've no idea of why this happened, so
> I wrote this email in hope of getting some new idea.
> 
> The related bug report:
> https://bugzilla.kernel.org/show_bug.cgi?id=48951
> 
> And google search showed that Peter reported a similar problem here:
> http://marc.info/?l=linux-ide&m=133534061316338&w=2
> 
> And bladud has found that, disable asyn suspend for the scsi target
> device can work around this problem.
> 
> Please feel free to suggest what can possibly be the cause, thanks.
> 
> -Aaron
> 


