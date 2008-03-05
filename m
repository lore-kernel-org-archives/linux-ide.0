From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it
 means."
Date: Wed, 5 Mar 2008 14:39:49 +0000
Message-ID: <20080305143949.1f56017c@the-village.bc.nu>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
	<20080304173058.7679b7c8.akpm@linux-foundation.org>
	<20080305115610.397b3ea3@the-village.bc.nu>
	<200803051421.14167.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ip32-53-209-87.adsl2.versatel.nl ([87.209.53.32]:58543 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756805AbYCEPCx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 10:02:53 -0500
In-Reply-To: <200803051421.14167.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, linux-kernel@vger.kernel.org

> There is strange coincidence with being on the blacklist and FIFO corruption.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=433557
> 
> Bugzilla Bug 433557: Data corrupion with Fedora8 on HPT370 disk controller (Abit BX133 mobo)
> 
> IBM-DTLA-307030 is on the blacklist....

I wish it was more than a co-incidence but the trace shows it dropped
speed as expected.

> for OSB4 yes but...
> 
> /* Seagate Barracuda ATA IV Family drives in UDMA mode 5
>  * can overrun their FIFOs when used with the CSB5 */

Which gives you a CRC error according to my notes

Alan
