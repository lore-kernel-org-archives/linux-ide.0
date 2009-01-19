From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 6/6] SATA PIIX: Blacklist system that spins off disks during ACPI power off
Date: Mon, 19 Jan 2009 23:08:32 +0100
Message-ID: <200901192308.34456.elendil@planet.nl>
References: <20081104062734.GA4420@havoc.gtf.org> <200901192053.50831.rjw@sisk.pl> <200901192059.23448.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hpsmtp-eml18.KPNXCHANGE.COM ([213.75.38.118]:18961 "EHLO
	hpsmtp-eml18.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751843AbZASWIh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 17:08:37 -0500
In-Reply-To: <200901192059.23448.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jeff Garzik <jeff@garzik.org>, tj@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 19 January 2009, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Some notebooks from HP have the problem that their BIOSes attempt to
> spin down hard drives before entering ACPI system states S4 and S5.
> This leads to a yo-yo effect during system power-off shutdown and the
> last phase of hibernation when the disk is first spun down by the
> kernel and then almost immediately turned on and off by the BIOS.
> This, in turn, may result in shortening the disk's life times.
>
> To prevent this from happening we can blacklist the affected systems
> using DMI information.
>
> Blacklist HP 2510p that uses the ata_piix driver.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

As I have a system that is affected by this and as I have been a happy 
user of this patch for 4 months or so, it may make sense to add my

Tested-by: Frans Pop <elendil@planet.nl>

Same goes indirectly for the rest of the series, except for patch 5.
