From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Bug #4580: hda: lost interrupt when resuming from S3 - Sony VGN-T1XP
Date: Mon, 8 Oct 2007 23:44:45 +0200
Message-ID: <200710082344.45377.bzolnier@gmail.com>
References: <200710072217.07656.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:59008 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbXJHVj7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Oct 2007 17:39:59 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1370235nfb
        for <linux-ide@vger.kernel.org>; Mon, 08 Oct 2007 14:39:58 -0700 (PDT)
In-Reply-To: <200710072217.07656.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>


Hi,

On Sunday 07 October 2007, Rafael J. Wysocki wrote:
> Hi,
> 
> IDE/ATA wizzards are kindly requested to have a look at:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4580#c21
> 
> as I have no idea of what we can do about the "hard drive password vs suspend"
> problem, if anything.

CONFIG_BLK_DEV_IDEACPI=y is not enough since IDE ACPI _GTF support is disabled
by default.  To enable it "ide=acpigtf" kernel parameter should be used.

Sometimes it may be also worth to try enabling usage of IDE ACPI methods on
boot ("ide=acpionboot" kernel parameter) which is also disabled by default.

We probably should switch both options to be on by default if recent libata
transition to ACPI on by default turns out to be successful.

PS I've updated bug #4580 accordingly.

Thanks,
Bart
