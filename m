From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2.6.15-rc5 1/1] sgiioc4: check for no hwifs available
Date: Wed, 14 Dec 2005 22:12:07 +0100
Message-ID: <58cb370e0512141312l6ce96018k62773f57780ca676@mail.gmail.com>
References: <20051214011728.GA184713@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.204]:58661 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964989AbVLNVMK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 14 Dec 2005 16:12:10 -0500
Received: by nproxy.gmail.com with SMTP id x29so72726nfb
        for <linux-ide@vger.kernel.org>; Wed, 14 Dec 2005 13:12:08 -0800 (PST)
In-Reply-To: <20051214011728.GA184713@sgi.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-ide@vger.kernel.org, jrn@sgi.com, maule@sgi.com

applied, thanks

On 12/14/05, Jeremy Higdon <jeremy@sgi.com> wrote:
> Add a check to the sgiioc4 driver for the case where all available
> ide_hwifs structures are in use.
>
> Signed-off-by: Jeremy Higdon <jeremy@sgi.com>
