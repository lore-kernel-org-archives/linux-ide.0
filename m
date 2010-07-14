From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/5] libata: allow hyphenated pattern ranges (v2)
Date: Wed, 14 Jul 2010 03:54:54 -0400
Message-ID: <4C3D6D4E.8020502@pobox.com>
References: <4C2CB497.3000701@teksavvy.com> <4C2CEB70.3090209@pobox.com> <4C2D0F05.6040706@teksavvy.com> <4C2D13AE.6090701@teksavvy.com> <4C2D13F1.9030408@teksavvy.com> <4C2D1424.4050407@teksavvy.com> <4C31EB69.5070903@teksavvy.com> <4C3261AE.2070307@teksavvy.com> <4C326271.4040005@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38128 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751996Ab0GNHy6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jul 2010 03:54:58 -0400
Received: by gxk23 with SMTP id 23so3664412gxk.19
        for <linux-ide@vger.kernel.org>; Wed, 14 Jul 2010 00:54:58 -0700 (PDT)
In-Reply-To: <4C326271.4040005@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>

On 07/05/2010 06:53 PM, Mark Lord wrote:
> Take further advantage of the new glob_match() function to reduce the
> blacklist size,
> this time making use of "character ranges" in the patterns.
>
> Signed-off-by: Mark Lord <mlord@pobox.com>
> ---
> No change from original post -- false alarm.
> (also attached to bypass issues with my b0rked email client).

applied #4 and #5

had to utilize the attachments, as mail client still does not seem to be 
cooperating.  otherwise, patches applied and lightly tested without a hitch.


