From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Bug #4580: hda: lost interrupt when resuming from S3 - Sony
 VGN-T1XP
Date: Sun, 7 Oct 2007 23:13:10 +0100
Message-ID: <20071007231310.559dbd01@the-village.bc.nu>
References: <200710072217.07656.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:46288 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752983AbXJGWI4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 7 Oct 2007 18:08:56 -0400
In-Reply-To: <200710072217.07656.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, 7 Oct 2007 22:17:06 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> IDE/ATA wizzards are kindly requested to have a look at:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=4580#c21
> 
> as I have no idea of what we can do about the "hard drive password vs suspend"
> problem, if anything.

libata supports the acpi interfaces but has them off by default. Turn
them on and it ought to just work assuming the BIOS does the right thing
and the BIOS knows the password.

