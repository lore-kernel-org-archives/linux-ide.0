From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: +
 pata_viac-add-flag-for-vx800-and-add-a-function-for-fixing-internal-bugs-for-via-chipsets.patch
 added to -mm tree
Date: Mon, 28 Jul 2008 13:48:47 +0100
Message-ID: <20080728134847.612106ec@lxorguk.ukuu.org.uk>
References: <200807220814.m6M8EYoC017989@imap1.linux-foundation.org>
	<488DC365.1020806@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46159 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750823AbYG1NGx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 28 Jul 2008 09:06:53 -0400
In-Reply-To: <488DC365.1020806@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, JosephChan@via.com.tw, jeff@garzik.org, IDE/ATA development list <linux-ide@vger.kernel.org>

> And, likewise, I think
> 
> 	if (tf->ctl != tf->last_ctl)
> 		tf->flags |= ATA_TFLAG_DEVICE;
> 	ata_sff_tf_load(ap, tf);
> 
> would be better.

Are we actually guranteed that tf->device is valid in every case where
ATA_TFLAG_DEVICE is not set ? I don't think we actually are, in which
case we should cache the last tf->device in the ap->private_data
structures
