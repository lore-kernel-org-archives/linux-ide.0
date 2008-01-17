From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] libata: add enclosure management support
Date: Thu, 17 Jan 2008 16:50:42 -0600
Message-ID: <1200610243.3255.47.camel@localhost.localdomain>
References: <20080115164417.4a5e2789@appleyard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from accolon.hansenpartnership.com ([76.243.235.52]:36064 "EHLO
	accolon.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762183AbYAQWu7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Jan 2008 17:50:59 -0500
In-Reply-To: <20080115164417.4a5e2789@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

On Tue, 2008-01-15 at 16:44 -0800, Kristen Carlson Accardi wrote:
> Add Enclosure Management support to libata and ahci.
> 
> This patch adds support for the LED protocol, as defined in the AHCI spec.
> It adds a generic em_message and em_type sysfs entry per host.  It also adds
> a sw_activity field per existing drive.
> 
> The em_message field can be used by the driver to take enclosure management
> commands from userspace.  In the case of the LED protocol, writes and reads
> from em_message correspond to the LED message format as defined in the 
> AHCI spec.
> 
> em_message type is a read only file that displays the current enclosure
> management protocol that is used by the driver.
> 
> sw_activity is used by drivers which support software controlled activity LEDs.
> It has the following valid values:
> 
> 0	OFF - the LED is not activated on activity
> 1	BLINK_ON - the LED blinks on every 10ms when activity is detected.
> 2	BLINK_OFF - the LED is on when idle, and blinks off every 10ms when
> 		    activity is detected.
> 
> It's important to note that the user must turn sw_activity OFF it they wish
> to control the activity LED via the em_message file.

One of the things we really need to do is to get some type of generic
enclosure support.  I note that ahci support three standard eclosure
management protocols (SAF-TE, SES-2, SFF-8485 SGPIO) as well as the one
proprietary one you've chosen to implement.  Is that because no-one in
the field has actually connected AHCI up to anything supporting one of
the standard protocols?

I'm looking at this from slightly the other way around:  the SAS
protocol is virtually mandating SFF-8485 as the enclosure protocol to
the point that it's actually built into the sas management protocol ...
I was starting to wonder how we should be taking advantage of this.

The implementation probably should be generic (above SCSI or IDE or ATA)
but it would obviously need to tap into the subsytem/transport/device
specific pieces, so possibly block looks to be the right place to start?

James


