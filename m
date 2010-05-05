From: Tejun Heo <tj@kernel.org>
Subject: Re: New entry for storage-fixup.conf: Belinea home.pc 1xs = Pegatron
 Cape 7 - Corrected and completed version
Date: Wed, 05 May 2010 15:49:20 +0200
Message-ID: <4BE17760.2090908@kernel.org>
References: <201004111236.24103.ms@mschilling.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55578 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760112Ab0EENta (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 5 May 2010 09:49:30 -0400
In-Reply-To: <201004111236.24103.ms@mschilling.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Monika Schilling <ms@mschilling.com>
Cc: linux-ide@vger.kernel.org

Hello,

On 04/11/2010 01:36 PM, Monika Schilling wrote:
> The Belinea home.pc 1xs = Pegatron Cape 7 is a nettop.
> 
> Without storage-fixup the "load cycle count" under idle condition
> increased by 19 in 10 minutes, that is about 114 per hour. Setting
> the disk APM level to 254 resulted in no more increase.

Ouch, that's a lot.

> Model Family:     Seagate Momentus 5400.5 series
> Device Model:     ST9160310AS

The family is rated at >600,000 load cycle.  I have no idea how high
that '>' means tho.  The drive will reach the limit after about ~0.6
years of uptime which is rather quick.

> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: To Be Filled By O.E.M.
>         Product Name: To Be Filled By O.E.M.
>         Version: To Be Filled By O.E.M.
>         Serial Number: To Be Filled By O.E.M.
>         UUID: E0DD7A77-8DFE-D511-92CC-00248CA78567
>         Wake-up Type: Power Switch
>         SKU Number: To Be Filled By O.E.M.
>         Family: To Be Filled By O.E.M.
> 
> Handle 0x0002, DMI type 2, 15 bytes
> Base Board Information
>         Manufacturer: To be filled by O.E.M.
>         Product Name: To be filled by O.E.M.
>         Version: To be filled by O.E.M.
>         Serial Number: MS1C94D17W00138
>         Asset Tag: To Be Filled By O.E.M.
>         Features:
>                 Board is a hosting board
>                 Board is replaceable
>         Location In Chassis: To Be Filled By O.E.M.
>         Chassis Handle: 0x0003
>         Type: Motherboard
>         Contained Object Handles: 0
> 
> Handle 0x0003, DMI type 3, 21 bytes
> Chassis Information
>         Manufacturer: To Be Filled By O.E.M.
>         Type: Desktop
>         Lock: Not Present
>         Version: To Be Filled By O.E.M.
>         Serial Number: To Be Filled By O.E.M.
>         Asset Tag: To Be Filled By O.E.M.
>         Boot-up State: Safe
>         Power Supply State: Safe
>         Thermal State: Safe
>         Security Status: None
>         OEM Information: 0x00000000
>         Height: Unspecified
>         Number Of Power Cords: 1
>         Contained Elements: 0

Unfortunately, your system is not identifiable.  Maybe the whole drive
series should be added as an entry.  At this point, I don't really
have much idea.  If vendors think that this default is good, maybe it
is.  :-(

-- 
tejun
