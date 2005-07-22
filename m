From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serverworks should not take ahold of megaraid'd
	controllers
Date: Fri, 22 Jul 2005 01:46:33 +0100
Message-ID: <1121993194.854.14.camel@localhost.localdomain>
References: <42E023B2.5030900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from clock-tower.bc.nu ([81.2.110.250]:21705 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261929AbVGVAWM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jul 2005 20:22:12 -0400
In-Reply-To: <42E023B2.5030900@us.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, AJ Johnson <blujuice@us.ibm.com>

On Iau, 2005-07-21 at 15:37 -0700, Darrick J. Wong wrote:
> I've noticed what might be a small bug with the serverworks driver in
> 2.6.12.3.  The IBM HS20 blade has a ServerWorks CSB6 IDE controller with
> an optional LSI MegaIDE RAID BIOS (BIOS assisted software raid, iow).

With a binary only proprietary driver.

> (ServerWorks) to IBM.  However, the serverworks driver doesn't notice
> this and will attach to the controller anyway, thus allowing raw access
> to the disks in the RAID.  An unsuspecting user can then read and write
> whatever they want to the drive, which could very well degrade or
> destroy the array, which is clearly not desirable behavior.

It may be appropriate for some vendor situations but it isn't
appropriate for the base kernel to default to assuming the user wants to
use binary only drivers instead of dmraid. Especially as the raid
formats for this hardware are partially known despite no assistance I
know of from the vendor.

Alan

