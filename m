From: Tejun Heo <tj@kernel.org>
Subject: Re: + pata_viac-add-flag-for-vx800-and-add-a-function-for-fixing-internal-bugs-for-via-chipsets.patch
 added to -mm tree
Date: Mon, 28 Jul 2008 22:14:40 +0900
Message-ID: <488DC640.3070406@kernel.org>
References: <200807220814.m6M8EYoC017989@imap1.linux-foundation.org>	<488DC365.1020806@kernel.org> <20080728134847.612106ec@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49827 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbYG1NP7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 28 Jul 2008 09:15:59 -0400
In-Reply-To: <20080728134847.612106ec@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, JosephChan@via.com.tw, jeff@garzik.org, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> And, likewise, I think
>>
>> 	if (tf->ctl != tf->last_ctl)
>> 		tf->flags |= ATA_TFLAG_DEVICE;
>> 	ata_sff_tf_load(ap, tf);
>>
>> would be better.
> 
> Are we actually guranteed that tf->device is valid in every case where
> ATA_TFLAG_DEVICE is not set ? I don't think we actually are, in which
> case we should cache the last tf->device in the ap->private_data
> structures

Yeap, tf->device is setup during ata_tf_init().

-- 
tejun
