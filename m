From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH] via82cxxx: fix cable detection
Date: Wed, 27 Dec 2006 14:45:50 +0100
Message-ID: <58cb370e0612270545v27be3791v1d0e5431b3bd505b@mail.gmail.com>
References: <20061227124659.GB10987@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:6854 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826AbWL0Npv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 08:45:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so5204765nfa
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 05:45:50 -0800 (PST)
In-Reply-To: <20061227124659.GB10987@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jgarzik@pobox.com>

On 12/27/06, Tejun Heo <htejun@gmail.com> wrote:
> Cable detection got broken probably while converting the driver to
> support multiple controllers.  Cable detection is done by examining
> how BIOS configured the attached devices.  The current code is broken
> in that it examines the status *after* modifying Clk66 configuration
> ending up detecting 40c cables as 80c.  This patch fixes it.

ACK

> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>
> This certainly is a regression and there are users affected by this.
> I've verified this on both primary and secondary channel of vt6421.
> Who takes IDE patches these days?  Jeff, can you push this through
> libata-dev#upstream-fixes?

I've pushed this to Linus already

Bart
