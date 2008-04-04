From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCHSET #upstream] libata: modularize PMP support, take #1
Date: Fri, 04 Apr 2008 03:47:54 -0400
Message-ID: <47F5DD2A.9010604@garzik.org>
References: <1206451517133-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41341 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757409AbYDDHr4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Apr 2008 03:47:56 -0400
In-Reply-To: <1206451517133-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca

Tejun Heo wrote:
> Hello, all.
> 
> This patchset modularizes PMP support and contains the following three
> patches.
> 
>   mails/0001-libata-separate-PMP-support-code-from-core-code.patch
>   mails/0002-libata-implement-PMP-helpers.patch
>   mails/0003-libata-make-PMP-support-optional.patch
> 
> LLDs which support PMP don't depend on PMP.  If PMP is turned on,
> those LLDs support PMP, if PMP is off, they don't.  The size of
> libata.ko on x86_64 w all debugging options off change like the
> following.
> 
> 		ON-DISK		LOADED
> +SFF+PMP	226k		157k
> +SFF-PMP	204k		141k
> -SFF+PMP	193k		133k
> -SFF-PMP	171k		117k
> 
> Both ahci and sata_sil24 have been verified to work w/ PMP turned on
> and off.
> 
> This patchset is on top of
> 
>   upstream-fixes (4cde32fc4b32e96a99063af3183acdfd54c563f0)
> + prefer-hardreset (990d6db0af21830681157317ab58c10f80277cb8)
> + cleanup-sht-ops (ed75ba53c883bc7a63fa1b60c63f33fcf395e751)
> + [1] cleanup-pdc_adma
> + [2] modularize-SFF-support patchset, take #1
> 
> This patchset is available as git tree.
> 
>   http://git.kernel.org/?p=linux/kernel/git/tj/libata-dev.git;a=shortlog;h=modularize-PMP
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/libata-dev.git modularize-PMP

ACK patchset

will pull after a resync with #upstream


