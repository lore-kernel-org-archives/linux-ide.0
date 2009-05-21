From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29 kernels
Date: Thu, 21 May 2009 22:53:07 +0200
Message-ID: <200905212253.08219.bzolnier@gmail.com>
References: <bug-13345-11633@http.bugzilla.kernel.org/> <200905212025.n4LKP2kV007842@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64917 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743AbZEUUsa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 16:48:30 -0400
Received: by fxm2 with SMTP id 2so1282189fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 13:48:31 -0700 (PDT)
In-Reply-To: <200905212025.n4LKP2kV007842@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Thursday 21 May 2009 22:25:02 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> 
> 
> 
> --- Comment #8 from Modestas Vainius <modestas@vainius.eu>  2009-05-21 20:25:02 ---
> Created an attachment (id=21473)
>  --> (http://bugzilla.kernel.org/attachment.cgi?id=21473)
> dmesg of 2.6.30-rc6-git5 + patch with CDROM as hdc and hdd
> 
> No errors with CDROM as hdc plugged to middle connector of the cable.
> DMA problems with CDROM as hdd plugged to end connector of the cable.
> I have not tested other combinations.
> 
> My cable is 40-wire (all connectors are black, I counted the wires too).

Sigh...  it is detected as 80-wire...

This is nVidia PATA controller with broken cable detection.

In ide we just use BIOS data, libata looks at both BIOS and ACPI data
(though it may not help at all actually)...

Anyway the following change needs to be ported to amd74xx.c one day:

"pata_amd: update mode selection for NV PATAs"
(commit ce54d1616302117fa98513ae916bb3333e1c02ea)
