From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: [RFC]add ACPI hooks for IDE suspend/resume
Date: Thu, 8 Dec 2005 07:19:16 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F101082733@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fmr18.intel.com ([134.134.136.17]:442 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030443AbVLGXTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2005 18:19:36 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, akpm <akpm@osdl.org>

Hi,
>
>On Wed, Dec 07, 2005 at 11:43:23PM +0100, Pavel Machek wrote:
>
>> If someone swapped the drive while runtime, it would not be true,
too,
>> I guess. But that would be stupid thing to do. Swapping drive during
>> suspend-to-RAM would be similary stupid. During suspend-to-disk, it
>> might theoretically work, but we have big warnings saying "don't do
>> that".
>
>ACPI systems tend to fire ACPI notifications when a drive is ejected
>(and sometimes when you're preparing to eject them, depending on the
>system), which ought to make hotswap possible. I'm looking at
>integrating support for that into libata right now.
If the system supports S3/S4 hotswap, the corresponding ACPI resume
method
(_WAK in this case) will notify the hotswaped devices, so if the driver
can
handle the event, there is no problem for hotswap in suspend/resume.

Thanks,
Shaohua
