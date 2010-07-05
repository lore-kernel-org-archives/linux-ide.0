From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 4/4] libata: allow hyphenated pattern ranges
Date: Mon, 05 Jul 2010 14:33:41 -0400
Message-ID: <4C322585.602@pobox.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60100 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab0GESdq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jul 2010 14:33:46 -0400
Received: by gxk23 with SMTP id 23so2591909gxk.19
        for <linux-ide@vger.kernel.org>; Mon, 05 Jul 2010 11:33:46 -0700 (PDT)
In-Reply-To: <4C31EB69.5070903@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 07/05/2010 10:25 AM, Mark Lord wrote:
> Enable use of hyphenated pattern ranges in glob_match(), similar to how
> shell globbing works, and how developers might expect things to work.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
>
> Patch also attached, to get around ongoing mailer issues here.
> Eventually, glob_match() will move out of libata into lib/string.c or
> similar.

No issue with correctness...  but where is the demonstrated need?

Did someone ask for this?

	Jeff



