From: Mark Lord <kernel@teksavvy.com>
Subject: Re: AMD 890GX vs 6Gbps SATA?
Date: Tue, 16 Nov 2010 09:31:35 -0500
Message-ID: <4CE295C7.7090808@teksavvy.com>
References: <2DEEA3AB13739D45A22ADDB5086AEA0B915107@sshaexmb1.amd.com>	<1E8B869C0C6913418421A406C094DF7C82D812@sshaexmb1.amd.com>	<m339r2lf9b.fsf@jhcloos.com>	<1E8B869C0C6913418421A406C094DF7C82D954@sshaexmb1.amd.com>	<m3r5emjyv1.fsf@jhcloos.com> <4CE179B4.4090404@hardwarefreak.com>	<m3fwv2ju9y.fsf@jhcloos.com> <4CE18B20.3050209@hardwarefreak.com> <m3aalajry7.fsf@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:11268 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932620Ab0KPObi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Nov 2010 09:31:38 -0500
In-Reply-To: <m3aalajry7.fsf@jhcloos.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: James Cloos <cloos@jhcloos.com>
Cc: Stan Hoeppner <stan@hardwarefreak.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 10-11-15 02:40 PM, James Cloos wrote:
>>>>>> "SH" == Stan Hoeppner<stan@hardwarefreak.com>  writes:
>
>>> *    Gen3 signaling speed (6.0Gb/s)
>
> SH>  That's what I was looking for--confirms it's def a 6Gb drive.
>
> Yes.
>
> And thanks for the reminder that hdparm -I is no longer a raw (and
> wrong-endian) dump of the -i info.  I'd forgotten that.  It even
> works on my usb-storage backup drive, where hdparm -i fails.

Heh heh.

Just for historical background, the reason they work(ed) that way,
is hdparm was originally written (by me) for testing the new Linux IDE
driver subsystem.  Well, okay, it *was* "new" back in the mid-90s.  :)

The -i reported what the device driver probed from the drive at boot time,
and -I always interrogated the drive itself, and displayed the raw data
exactly as the drive reported it.  Thus, for some early drives, the data
looked good, and for others it was byte-swapped.

Eventually ATA standardization kicked in, and all modern drives now agree
on the correct byte-ordering, so I changed -I to give human readable output.  :)

Cheers
