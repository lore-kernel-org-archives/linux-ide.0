From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 00/86] PATA fixes
Date: Thu, 03 Dec 2009 17:57:30 -0500
Message-ID: <4B18425A.2020408@garzik.org>
References: <20091125170218.5446.13513.sendpatchset@localhost> <200912031339.14440.bzolnier@gmail.com> <4B17FB37.2030501@garzik.org> <200912032045.48728.bzolnier@gmail.com> <4B182A9F.5090708@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:54164 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZLCW50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 17:57:26 -0500
In-Reply-To: <4B182A9F.5090708@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/03/2009 04:16 PM, Jeff Garzik wrote:
>> pata_efar: MWDMA0 is unsupported
>
> skipped, pending discussion (just sent email)

applied, after merging into a single "PIIX no MWDMA0" patch

>> pata_hpt3x2n: fix overclocked MWDMA0 timing
>
> skipped, pending discussion (just sent email)

applied

>> pata_it8213: MWDMA0 is unsupported
>
> skipped, pending discussion (just sent email)

applied

>> pata_oldpiix: MWDMA0 is unsupported
>
> skipped -- Alan, Sergey, comments?

applied, after merging into a single "PIIX no MWDMA0" patch

>> pata_rdc: MWDMA0 is unsupported
>
> skipped -- Alan, Sergey, comments?

applied, after merging into a single "PIIX no MWDMA0" patch

