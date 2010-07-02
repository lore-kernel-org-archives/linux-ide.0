From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] libata: reduce blacklist size even more (v2)
Date: Fri, 02 Jul 2010 03:19:22 -0400
Message-ID: <4C2D92FA.2070600@pobox.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45032 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767Ab0GBHT0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jul 2010 03:19:26 -0400
Received: by gxk23 with SMTP id 23so1493021gxk.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Jul 2010 00:19:25 -0700 (PDT)
In-Reply-To: <4C2D1424.4050407@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 07/01/2010 06:18 PM, Mark Lord wrote:
> Take further advantage of the new glob_match() function to reduce the
> blacklist size.
> There are even more savings possible, but how far do we want to go with
> this?
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
>
> (re-diff'd against latest -git, and also attached to bypass mailer issues)

applied 1-3

Unfortunately I had to use the attachments, as again, neither git-am nor 
patch(1) liked the emailed result otherwise.

	Jeff




