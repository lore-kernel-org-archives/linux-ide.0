From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] libata: add Samsung HD401LJ to the NCQ blacklist
Date: Wed, 18 Apr 2007 08:35:53 -0600
Message-ID: <46262CC9.7080909@shaw.ca>
References: <fa.G71hHcdM3hwHRXkWS6Y2qKY+vVo@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31527 "EHLO
	pd3mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992645AbXDROgW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Apr 2007 10:36:22 -0400
In-reply-to: <fa.G71hHcdM3hwHRXkWS6Y2qKY+vVo@ifi.uio.no>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: max@duempel.org

Max Kellermann wrote:
> Yet another hard drive which doesn't seem to get NCQ right.
> 
>  ata1: EH in ADMA mode, notifier 0x0 notifier_error 0x0 gen_ctl
>  0x1501000 status 0x400 next cpb count 0xB next cpb idx 0x0
>  [...]
>  ata1: timeout waiting for ADMA IDLE, stat=0x400
>  ata1: timeout waiting for ADMA LEGACY, stat=0x400
>  ata1.00: exception Emask 0x0 SAct 0x3fff SErr 0x200000 action 0x2
>  frozen
>  [...]
>  ata1: soft resetting port

Don't know if I noticed this before, but the controller seems to be 
reporting an SError, looks like a link layer CRC error. This could be a 
potential symptom of the drive and controller just not getting along, 
but you might want to try a different SATA cable as well.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

