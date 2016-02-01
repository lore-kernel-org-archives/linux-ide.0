From: Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v2] ata: add AMD Seattle platform driver
Date: Mon, 1 Feb 2016 16:15:59 -0600
Message-ID: <56AFD91F.4030008@amd.com>
References: <1452789071-4090-1-git-send-email-brijesh.singh@amd.com>
 <3904852.c3HykPsQQ2@wuerfel> <56AFAA46.6090403@amd.com>
 <5709817.yQT8N3CaLj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bn1bon0082.outbound.protection.outlook.com ([157.56.111.82]:18688
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753880AbcBAWSg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Feb 2016 17:18:36 -0500
In-Reply-To: <5709817.yQT8N3CaLj@wuerfel>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: brijesh.singh@amd.com, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, hdegoede@redhat.com, linux-ide@vger.kernel.org, Graeme Gregory <graeme@xora.org.uk>

Hi,

> 
> This is where we really need the ACPI maintainers to explain the
> general policy for dealing with firmware updates.
> 
> I would assume that adding the feature in a later firmware version
> is a compatible change, and the feature is non-essential (the
> device will work fine with the generic SATA driver, except
> the LEDs don't blink), so it's not a big deal, it's just what
> you get for having the firmware shipped before the driver is
> reviewed (don't do that).
> 

Agreed, the driver should have been reviewed earlier. And now changes in firmware will also require
them changing other OSes drivers.

Just speaking my mind, maybe server folks will be fine without activity LED but I think "locate" and "fault" LEDs is needed.

-Brijesh

> 	Arnd
> 
