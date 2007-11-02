From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: question on patch: ide: do_identify() string termination fix [PATCH 2.6.11-rc2 08/29]
Date: Fri, 2 Nov 2007 20:44:21 +0100
Message-ID: <200711022044.21474.bzolnier@gmail.com>
References: <987926.65237.qm@web55214.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:59724 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824AbXKBWIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:14 -0400
Received: by nf-out-0910.google.com with SMTP id g13so940294nfb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:12 -0700 (PDT)
In-Reply-To: <987926.65237.qm@web55214.mail.re4.yahoo.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yanping Du <ypdu2001@yahoo.com>
Cc: linux-ide@vger.kernel.org

On Tuesday 30 October 2007, Yanping Du wrote:
> Hi,
> 
>   We hit an NMI watchdog on cpu lockup (trace below)
> and I suspect it might be related to following string
> termination bug. However I wonder why this bug fix is
> not incorporated in latest mainline kernel (2.6.23.1

it must have slipped through the cracks...

> as I checked). The bug fix seems straightforward to
> me. Did I miss anything ? Our kernel is 2.6.12.
> 
> http://osdir.com/ml/ide/2005-02/msg00038.html

applied
