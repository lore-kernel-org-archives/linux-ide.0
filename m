From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 5/5] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 18:51:30 -0400
Message-ID: <4C3261F2.1020706@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com> <4C3261AE.2070307@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:5618 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754411Ab0GEWvb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 18:51:31 -0400
In-Reply-To: <4C3261AE.2070307@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 05/07/10 06:50 PM, Mark Lord wrote:
> Take further advantage of the new glob_match() function to reduce the
> blacklist size,
> this time making use of "character ranges" in the patterns.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>


NAK that one.  I'll resubmit a (v2) shortly.
