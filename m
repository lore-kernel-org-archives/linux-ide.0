From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 4/4] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 18:39:48 -0400
Message-ID: <4C325F34.8040502@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com> <4C322585.602@pobox.com> <4C3252FF.3040501@teksavvy.com> <4C325AA2.9020201@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:36092 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754203Ab0GEWjv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 18:39:51 -0400
In-Reply-To: <4C325AA2.9020201@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 05/07/10 06:20 PM, Jeff Garzik wrote:
>
> In this case, if you send a follow-on patch to _use_ this, I would be
> happy to apply both glob_match() and blacklist patches at that point.
..

Okay, I'll do that.  Shortly.

> 2) once other kernel users appear, submit the "move to lib/string" patch
> as a distinct patch in the series of patches to driver XYZ adding a
> glob_match() caller. I'll happily add an Acked-by on your patch, and it
> can be submitted either direct to Linus/Andrew, or via the specific
> subsystem tree that is adding a new glob_match() caller.
..

James was nudging for me/somebody to do the same sort of thing for SCSI black/white lists.
So that'll be the next user, I suppose.

Except those'll have to go via his tree, which currently lacks the glob_match() function.
So I suppose perhaps I'll just wait until after 2.6.36 opens for that.

Cheers
