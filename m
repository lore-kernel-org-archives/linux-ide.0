From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/8] ide: always auto-tune PIO in legacy VLB host drivers
Date: Mon, 24 Mar 2008 12:50:02 +0100
Message-ID: <200803241250.02775.bzolnier@gmail.com>
References: <aajV7-54-9@gated-at.bofh.it> <E1JdcPD-0000lP-2t@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:17859 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758047AbYCXLfT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 07:35:19 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2925340fgb.17
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 04:35:17 -0700 (PDT)
In-Reply-To: <E1JdcPD-0000lP-2t@be1.7eggert.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 7eggert@gmx.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 March 2008, Bodo Eggert wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> |Subject: [PATCH 1/8] ide: always auto-tune PIO in legacy VLB host drivers
> 
> AFAIR this isn't safe for bus speeds above 33 MHz, is it?

It should be safe as VLB host drivers assume that bus speed is 50 MHz
(so the longest timings are used) if bus speed is not given by user
(using "idebus=" or "ide_core.vlb_clock=")?

Thanks,
Bart
