From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [patch 3/3] pata: "I do not think it means, what you think it means."
Date: Wed, 5 Mar 2008 17:13:49 +0100
Message-ID: <58cb370e0803050813q6cb1082cy7e540a77993f3dd6@mail.gmail.com>
References: <200803042316.m24NGI7k002489@imap1.linux-foundation.org>
	 <20080304173058.7679b7c8.akpm@linux-foundation.org>
	 <20080305115610.397b3ea3@the-village.bc.nu>
	 <200803051421.14167.bzolnier@gmail.com>
	 <20080305143949.1f56017c@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:26370 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144AbYCEQNw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 Mar 2008 11:13:52 -0500
Received: by fk-out-0910.google.com with SMTP id z23so1545088fkz.5
        for <linux-ide@vger.kernel.org>; Wed, 05 Mar 2008 08:13:50 -0800 (PST)
In-Reply-To: <20080305143949.1f56017c@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, jeff@garzik.org, linux-ide@vger.kernel.org, alan@redhat.com, linux-kernel@vger.kernel.org

On Wed, Mar 5, 2008 at 3:39 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > There is strange coincidence with being on the blacklist and FIFO corruption.
>  >
>  > https://bugzilla.redhat.com/show_bug.cgi?id=433557
>  >
>  > Bugzilla Bug 433557: Data corrupion with Fedora8 on HPT370 disk controller (Abit BX133 mobo)
>  >
>  > IBM-DTLA-307030 is on the blacklist....
>
>  I wish it was more than a co-incidence but the trace shows it dropped
>  speed as expected.

the trace shows only ST380011A (ata1) dropping speed...

I would suggest that you ask Wojciech to test the patch
(unless it has already happend).

>  > for OSB4 yes but...
>  >
>  > /* Seagate Barracuda ATA IV Family drives in UDMA mode 5
>  >  * can overrun their FIFOs when used with the CSB5 */
>
>  Which gives you a CRC error according to my notes

I have no documentation / errata for ServerWorks chipsets (everything is
NDA-ed) or the hardware in question so I'll trust your opinion on this.

Thanks,
Bart
