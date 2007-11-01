From: "Torsten Kaiser" <just.for.lkml@googlemail.com>
Subject: Re: [PATCH] libata ATAPI transfer size cleanups
Date: Thu, 1 Nov 2007 20:51:06 +0100
Message-ID: <64bb37e0711011251w255746c7x6947f85431d4f4fe@mail.gmail.com>
References: <20071101090733.GA9258@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:54132 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbXKATvH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Nov 2007 15:51:07 -0400
Received: by py-out-1112.google.com with SMTP id u77so1127583pyb
        for <linux-ide@vger.kernel.org>; Thu, 01 Nov 2007 12:51:07 -0700 (PDT)
In-Reply-To: <20071101090733.GA9258@havoc.gtf.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 11/1/07, Jeff Garzik <jeff@garzik.org> wrote:
> +       lo = tf->lbam;
> +       hi = tf->lbam;
> +       ibyte = (hi << 8) | lo;
> +
> +       lo = result_tf->lbam;
> +       hi = result_tf->lbam;

That doesn't look right.
I suspect this was intended:

lo = tf->lbam;
hi = tf->lbah;

Torsten
