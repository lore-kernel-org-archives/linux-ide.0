From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 13345] panic when reading data from IDE CDROM with >= 2.6.29
 kernels
Date: Thu, 21 May 2009 20:48:34 GMT
Message-ID: <200905212048.n4LKmYcS009564@demeter.kernel.org>
References: <bug-13345-11633@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:46824 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbZEUUsc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2009 16:48:32 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.2/8.14.2) with ESMTP id n4LKmYN2009565
	for <linux-ide@vger.kernel.org>; Thu, 21 May 2009 20:48:34 GMT
In-Reply-To: <bug-13345-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=13345





--- Comment #9 from Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>  2009-05-21 20:48:33 ---
On Thursday 21 May 2009 22:25:02 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13345
> 
> 
> 
> 
> 
> --- Comment #8 from Modestas Vainius <modestas@vainius.eu>  2009-05-21 20:25:02 ---
> Created an attachment (id=21473)
 --> (http://bugzilla.kernel.org/attachment.cgi?id=21473)
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

-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
