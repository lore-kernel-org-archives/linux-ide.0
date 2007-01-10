From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: No DMA with HTP370 IDE controller
Date: Wed, 10 Jan 2007 15:24:13 +0300
Message-ID: <45A4DAED.9070404@ru.mvista.com>
References: <45A29690.3040003@berlin.de>	 <58cb370e0701081155j7376d15dv32e3b65906c8d325@mail.gmail.com>	 <45A35A8C.9040200@berlin.de> <58cb370e0701090544p2a851182m30f24e0fdd86f328@mail.gmail.com> <45A435A3.2020506@berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:13739 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932796AbXAJMYV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 10 Jan 2007 07:24:21 -0500
In-Reply-To: <45A435A3.2020506@berlin.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Bueker <m.bueker@berlin.de>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Hello.

Michael Bueker wrote:

>> Have you looked at changes to drivers/ide/pci/hpt366.c?
>> The code is not the same, there are a lot of fixes in -mm:

>> hpt3xx-rework-rate-filtering.patch
>> hpt3xx-rework-rate-filtering-tidy.patch
>> hpt3xx-print-the-real-chip-name-at-startup.patch
>> hpt3xx-switch-to-using-pci_get_slot.patch
>> hpt3xx-cache-channels-mcr-address.patch
>> hpt3x7-merge-speedproc-handlers.patch
>> hpt370-clean-up-dma-timeout-handling.patch
>> hpt3xx-init-code-rewrite.patch

> I applied all of these patches, but the errors remains just the same. I 
> actually did it twice to be sure, but to no avail.

    Then it's probably the same issue as here:

http://bugzilla.kernel.org/show_bug.cgi?id=7703

    What's really strange is that my HPT370 is working fine.  However, the 
chip marking says it's HPT370A despite the revision ID is 3 (which should 
correspond to HPT370)...

> ~Mik

WBR, Sergei
