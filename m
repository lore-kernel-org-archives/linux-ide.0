From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: ata_scsi_queuecmd locking question
Date: Tue, 16 Aug 2005 18:35:32 -0400
Message-ID: <43026A34.5000403@pobox.com>
References: <4789af9e05081615216c1de2be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:37569 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750704AbVHPWfj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Aug 2005 18:35:39 -0400
In-Reply-To: <4789af9e05081615216c1de2be@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Ramsay <jim.ramsay@gmail.com>
Cc: Linux-ide <linux-ide@vger.kernel.org>

Jim Ramsay wrote:
> I'm just looking into libata-scsi.c, and noticed that the comments for
> ata_scs_queuecmd note that it is supposed to obtain host_set->lock. 
> It doesn't seem to do so.
> 
> Should it?

The SCSI layer acquires this lock for us.

	Jeff



