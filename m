From: Jerome Vuarand <jerome.vuarand@gmail.com>
Subject: Re: SiI3124 + SiI3726 pm
Date: Mon, 27 Jul 2009 20:03:08 +0200
Message-ID: <89d273ba0907271103s787b5f06t514c219d4a551d53@mail.gmail.com>
References: <89d273ba0605242046x3d19dd06h74885048f229d519@mail.gmail.com>
	<89d273ba0605242202l354ec106w22bccf649e5e1dfc@mail.gmail.com>
	<44753B78.4090802@gmail.com> <c70ff3ad0605251329m34af33bfj3ace5d5f9b32af38@mail.gmail.com>
	<44761994.2050303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:45835 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732AbZG0SD3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Jul 2009 14:03:29 -0400
Received: by ewy26 with SMTP id 26so3374445ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Jul 2009 11:03:28 -0700 (PDT)
In-Reply-To: <44761994.2050303@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: saeed bishara <saeed.bishara@gmail.com>, Tejun Heo <htejun@gmail.com>

2006/5/25 Tejun Heo <htejun@gmail.com>:
> saeed bishara wrote:
>>
>> Hi,
>>      I think the 6th port is for the SEMB(Sata Enclosure Management
>> Bridge) device, this device reportssignature with lbam=0x3c and lbah
>> 0xc3, but the linux classifies it as a disk:
>>
>>  if (((tf->lbam == 0) && (tf->lbah == 0)) ||
>>  ((tf->lbam == 0x3c) && (tf->lbah == 0xc3))) {
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> DPRINTK("found ATA device by sig\n");
>> return ATA_DEV_ATA;
>>
>> Can you print the signature of the device on that port?
>> Anyway, the 0x3C, 0xC3 signature should be classifies as a SEMB device
>> and not a disk according to the SATA standard.
>
> I haven't actually checked that signature but that's probably the same class
> code mix up described for PM in the classification function.  For the time
> being, libata is just ignoring the extra port.  It probably should be
> exported as a SCSI device without HLD attached (/dev/sgX only).  I'll try
> that once hotplug stuff settles.

A few months ago I updated my kernel since it now supports port
multipliers without patch, and the issue of a supplementary port on
the SiI3727 port multiplier rose again. Since I completely forgot
about that 3 year old issue, I started exploring the web again before
remembering that thread.

I found something interesting in the SiI3726 datasheet
(http://www.siliconimage.com/docs/SiI-DS-0121-C1.pdf). You can see on
PDF page 14/41, in the description of the GSCR[2] register, that the 4
least significant bits of the register are labelled "Number of Fan-out
ports". In the description besides, it is explained that the initial
value is 6, and it represents the 5 downstream device ports plus the
upstream host port.

I don't have access to the SATA Port Multiplier specification, but it
would be interesting to check it to verify whether that 4-bit field of
the GSCR[2] register is supposed to contain the number of device ports
(and in that case the problem comes from the SiI3726 firmware) or if
that value is the total number of up+down ports of the multiplier. In
the latter case another mechanism to detect the number of device ports
would be needed (unless multipliers can have several host ports, for
multipath or device sharing, a simple substraction of 1 could be
enough).

In the meantime I'll re-apply the patch Tejun Heo proposed earlier in
that thread. It seems I didn't notice Saeed Bishara request for tests
last time. Tell me if you're still interested in that information, or
if you need any other information to help improve the SiI3726 driver.
I have 6 of these port multipliers (and I suspect some of these are
damaged), and 15 to 20 SATA disks available, so there's plenty of room
for tests.
